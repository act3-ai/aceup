# aceup

Public scripts to bootstrap the ACE installation process

## ACT3 Login

The ACT3 Login script automatically logs a user into the standard ACT3 services. It also sets up secure credential storage for your system.

> Linux and macOS only, requires Homebrew and Git to be installed.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/act3-ace/aceup/main/act3-login)"
```

<!-- If you use zsh as your shell on macOS, run this command

```bash
/bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/act3-ace/aceup/main/act3-login)"
``` -->

## New User Setup

Run the following commands to get your new system set up to work at ACT3

> Linux and macOS only, requires Homebrew and Git to be installed.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/act3-ace/aceup/main/act3-login)"
brew install ace-tools
ace-kubectl-plugins
```
