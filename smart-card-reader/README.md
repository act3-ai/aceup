# Smart Card Reader Script

## Intended Audience

The **Smart Card Reader (SCR) script** is designed for users running Ubuntu 22.04 who have not configured their machine to recognize and use a smart card reader (e.g. a CAC reader).

> macOS or Windows have built-in support for smart card readers and do not need to run this script

## Overview

Running the script does the following:

- Installs:
  - OpenSC
  - Middleware libraries and tools required to read the CAC
  - CACKey
- Enables pcscd

The smart card reader configuration can be checked with the [Verification Process](#verification-process).

## Usage

It is recommended to use the ACT Login script to install the SCR script.

### Recommended Usage

Ubuntu users who need to install and configure their machine to work with a smart card reader should complete the following:

Run the [ACT3 Login script](https://github.com/act3-ace/aceup#aceup).

> Note: ensure that the [prerequisites for the ACT3 Login script](https://github.com/act3-ace/aceup#prerequisites) are met.

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

Then, run:

```sh
setup-cac
```

### Optional Usage

#### ACT3 Homebrew Tap

Add the [ACT3's Homebrew tap](../../homebrew-ace-tools/README.md) to brew the ACEup formula and run `setup-cac`.

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
setup-cac
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

./smart-card-reader/setup-cac
```

### Verification Process

After running the script, connect the card reader and insert the card. Then, check the slot:

```sh
pkcs11-tool -L
```

Example of output showing the slot is active:

```sh
Available slots:
Slot 0 (0x0): Broadcom Corp 5880 [Contacted SmartCard] (0123456789ABCD) 00 00
  token label        : LASTNAME.FIRSTNAME.0123456789
  token manufacturer : piv_II
  token model        : PKCS#15 emulated
  token flags        : login required, token initialized, PIN initialized
  hardware version   : 0.0
  firmware version   : 0.0
  serial num         : 380aa1857810d7f3
  pin min/max        : 4/8
```

## Additional Resources

### Documentation

- [FAQ](./faq.md)

### Support

- [Mattermost channel](https://chat.git.act3-ace.com/act3/channels/devops): Create a post in the DevOps channel for assistance
- Create a GitLab issue in the ACEup repository:
  - [Via browser](https://git.act3-ace.com/ace/aceup/-/issues/new)
<!-- TODO replace when operational  - [By email](mailto:incoming+ace-aceup-1173-cpdx5kax2g659873veqpf97dt-issue@mail.act3-ace.com)-->