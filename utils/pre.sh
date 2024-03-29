#!/usr/bin/env bash

############################################################
############################################################
# This is the setup component of the ACT3 Login Script
# Formatting tools and helper functions are set
# Use by adding the following line
#  to the beginning of your script:
# source <(curl -fsSL https://raw.githubusercontent.com/act3-ace/aceup/main/utils/pre.sh)
############################################################
############################################################

############################################################
# Global setup
############################################################

# Set no auto update for this script
# shellcheck disable=SC2034
HOMEBREW_NO_AUTO_UPDATE=1
HOMEBREW_PREFIX=$(brew --prefix)
curl="${HOMEBREW_PREFIX}/opt/curl/bin/curl"

############################################################
# Output formatting setup
############################################################

# Initialize text formatting shortcuts
bold=$(tput bold)
normal=$(tput sgr0)
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
green_check="${green}✓${normal}"
yellow_excl="${yellow}!${normal}"
red_x="${red}✗${normal}"

success() {
  echo "${green_check} ${1}"
}

warning() {
  echo "${yellow_excl} ${1}"
}

warning_yellow() {
  echo "${yellow_excl}${yellow} ${1}${normal}"
}

failure() {
  echo "${red_x} ${1}"
}

failure_red() {
  echo "${red_x}${red} ${1}${normal}"
}

############################################################
# Box outlines setup
############################################################

sanitize() {
  # https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html#:~:text=%24%7Bparameter//pattern/string%7D
  result="$1"
  result="${result//$bold/}"
  result="${result//$normal/}"
  result="${result//$red/}"
  result="${result//$green/}"
  result="${result//$yellow/}"
  echo "${result//$blue/}"
}

