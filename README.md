# ACEup

ACEup contains public scripts to bootstrap the ACE installation process, such as ACT3 Login.

## Intended Audience

This repository is targeted to users who need to authenticate and configure their macOS, Ubuntu 22.04, or WSL2 (running Ubuntu 22.04) machines for work in the ACT3 environment.

## Overview

The ACEup repository is a collection of script-based tools and resources to bootstrap access to ACT3 services. The following tools are contained in this repo:

- [ACT3 Login script](./act3-login/README.md)
- [DoD Certs script](./dod-certs/README.md)
- [Smart Card Reader script](./smart-card-reader/README.md)

> Only users running Ubuntu 22.04 will need to run the Smart Card Reader (SRC) script.

## Prerequisites

- Linux, macOS, or WSL2 running Ubuntu 22.04 (**Windows is only supported through WSL2**)
- ACT3 Active Directory account
- User account with sudo privileges on your system
  - List your sudo privileges with `sudo -l`
- [curl](https://everything.curl.dev/) installed
  - Check your system for curl with `which curl`
  - If missing, follow system-specific instructions from *Everything curl*: [Install curl](https://everything.curl.dev/get)
- [Git](https://git-scm.com) installed
  - Check your system for Git with `which git`
  - If missing, follow system-specific instructions from Git: [Installing Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [Homebrew](https://brew.sh/) installed
  - Check your system for Homebrew with `which brew`
  - If missing, install with [Homebrew's installation script](https://brew.sh/) (*be sure to complete tasks under **Next Steps***)
  - Check your installation of Homebrew by running `brew doctor`

## Usage

It is recommended users run the ACT3 Login script to begin the bootstrap process.

### Recommend Usage

ACT3 Login will automatically:

- Prompt users to run the DoD Certs script
- Install ACT3 Homebrew tap (enabling access to scripts in this repo)

> Note: ensure that the [prerequisites for the ACT3 Login script](https://github.com/act3-ace/aceup#prerequisites) are met.

Run the [ACT3 Login script](https://github.com/act3-ace/aceup#aceup):

<!-- act3-pt https://github.com/act3-ace/aceup.git file:README.md lines:46-48 -->
<!-- ref:b93a637fe804ccc80ec62cedfec1184d00a07930 -->
```sh
/usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/act3-ace/aceup/main/act3-login/act3-login)"
```
<!-- act3-pt end -->

Next, install ACEup:

```sh
brew install aceup
```

Optionally, for Ubuntu users, run the smart card reader script:

```sh
enable-smart-card-reader
```

### Optional Usage

#### ACT3 Homebrew Tap

Add the [ACT3's Homebrew tap](https://git.act3-ace.com/ace/homebrew-ace-tools) to brew the ACEup formula and run a ACEup script.

Add the ACT3 Tap:

<!-- act3-pt https://git.act3-ace.com/ace/homebrew-ace-tools.git file:README.md lines:14-20 -->
<!-- ref:bff1c411f9b7bbdec15466b411a39edde5a93771 -->
```sh
# SSH Authentication
brew tap act3/ace-tools git@git.act3-ace.com:ace/homebrew-ace-tools.git

# HTTPS Authentication
brew tap act3/ace-tools https://git.act3-ace.com/ace/homebrew-ace-tools.git
```
<!-- act3-pt end -->

Next, install ACEup:

```sh
brew install aceup
```

Then, run the desired script:

```sh
# Run the ACT3 Login script
act3-login

# Install current DoD certs
dod-certs

# Install smart card reader tools for Ubuntu
enable-smart-card-reader
```

#### Clone Repo and Run

Clone the [ACEup](https://git.act3-ace.com/ace/aceup) repository to your machine using SSH or HTTPS:

```sh
# SSH Authentication
git clone git@git.act3-ace.com:ace/aceup.git

# HTTPS Authentication
git clone https://git.act3-ace.com/ace/aceup.git
```

Then, point to and run the desired script:

```sh
cd aceup

./<path to script>
```

## ACT3 Login

ACT3 Login is designed to:

- Authenticate users to ACT3 services
- Promote secure credential management
- Simplify system setup

ACT3 Login does the following:

- Enables secure credential storage using your system's keychain
- Adds the ACT3 Homebrew Tap for access to internal tools
- Authentication for the following:
  - Git over SSH and HTTPS
    - Optional: Enable commit signing with SSH
  - ACT3 GitLab Container Registry
  - ACT3 Project Tool (`act3-pt`)
  - ACE Hub
    - User must import the generated User Configuration file on ACE Hub
  - Optional: ACT3 Kubernetes cluster access
    - Creates a Kubernetes Secret in the user's namespace

### Run ACT3 Login

```sh
/usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/act3-ace/aceup/main/act3-login/act3-login)"
```

> Check [prerequisites](#prerequisites) before running.

## New User Setup

After running the login script above, new users also need to run the following commands for your system set up to work at ACT3 by installing the ACE Tools collection:

```sh
# Install ACE Tools
brew install ace-tools
```

### Features

ACT3 Login uses your entered credentials to do the following:

- Enable secure credential storage for Git and container registry authentication
- Authenticate Git over SSH and HTTPS for the ACT3 GitLab
- **OPTIONAL:** Enables Git commit signing with SSH
- Store credentials for the ACT3 GitLab Container Registry to be used by tools like ACE Data Tool, Podman, and Docker
- Add the ACT3 ACE Tools Homebrew tap, a catalog of tools used at ACT3, including internal tools like ACE Data Tool and ACT3 Project Tool
- Log into the ACT3 GitLab instance with ACT3 Project Tool
- Direct ACE Data Tool to use the ACT3 Telemetry server
- Create an authenticated ACE Hub User Configuration file (note: this file must be imported manually)
- **OPTIONAL:** Set up ACT3 Kubernetes cluster access
- **OPTIONAL:** Create a Kubernetes Secret in the user's namespace

### Caveats

- ACT3 Login configures tools installed by Homebrew. Alternate installations of the same tools configured by ACT3 Login will produce unexpected behavior after running the script.
- Existing configuration for some affected applications can override ACT3 Login's changes.
  - If Podman is configured with an `auth.json` file for credentials, those credentials will be used rather than the keychain storage set up by ACT3 Login. Delete entries in `auth.json` corresponding to "reg.git.act3-ace.com" to fix this.
  - ACE Data Tool configuration is never overwritten by ACT3 Login. Back up your existing ACE Data Tool config file and rerun ACT3 Login to see the config file it creates.

## Support

- **[Troubleshooting FAQ](docs/troubleshooting-faq.md)**: consult list of frequently asked questions and their answers.
- **[Create a support ticket](https://git.act3-ace.com/ace/aceup/-/issues/new?issuable_template=Support%20Ticket)**: create a support ticket issue on the ACEup GitLab project.
- **[Mattermost channel](https://chat.git.act3-ace.com/act3/channels/devops)**: create a post in the DevOps channel for assistance.
