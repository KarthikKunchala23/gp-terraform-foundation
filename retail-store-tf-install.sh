#!/bin/bash

# This script is used to install the retail store application using Terraform
#
# Usage: ./retail-store-tf-install.sh <environment>
#   e.g. ./retail-store-tf-install.sh dev
#
# The vpc module is applied first and must succeed before any of the
# application modules are applied. Its vpc_id output is then read back and
# passed to every application module that declares a vpc_id variable, so the
# id never has to be hardcoded in a variables.tf file.
#
# To tear the environment back down, use retail-store-tf-destroy.sh, which
# walks the same modules in the reverse order.

set -euo pipefail

base_dir=$(cd "$(dirname "$0")" && pwd)
environment="${1:-}"
root_module_dir="$base_dir/terraform/$environment/retail-store-app-aws"

# The vpc module every other module depends on
vpc_module="vpc"
# Modules applied only after the vpc module has been applied successfully
app_modules=("carts" "catalog" "orders" "checkout")

if [ -z "$environment" ]; then
    echo "Usage: $(basename "$0") <environment>   e.g. $(basename "$0") dev"
    exit 1
fi

# Check if Terraform is installed
if ! command -v terraform &> /dev/null
then
    echo "Terraform could not be found. Please install Terraform before running this script."
    exit 1
fi

if [ ! -d "$root_module_dir" ]; then
    echo "Environment directory $root_module_dir does not exist. Please check the environment name."
    exit 1
fi

# Applies a single module. Any extra arguments are passed straight through to
# terraform apply, which is how vpc_id reaches the application modules.
# Runs in a subshell so the cd does not leak into the caller's loop.
apply_module() {
    local module="$1"
    shift
    local module_dir="$root_module_dir/$module"

    if [ ! -d "$module_dir" ]; then
        echo "Module directory $module_dir does not exist. Please check your environment and module configuration."
        return 1
    fi

    echo ""
    echo "=============================================="
    echo "Applying Terraform configuration for module: $module"
    echo "=============================================="

    (
        cd "$module_dir"
        terraform init -input=false
        terraform apply -auto-approve -input=false "$@"
    )
}

# True when the module declares the given input variable. Used so we only pass
# -var vpc_id to modules that actually accept it: carts is DynamoDB only and
# would fail with "value for undeclared variable".
module_declares_var() {
    grep -qs "variable \"$2\"" "$root_module_dir/$1"/*.tf
}

# Step 1: the vpc module. Everything else depends on it, so bail out on failure.
if ! apply_module "$vpc_module"; then
    echo "Failed to apply the $vpc_module module. Aborting before the application modules."
    exit 1
fi

# Step 2: read the vpc id back out of the freshly applied vpc state.
vpc_id=$(cd "$root_module_dir/$vpc_module" && terraform output -raw vpc_id 2>/dev/null) || vpc_id=""

if ! [[ "$vpc_id" =~ ^vpc-[0-9a-f]+$ ]]; then
    echo "Could not read a valid vpc_id from the $vpc_module module (got: '${vpc_id}')."
    echo "Check that $root_module_dir/$vpc_module/outputs.tf declares a vpc_id output."
    exit 1
fi

echo ""
echo "Module $vpc_module applied successfully. vpc_id = $vpc_id"
echo "Continuing with the application modules."

# Step 3: the remaining modules, which are independent of each other.
failed_modules=()
for module in "${app_modules[@]}"; do
    module_args=()
    if module_declares_var "$module" "vpc_id"; then
        module_args=(-var "vpc_id=$vpc_id")
    else
        echo ""
        echo "Module $module does not declare a vpc_id variable, applying without it."
    fi

    if ! apply_module "$module" ${module_args[@]+"${module_args[@]}"}; then
        echo "Failed to apply the $module module."
        failed_modules+=("$module")
    fi
done

echo ""
if [ ${#failed_modules[@]} -ne 0 ]; then
    echo "The following modules failed to apply: ${failed_modules[*]}"
    exit 1
fi

echo "All modules applied successfully for environment: $environment"
