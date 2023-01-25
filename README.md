# aceup

Public scripts to bootstrap the ACE installation process

## New User Setup

Run the following commands to get your new system set up to work at ACT3

> Linux and macOS only, requires Homebrew and Git to be installed.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/act3-ace/aceup/main/act3-login)"
brew install ace-tools
ace-kubectl-plugins
```

## ACT3 Login

The ACT3 Login script automatically logs a user into the standard ACT3 services. It also sets up secure credential storage for your system.

> Linux and macOS only, requires Homebrew and Git to be installed.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/act3-ace/aceup/main/act3-login)"
```

### Features

ACT3 Login uses your entered credentials to do the following:

1. Enable secure credential storage for Git and container registry authentication.
2. Authenticate Git over HTTPS for the ACT3 GitLab.
3. Store credentials for the ACT3 GitLab Container Registry to be used by tools like ACE Data Tool, Podman, Crane, and Docker.
4. Add the ACT3 ACE Tools Homebrew Tap, a catalog of tools used at ACT3, including internal tools like ACE Data Tool and ACT3 Project Tool.
5. Log into the ACT3 GitLab instance with ACT3 Project Tool.
6. Direct ACE Data Tool to use the ACT3 Telemetry Server.
7. Create an authenticated ACE Hub User Configuration file to be imported manually.
8. Set up ACT3 Kubernetes Cluster access
9. Create a Kubernetes Secret in the user's namespace
10. **OPTIONAL:** Set up a NETRC environment variable to use for Golang development

<!-- If you use zsh as your shell on macOS, run this command

```bash
/bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/act3-ace/aceup/main/act3-login)"
``` -->

### Caveats

1. ACT3 Login configures tools installed by Homebrew. Alternate installations of the same tools configured by ACT3 Login will produce unexpected behavior after running the script.
2. ACT3 Login is not guaranteed to work for WSL2.
3. Existing configuration for some affected applications can override ACT3 Login's changes.
   - If Podman is configured with an `auth.json` file for credentials, those credentials will be used rather than the keychain storage set up by ACT3 Login. Delete entries in `auth.json` corresponding to "reg.git.act3-ace.com" to fix this.
   - ACE Data Tool configuration is never overwritten by ACT3 Login. Back up your existing ACE Data Tool config file and rerun ACT3 Login to see the config file it creates.

### Troubleshooting

> My previous token is still stored when I check the keyring.

Try relaunching the keyring GUI, it might not have updated yet.

> I am getting this error during Git credential setup: `git: 'credential-osxkeychain' is not a git command. See 'git --help'.`

You may be using an alternate installation of Git.

1. Check what `git` executable you are using: `which -a git`
2. If there are multiple entries, run `brew uninstall git` and then rerun ACT3 Login

> I am getting this error during Kubernetes secret creation: `error: unable to load root certificates: unable to parse bytes as PEM block`

You may have an out of date certificate in your cluster configuration. Back up your `~/.kube/` directory, delete the `~/.kube/` directory, and rerun ACT3 Login.
