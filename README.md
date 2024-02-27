# ACEup

## Overview

The ACEup repository is a collection of script-based tools and resources to bootstrap access to ACT3 services. The following tools are contained in this repo:

- [ACT3 Login script](./act3-login/README.md)
- [DoD Certs script](./dod-certs/README.md)
- [ASCE Tools installers](./smart-card-reader/README.md)
- [Smart Card Reader script](./smart-card-reader/README.md)

This repository is intended for users who need to authenticate and configure their macOS, Ubuntu 22.04, or WSL2 (running Ubuntu 22.04) machines for work in the ACT3 environment.

## Usage

### ACT3 Login

It is recommended users run the [ACT3 Login script](./act3-login/README.md) to authenticate to ACT3's services.

ACT3 Login will automatically:

- Authenticate users to ACT3 services
- Ask to run the DoD Certs script
- Add ACT3 Homebrew tap (enabling access to ACT3 software packages)

Run the [ACT3 Login script](./act3-login/README.md):

<!-- act3-pt ./act3-login/README.md section:run-act3-login -->
<!-- timestamp:2024-02-23,17:03:13 -->
```sh
/usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/act3-ace/aceup/main/act3-login/act3-login)"
```

> Check [prerequisites](./act3-login/README.md#prerequisites) before running.

#### New User Setup

After running the login script above, new users should also consider installing common ASCE Tools by running the `install-asce-tools` command:

```sh
# Install common ASCE tools
brew install-asce-tools
```
<!-- act3-pt end -->

### Smart Card Reader Setup

<!-- act3-pt ./smart-card-reader/README.md section:recommended-usage -->
<!-- timestamp:2024-02-23,17:00:20 -->
Ubuntu users who need to install and configure their system to work with a smart card reader should complete the following:

Run the [`enable-smart-card-reader` script](./smart-card-reader/enable-smart-card-reader).

```sh
/usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/act3-ace/aceup/main/act3-login/act3-login)"
```
<!-- act3-pt end -->

> Read more about smart card usage on Linux: [smart-card-reader/README.md](./smart-card-reader/README.md)

## Optional Usage: Clone Repo and Run

Clone the [ACEup](https://github.com/act3-ace/aceup) repository to your system:

```sh
# SSH Authentication
git clone ssh://git@github.com/act3-ace/aceup.git

# HTTPS Authentication
git clone https://github.com/act3-ace/aceup.git
```

Then, run the desired script:

```sh
./aceup/<path to script>
```

## Support

- **[Troubleshooting FAQ](docs/troubleshooting-faq.md)**: consult list of frequently asked questions and their answers.
- **[Create a Support Ticket issue](https://github.com/act3-ace/aceup/issues/new)**: create a support ticket issue on the ACEup GitHub project.
- **[Mattermost channel](https://chat.git.act3-ace.com/act3/channels/devops)**: create a post in the DevOps channel for assistance.

---

Approved for public release: distribution unlimited. Case Numbers: AFRL-2024-1007
