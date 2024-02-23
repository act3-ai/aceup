# DoD Certs Script

## Intended Audience

The **DoD Certificates script** (DoD Certs script) README is designed for users running macOS, Ubuntu 22.04, or WSL2 (running Ubuntu 22.04) who need to download, install, repair, or update their DoD certificates.

## Overview

Running the script will complete the following:

- Download the latest DoD certs from [DoD Cyber Exchange](https://public.cyber.mil/pki-pke/)
- Verify the downloaded certs' integrity with a checksum
- Installs DoD certs
  - Ubuntu/WSL2: added to '/etc/ssl/certs/ca-certificates.crt'
  - macOS: added to system keychain

After the **DoD Certificates script** has run and the certificates have been trusted, users should be able to access DoD Public Key Infrastructure (PKI)-protected information or applications for web sites that require a CAC for authentication.

## Usage

It is recommended to use the ACT Login script to install the DoD certs.

### Recommended Usage

Run the [ACT3 Login script](https://github.com/act3-ace/aceup#aceup) and confirm **Yes** to the install dod-certs prompt.

> Note: ensure that the [prerequisites for the ACT3 Login script](https://github.com/act3-ace/aceup#prerequisites) are met.

<!-- act3-pt https://github.com/act3-ace/aceup.git file:README.md lines:46-48 -->
<!-- ref:b93a637fe804ccc80ec62cedfec1184d00a07930 -->
```sh
/usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/act3-ace/aceup/main/act3-login/act3-login)"
```
<!-- act3-pt end -->

### Optional Usage

#### ACT3 Homebrew Tap

Add the [ACT3's Homebrew tap](../../homebrew-ace-tools/README.md) to brew the ACEup formula and run `dod-certs`.

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

Then, run:

```sh
dod-certs
```

#### Clone Repo and Run

Clone the [ACEup](https://git.act3-ace.com/ace/aceup) repository to your machine using SSH or HTTPS:

```sh
# SSH Authentication
git clone git@git.act3-ace.com:ace/aceup.git

# HTTPS Authentication
git clone https://git.act3-ace.com/ace/aceup.git
```

Then, run:

```sh
cd aceup

./dod-certs/dod-certs
```

## Additional Resources

### Documentation

- [FAQ](../docs/faq.md)
- [Firefox Browser Supplement](../docs/apt-firefox-supplement.md)

### Support

- [Mattermost channel](https://chat.git.act3-ace.com/act3/channels/devops): Create a post in the DevOps channel for assistance
- Create a GitLab issue in the ACEup repository:
  - [Via browser](https://git.act3-ace.com/ace/aceup/-/issues/new)
<!-- TODO replace when operational - [By email](mailto:incoming+ace-aceup-1173-cpdx5kax2g659873veqpf97dt-issue@mail.act3-ace.com) -->