box_out() {
  # Initialize vars
  local s=("$@") b w

  # Iterate over arguments to find longest line and its length
  for l in "${s[@]}"; do
    # Sanitize line so format characters are not counted
    plain=$(sanitize "$l")
    ((w < ${#plain})) && {
      b="$plain"
      w="${#plain}"
    }
  done
  # Output top border by replacing characters in longest string with dash
  echo ".-${b//?/-}-."
  for l in "${s[@]}"; do
    # Calculate padding size without format characters
    plain=$(sanitize "$l")
    padding=$((w - ${#plain} + 1))
    printf '| %s%*s|\n' "$l" "-$padding" " "
  done
  # Output bottom border using same approach as top border
  echo "'-${b//?/-}-'"
}

double_box_out() {
  # Initialize vars
  local s=("$@") b w

  # Iterate over arguments to find longest line and its length
  for l in "${s[@]}"; do
    # Sanitize line so format characters are not counted
    plain=$(sanitize "$l")
    ((w < ${#plain})) && {
      b="$plain"
      w="${#plain}"
    }
  done
  # Output top border by replacing characters in longest string with dash
  echo "╔=${b//?/=}=╗"
  for l in "${s[@]}"; do
    # Calculate padding size without format characters
    plain=$(sanitize "$l")
    padding=$((w - ${#plain} + 1))
    printf '║ %s%*s║\n' "$l" "-$padding" " "
  done
  # Output bottom border using same approach as top border
  echo "╚=${b//?/=}=╝"
}

############################################################
# System Checks
############################################################

# Check if running macOS
is_macos() {
  [[ "$OSTYPE" == "darwin"* ]]
}

# Check if runnning Linux (true for WSL)
# shellcheck disable=SC2317
is_linux() {
  [[ "$OSTYPE" == "linux-gnu" ]]
}

# Check if running Linux on WSL
# shellcheck disable=SC2317
is_wsl() {
  is_linux &&
    # https://github.com/microsoft/WSL/issues/423#issuecomment-221627364
    [ -f /proc/version ] && grep -qi 'microsoft\|wsl' /proc/version
}

# Check if running Linux not on WSL
# shellcheck disable=SC2317
is_linux_no_wsl() {
  is_linux && ! is_wsl
}

# Checks /etc/os-release for "ubuntu"
is_ubuntu() {
  is_linux &&
    [ -f /etc/os-release ] && grep -qi 'ubuntu' /etc/os-release
}

# Checks /etc/os-release for "22.04" to determine if running Ubuntu 22.04
is_ubuntu_22() {
  is_ubuntu && grep -q '22.04' /etc/os-release
}

############################################################
# Log file and XDG Directories
############################################################

# System Check: Set XDG dirs and WSL variable
IS_WSL=false
if is_linux; then
  XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
  XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
  if is_wsl; then
    IS_WSL=true
  fi
elif is_macos; then
  XDG_CACHE_HOME="${XDG_CACHE_HOME:-"$HOME/Library/Caches"}"
  XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/Library/Application Support}"
else
  XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
  XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
fi

redact() {
  echo "${*/$TOKEN/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*}"
}

log_echo() {
  redact "$@" >>"$LOG_FILE"
}

log_eval() {
  log_echo ""
  log_echo "\$ $*"
  "$@" >>"$LOG_FILE" 2>&1
}

log_out() {
  log_echo ""
  log_echo "\$ $*"
  output=$("$@" 2>&1)
  exit_code=$?
  log_echo "$output"
  echo "$output"
  return "$exit_code"
}

create_log_file() {
  [ -f "$LOG_FILE" ] && rm "$LOG_FILE"                   # remove existing log file (if exists)
  mkdir -p "$(dirname "$LOG_FILE")" && touch "$LOG_FILE" # create new log file
  log_echo "Logs - $(date "+%D %T")"
  success "Created log file ${bold}${LOG_FILE}${normal}"
}

append_to_file() {
  mkdir -p "$(dirname "$1")" && touch -a "$1" # ensure file exists
  echo "$2" >>"$1"                            # concatenate to file
}

check_logs() {
  box_out "Check log file: ${bold}${LOG_FILE}${normal}" \
    "Troubleshooting: ${bold}https://github.com/act3-ace/aceup/blob/main/docs/troubleshooting-faq.md${normal}" \
    "Create Support Ticket: ${bold}https://git.act3-ace.com/ace/aceup/-/issues/new?issuable_template=Support%20Ticket${normal}"
}

abort() {
  echo "Aborting."
  echo
  check_logs
  exit 1
}

############################################################
# Homebrew functions
############################################################

# Ensures a Homebrew formula is installed
brew_install() {
  # Check if installed: brew list
  #  If installed, upgrade: brew upgrade
  #  If not installed, install: brew install
  if log_eval brew list "$1"; then
    success "${1} already installed"
    # Formula is already installed, upgrade it
    log_eval brew upgrade "$1" || warning "Could not upgrade ${1}. Check log file: ${bold}${LOG_FILE}${normal}"
  else
    # Formula is not installed, install it
    if output=$(log_out brew install "$1"); then
      success "Installed $1"
    else
      failure_red "Failed to install required dependency ${1}."
      echo
      echo "Output of ${bold}brew install ${1}${normal}:"
      echo "$output"
      echo
      abort # Fail if dependency cannot be met
    fi
  fi
}

# Upgrades a homebrew dependency if it is installed
brew_upgrade() {
  # Check if installed: brew list
  #  If installed, upgrade: brew upgrade
  #  If not installed, return without error
  if log_eval brew list "$1"; then
    # Formula is already installed, upgrade it
    if log_eval brew upgrade "$1"; then
      success "Upgraded ${1}"
    else
      warning "Failed to upgrade ${1}. Check log file: ${bold}${LOG_FILE}${normal}"
    fi
  fi
  # FAILED UPGRADE SHOULD NOT EXIT THE SCRIPT
}

############################################################
# Semver Functions
############################################################

major_version() {
  echo "${1%%.*}" # Remove everything after the first period
}

minor_version() {
  major="$(major_version "$1")" # Evaluate the major version
  nomajor="${1#"$major".}"      # Trim major version and period from start of string
  minor="${nomajor%.*}"         # Remove everything after the first period
  echo "${minor%%[^0-9]*}"      # Remove any non-numerical suffix for patches
}
