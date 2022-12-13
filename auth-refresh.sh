#!/bin/bash

# Have command error out on any command failure
set -e

command -v brew >/dev/null 2>&1 || { echo -e "Homebrew not installed, install Homebrew with the following command:\n\n/bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"\n\nAborting."; exit 1; }

# Set no auto update for this script
export HOMEBREW_NO_AUTO_UPDATE=1

bold=$(tput bold)
normal=$(tput sgr0)

echo "           _____ ______ 
     /\   / ____|  ____|
    /  \ | |    | |__   
   / /\ \| |    |  __|  
  / ____ \ |____| |____ 
 /_/    \_\_____|______|
"

recycle='\U267B'
echo -e "${recycle} ${bold}Welcome to ACE Auth Refresh. Let's update your system's authentication to ACE services!${normal}"

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
# TODO: check if token is same, but power through for now
key='\U1F511'
echo -e "${key} ${bold}Create GitLab Personal Access Token${normal}"
echo -e "1. Navigate to \U1F517 ${bold}https://git.act3-ace.com/-/profile/personal_access_tokens${normal}"
echo "2. Create a GitLab Personal Access Token with \"api\" scope"
echo "3. Enter your username and token:"
read -r -p "       Enter Username>" USERNAME
read -s -r -p "       Enter Token>" TOKEN
echo ""

# GITLAB CONTAINER REGISTRY CREDENTIALS
ship='\U1F6A2'
echo -e "\n${ship} ${bold}Setting up credentials for the ACT3 GitLab Container Registry${normal}"

echo -e "Checking for dependencies:"

echo -e "\tChecking for docker-credential-helper... "
command -v docker-credential-secretservice >/dev/null 2>&1 || command -v docker-credential-osxkeychain >/dev/null 2>&1 || { echo -e "\tInstalling docker-credential-helper"; brew install docker-credential-helper > "$LOG_FILE"; }

# Use yq to add credsStore field to ~/.docker/config.json
echo -e "\tChecking for yq... "
command -v yq >/dev/null 2>&1 || { echo -e "\tInstalling yq"; brew install yq > "$LOG_FILE"; }

# Use crane to log in to reg.git.act3-ace.com (crane checks login)
# using crane because it checks the login for success, otherwise we would just use the credential helper
echo -e "\tChecking for crane... "
# command -v crane >/dev/null 2>&1 || { echo "    Installing crane for auth use"; brew install crane > "$LOG_FILE"; }
command -v crane >/dev/null 2>&1 || { echo -e "\tInstalling crane"; brew install crane > "$LOG_FILE"; }

CREDS_STORE="secretservice"
if [[ "$OSTYPE" == "darwin"* ]]; then
	CREDS_STORE="osxkeychain"
fi

echo "Configuring registry authentication to use \"$CREDS_STORE\" ($HOME/.docker/config.json)"
mkdir -p "$HOME/.docker"
touch -a "$HOME/.docker/config.json" # -a tells touch to only change the "access" and "change" times
yq -e -i -o=json ".credsStore = \"$CREDS_STORE\"" "$HOME/.docker/config.json"
yq e -i -o=json ".credHelpers.\"reg.git.act3-ace.com\" = \"$CREDS_STORE\"" "$HOME/.docker/config.json"

# Podman Credential Helper Config
# https://docs.podman.io/en/latest/markdown/podman-login.1.html

# Default podman registries.conf path
# XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
# PODMAN_CONFIG="$XDG_CONFIG_HOME/containers/registries.conf"
# echo "credential-helpers="

# Steps: registries.conf, credHelpers?, containers/auth.json, 
# Process: create .docker/config.json, do what already doing, credsStore and add credHelper for reg.git.act3-ace.com
# registries.conf has a line that is a credential helpers whitelist that needs updated? Maybe not true?
# https://docs.docker.com/engine/reference/commandline/login/#credential-helpers
# https://github.com/containers/image/blob/main/docs/containers-registries.conf.5.md#example
# ^ if you wanna get clever, add the unqualified-search-registries for docker.io

echo "Logging into the ACT3 GitLab Container Registry with crane (reg.git.act3-ace.com)"
printf '%s\n' "$TOKEN" | crane auth login reg.git.act3-ace.com -u "$USERNAME" --password-stdin > "$LOG_FILE"

# GIT CREDENTIAL STORAGE SETUP
echo -e "\n\U1F510 ${bold}Setting up git credentials for the ACT3 GitLab Instance${normal}"

# https://git-scm.com/book/en/v2/Git-Tools-Credential-Storage
echo "Checking for git-credential-helper... "
GIT_CREDENTIAL_HELPER="credential-libsecret"
if [[ "$OSTYPE" == "linux-gnu" ]]; then
	command -v git-credential-libsecret >/dev/null 2>&1 || { echo -e "\tInstalling git-credential-libsecret"; brew install git-credential-libsecret > "$LOG_FILE"; }
	GIT_CREDENTIAL_HELPER="libsecret"
elif [[ "$OSTYPE" == "darwin"* ]]; then
	# I think MacOS comes with this pre-installed or it's part of git?
	GIT_CREDENTIAL_HELPER="osxkeychain"
fi

echo "Configuring git to use credential helper \"$GIT_CREDENTIAL_HELPER\""
git config --global credential.helper "$GIT_CREDENTIAL_HELPER" > "$LOG_FILE"

echo "Storing credentials for git (git.act3-ace.com)"
printf 'protocol=https\nhost=git.act3-ace.com\nusername=%s\npassword=%s\n' "$USERNAME" "$TOKEN" | git "credential-$GIT_CREDENTIAL_HELPER" store > "$LOG_FILE"


# ACE TOOLS HOMEBREW TAP
echo -e "\n\U1F37B ${bold}Setting up the ACE Tools Homebrew Tap${normal}"

# Tap act3/ace-tools if not already tapped
echo "Checking for the act3/ace-tools Homebrew Tap... "
[[ $(brew tap) =~ "act3/ace-tools" ]] || { echo -e "Adding the act3/ace-tools Homebrew Tap"; brew tap act3/ace-tools git@git.act3-ace.com:ace/homebrew-ace-tools.git > "$LOG_FILE"; }
echo -e "act3/ace-tools tap added, check available formulas with \"brew tap-info act3/ace-tools --json | jq .[0].formula_names\""

# GITLAB API CREDENTIALS FOR PROJECT TOOL
echo -e "\n\U1F9DE ${bold}Setting up GitLab API Credentials for ACT3 Project Tool (act3-pt)${normal}"

# Install act3-pt and log in to git.act3-ace.com
echo "Checking for act3-pt... "
command -v act3-pt >/dev/null 2>&1 || { echo -e "\tInstalling act3-pt"; brew install act3-pt > "$LOG_FILE"; }

echo "Logging in with act3-pt"
printf '%s\n' "$TOKEN" | act3-pt login --name act3 --url git.act3-ace.com --token-stdin > "$LOG_FILE"

# ACE HUB USER CONFIGURATION
echo -e "\n\U1F52C ${bold}Creating ACE Hub User Configuration file${normal}"

# create with cat >> EOF
# example is in devops docs: https://git.act3-ace.com/devsecops/devsecops.git.act3-ace.com/-/blob/master/docs/ops/k8s-auth/create_user_kubeconfig.sh#L28
# TODO: put this in XDG_RUNTIME_DIR
# Default XDG_RUNTIME_DIR
XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/tmp}"
ACE_HUB_USER_FILE="$XDG_RUNTIME_DIR/ace/hub.json"

mkdir -p "$XDG_RUNTIME_DIR/ace"
touch -a "$ACE_HUB_USER_FILE"

echo -e "Creating user configuration file ${bold}\"$ACE_HUB_USER_FILE\"${normal}"
cat <<EOF > "$ACE_HUB_USER_FILE"
{
	"env": {
		"GIT_PASSWORD": "$USERNAME:$TOKEN"
	},
	"envFiles": {
		"NETRC": "machine git.act3-ace.com login $USERNAME password $TOKEN"
	},
	"ips": {
		"act3": {
			"registry": "reg.git.act3-ace.com",
			"username": "$USERNAME",
			"password": "$TOKEN"
		}
	},
	"userLaunchTemplates": {}
}
EOF
echo "Import this user configuration file in ACE Hub to set up your credentials"

echo ""
echo -e "\U1F6EB ${bold}Authenticated!${normal}"
