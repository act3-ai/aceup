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

### Recommended Usage

Ubuntu users who need to install and configure their system to work with a smart card reader should complete the following:

Run the [`enable-smart-card-reader` script](./enable-smart-card-reader).

```sh
/usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/act3-ace/aceup/main/act3-login/act3-login)"
```

### Optional Usage

#### Clone Repo and Run

Clone the [ACEup](https://github.com/act3-ace/aceup) repository to your system:

```sh
# SSH Authentication
git clone ssh://git@github.com/act3-ace/aceup.git

# HTTPS Authentication
git clone https://github.com/act3-ace/aceup.git
```

Then, run the [`enable-smart-card-reader` script](./enable-smart-card-reader):

```sh
./aceup/smart-card-reader/enable-smart-card-reader
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
- Create an issue in the ACEup repository:
  - [Via browser](https://github.com/act3-ace/aceup/issues/new)
