#!/usr/bin/env bash

set -e  # Exit immediately if a command exits with a non-zero status

# Function to replace a string in a file
replace_str() {
    local file=$1
    local search=$2
    local replace=$3
    sed -i.bak "s/$search/$replace/g" "$file" && rm "$file.bak"
}

# Function to prompt the user for input
prompt_input() {
    local var_name=$1
    local prompt_msg=$2
    read -r -p "$prompt_msg: " "${var_name?}"
}

# Check if all arguments are provided
if [[ $# -eq 4 ]]; then
    PROJECT_NAME=$1
    DESCRIPTION=$2
    DEV_NAME=$3
    DEV_EMAIL=$4
else
    prompt_input PROJECT_NAME "Enter the PROJECT_NAME"
    prompt_input DESCRIPTION "Enter the DESCRIPTION"
    prompt_input DEV_NAME "Enter the DEV_NAME"
    prompt_input DEV_EMAIL "Enter the DEV_EMAIL"
fi

# Validate input
if [[ -z "$PROJECT_NAME" || -z "$DESCRIPTION" || -z "$DEV_NAME" || -z "$DEV_EMAIL" ]]; then
    echo "Error: All variables must be set."
    exit 1
fi

# Files to be modified
files=("flake.nix" "nix-modules/horizon-haskell.nix" "horizon-template.cabal")

# Replace strings in files
for file in "${files[@]}"; do
    replace_str "$file" "PROJECT_NAME" "$PROJECT_NAME"
done

replace_str "flake.nix" "DESCRIPTION" "$DESCRIPTION"
replace_str "horizon-template.cabal" "DEV_NAME" "$DEV_NAME"
replace_str "horizon-template.cabal" "DEV_EMAIL" "$DEV_EMAIL"

# Rename horizon-template.cabal to PROJECT_NAME.cabal
mv "horizon-template.cabal" "${PROJECT_NAME}.cabal"

echo "Modification complete."


