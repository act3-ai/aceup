# ACEup

ACEup contains public scripts to bootstrap the ACE installation process, such as ACT3 Login.

## New User Setup

Run the following commands to get your new system set up to work at ACT3

```bash
# Runs ACT3 Login, installs ACE Tools & ACE Kubectl Plugins
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/act3-ace/aceup/main/act3-login)"
brew install ace-tools
ace-kubectl-plugins
```

> Linux and macOS only, requires Homebrew and Git to be installed.

## ACT3 Login

ACT3 Login is designed to:

- Authenticate users to ACT3 services
- Promote secure credential mangement
- Simplify system setup

ACT3 Login does the following:

- Enables secure credential storage using your system's keychain
- Adds the ACE Tools Homebrew Tap for access to internal tools
- Authentication for the following:
  - Git (SSH and HTTPS)
  - ACT3 GitLab Container Registry
  - ACT3 Project Tool
  - ACT3 Kubernetes Clusters
  - ACE Hub (User Configuration file needs manually imported)

### Run ACT3 Login

Prerequisites:

- Linux, macOS, or WSL2
- Git and Homebrew installed

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/act3-ace/aceup/main/act3-login)"
```

### Features

ACT3 Login uses your entered credentials to do the following:

1. Enable secure credential storage for Git and container registry authentication.
2. Authenticate Git over SSH and HTTPS for the ACT3 GitLab.
3. Store credentials for the ACT3 GitLab Container Registry to be used by tools like ACE Data Tool, Podman, Crane, and Docker.
4. **OPTIONAL:** Set up a NETRC environment variable to use for Golang development
5. Add the ACT3 ACE Tools Homebrew Tap, a catalog of tools used at ACT3, including internal tools like ACE Data Tool and ACT3 Project Tool.
6. Log into the ACT3 GitLab instance with ACT3 Project Tool.
7. Direct ACE Data Tool to use the ACT3 Telemetry Server.
8. Create an authenticated ACE Hub User Configuration file to be imported manually.
9. Set up ACT3 Kubernetes Cluster access
10. Create a Kubernetes Secret in the user's namespace

### Caveats

1. ACT3 Login configures tools installed by Homebrew. Alternate installations of the same tools configured by ACT3 Login will produce unexpected behavior after running the script.
2. Existing configuration for some affected applications can override ACT3 Login's changes.
   - If Podman is configured with an `auth.json` file for credentials, those credentials will be used rather than the keychain storage set up by ACT3 Login. Delete entries in `auth.json` corresponding to "reg.git.act3-ace.com" to fix this.
   - ACE Data Tool configuration is never overwritten by ACT3 Login. Back up your existing ACE Data Tool config file and rerun ACT3 Login to see the config file it creates.

## Support

- **[Troubleshooting FAQ](docs/troubleshooting-faq.md)**: consult list of frequently asked questions and their answers.
- **[Mattermost channel](https://chat.git.act3-ace.com/act3/channels/ace-hub)**: create a post in the ACE Hub channel for assistance.
