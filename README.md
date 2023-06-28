# ACEup

ACEup contains public scripts to bootstrap the ACE installation process, such as ACT3 Login.

## Prerequisites

- Linux, macOS, or WSL2 running Ubuntu 22.04 (**Windows only supported through WSL2**)
- ACT3 Active Directory account
- Sudo privileges on your computer
- Git installed
- Homebrew installed

> Note: before starting the ACT3 Login process for the first time, run `brew doctor` and address any issues until running `brew doctor` results in a confirmation message stating that `Your system is ready to brew.`

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
  - ACT3 GitLab Container Registry
  - ACT3 Project Tool (`act3-pt`)
  - ACT3 Kubernetes clusters
  - ACE Hub
    - User must import the generated User Configuration file on ACE Hub

### Run ACT3 Login

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/act3-ace/aceup/main/act3-login)"
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
- Store credentials for the ACT3 GitLab Container Registry to be used by tools like ACE Data Tool, Podman, Crane, and Docker
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
