#!/bin/bash

# Have command error out on any command failure
set -e

command -v brew >/dev/null 2>&1 || { echo >&2 "Homebrew not installed, ACT3 Auth Refresh requires Homebrew. Aborting."; exit 1; }

# Default XDG_CACHE_HOME
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# Create log file
timestamp=$(date "+%Y-%m-%d_%H:%M:%S")
LOG_FILE="$XDG_CACHE_HOME/act3-auth-refresh/logs_$timestamp"
mkdir -p "$XDG_CACHE_HOME/act3-auth-refresh" && touch "$LOG_FILE"
echo "Logs: $LOG_FILE"
echo ""

# Read Personal Access Token
# TODO: link to PAT docs? maybe from dubdubdub
echo "Navigate to \"https://git.act3-ace.com/-/profile/personal_access_tokens\""
echo "Create a GitLab Personal Access Token with \"api\" scope"
read -r -p "Enter Username>" USERNAME
read -s -r -p "Enter Token>" TOKEN
echo ""

# TODO: how to check if token is same, but power through for now

# Use yq to add credsStore field to ~/.docker/config.json
echo "Checking for yq"
command -v yq >/dev/null 2>&1 || { echo "Installing yq for auth use."; brew install yq > "$LOG_FILE"; }

CREDS_STORE="secretservice"
if [[ "$OSTYPE" == "darwin"* ]]; then
	CREDS_STORE="osxkeychain"
fi

echo "Setting credsStore field in $HOME/.docker/config.json to \"$CREDS_STORE\""
yq -e -i -o=json ".credsStore = \"$CREDS_STORE\"" "$HOME/.docker/config.json"

# Podman Credential Helper Config
# https://docs.podman.io/en/latest/markdown/podman-login.1.html

# Default podman registries.conf path
# XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
# PODMAN_CONFIG="$XDG_CONFIG_HOME/containers/registries.conf"
# echo "credential-helpers="

# Steps: registries.conf, credHelpers?, containers/auth.json, 
# Process: create .docker/config.json, do what already doing, credsStore and add credHelper for reg.git.act3-ace.com
# registries.conf has a line that is a credential helpers whitelist that needs updated
# https://docs.docker.com/engine/reference/commandline/login/#credential-helpers
# https://github.com/containers/image/blob/main/docs/containers-registries.conf.5.md#example
# ^ if you wanna get clever, add the unqualified-search-registries for docker.io

# TODO: use docker credential helper instead of crane <-- don't, crane checks the login for success, that is a value add
# Use crane to log in to reg.git.act3-ace.com
echo "Checking for crane"
command -v crane >/dev/null 2>&1 || { printf "\tInstalling crane for auth use\n"; brew install crane > "$LOG_FILE"; }

echo "Logging into the GitLab Container Registry with crane"
printf '%s\n' "$TOKEN" | crane auth login reg.git.act3-ace.com -u "$USERNAME" --password-stdin

# TODO: is this linux-specific?
echo "Checking for git-credential-libsecret"
if [[ "$OSTYPE" == "linux-gnu" ]]; then
	command -v git-credential-libsecret >/dev/null 2>&1 || { printf "\tInstalling git-credential-libsecret for git authentication.\n"; brew install git-credential-libsecret > "$LOG_FILE"; }
	git config --global credential.helper libsecret
elif [[ "$OSTYPE" == "darwin"* ]]; then
	command -v git-credential-libsecret >/dev/null 2>&1 || { printf "\tInstalling git-credential-libsecret for git authentication.\n"; brew install git-credential-libsecret > "$LOG_FILE"; }
	git config --global credential.helper keychain
fi

# TODO: GIT CREDENTIAL STORAGE SETUP
# call git-credential-libsecret


# Tap act3/ace-tools if not already tapped
echo "Checking for the act3/ace-tools Homebrew Tap"
[[ $(brew tap) =~ "act3/ace-tools" ]] || { printf "\tAdding the act3/ace-tools Homebrew Tap\n"; brew tap act3/ace-tools git@git.act3-ace.com:ace/homebrew-ace-tools.git; }

# Install act3-pt and log in to git.act3-ace.com
echo "Checking for act3-pt"
command -v act3-pt >/dev/null 2>&1 || { echo "Installing act3-pt."; brew install act3-pt > "$LOG_FILE"; }

echo "Logging in with act3-pt"
printf '%s\n' "$TOKEN" | act3-pt login --name act3 --url git.act3-ace.com
# "Error: inappropriate ioctl for device"

# TODO: have project tool check token and its scope


# TODO: ACE Hub JSON config generation


# TODO: validation?


# TODO: have script track so if an error happened