#!/bin/bash

# This script tears down the retail store application using Terraform.
#
# Usage: ./retail-store-tf-destroy.sh <environment>
#   e.g. ./retail-store-tf-destroy.sh dev
#
# This is the mirror image of retail-store-tf-install.sh: the application
# modules are destroyed first and the vpc module last, because the application
# modules attach security groups and subnets to the VPC and AWS refuses to
# delete a VPC while those still exist.
#
# The vpc_id is read out of the vpc state up front, while the vpc is still
# standing, because the application modules need it to evaluate their
# configuration before they can be destroyed.

set -euo pipefail

base_dir=$(cd "$(dirname "$0")" && pwd)
environment="${1:-}"
root_module_dir="$base_dir/terraform/$environment/retail-store-app-aws"

# The vpc module every other module depends on, so it is destroyed last
vpc_module="vpc"
# Modules destroyed before the vpc module
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

# Destroys a single module. Any extra arguments are passed straight through to
# terraform destroy, which is how vpc_id reaches the application modules.
# Runs in a subshell so the cd does not leak into the caller's loop.
destroy_module() {
    local module="$1"
    shift
    local module_dir="$root_module_dir/$module"

    if [ ! -d "$module_dir" ]; then
        echo "Module directory $module_dir does not exist. Please check your environment and module configuration."
        return 1
    fi

    echo ""
    echo "=============================================="
    echo "Destroying Terraform configuration for module: $module"
    echo "=============================================="

    (
        cd "$module_dir"
        terraform init -input=false
        terraform destroy -auto-approve -input=false "$@"
    )
}

# True when the module declares the given input variable. Used so we only pass
# -var vpc_id to modules that actually accept it: carts is DynamoDB only and
# would fail with "value for undeclared variable".
module_declares_var() {
    grep -qs "variable \"$2\"" "$root_module_dir/$1"/*.tf
}

# Step 1: read the vpc id while the vpc module is still applied. The
# application modules cannot be destroyed without it.
vpc_id=$(cd "$root_module_dir/$vpc_module" && terraform output -raw vpc_id 2>/dev/null) || vpc_id=""

if ! [[ "$vpc_id" =~ ^vpc-[0-9a-f]+$ ]]; then
    echo "Could not read a valid vpc_id from the $vpc_module module (got: '${vpc_id}')."
    echo "The vpc may already have been destroyed. If the application modules still"
    echo "have resources, destroy them by hand with -var \"vpc_id=<id>\"."
    exit 1
fi

echo "Tearing down environment: $environment (vpc_id = $vpc_id)"

# Step 2: the application modules, which are independent of each other.
failed_modules=()
for module in "${app_modules[@]}"; do
    module_args=()
    if module_declares_var "$module" "vpc_id"; then
        module_args=(-var "vpc_id=$vpc_id")
    else
        echo ""
        echo "Module $module does not declare a vpc_id variable, destroying without it."
    fi

    if ! destroy_module "$module" ${module_args[@]+"${module_args[@]}"}; then
        echo "Failed to destroy the $module module."
        failed_modules+=("$module")
    fi
done

# Step 3: the vpc module, but only once every application module is gone.
# Leftover security groups or subnets would make the VPC delete fail anyway.
if [ ${#failed_modules[@]} -ne 0 ]; then
    echo ""
    echo "The following modules failed to destroy: ${failed_modules[*]}"
    echo "Skipping the $vpc_module module, since its resources are still in use."
    exit 1
fi

if ! destroy_module "$vpc_module"; then
    echo "Failed to destroy the $vpc_module module."
    exit 1
fi

echo ""
echo "All modules destroyed successfully for environment: $environment"
