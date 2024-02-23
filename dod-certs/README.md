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

It is recommended to use the [ACT3 Login script](../act3-login/README.md) to install the DoD certs. If you would like to run the `dod-certs` script by itself, follow the [standalone usage instructions](#standalone-usage) below.

Run the [ACT3 Login script](../act3-login/README.md) and confirm **Yes** when asked to install the DoD certs.

> Note: ensure that the [prerequisites for the ACT3 Login script](../act3-login/README.md#prerequisites) are met.

<!-- act3-pt ../act3-login/README.md lines:42-45 -->
<!-- ref:b93a637fe804ccc80ec62cedfec1184d00a07930 -->
```sh
/usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/act3-ace/aceup/main/act3-login/act3-login)"
```
<!-- act3-pt end -->

## Standalone Usage

Run the [`dod-certs` script](./dod-certs) in standalone form:

```sh
/usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/act3-ace/aceup/main/dod-certs/dod-certs)"
```

### Clone Repo and Run

Clone the [ACEup](https://github.com/act3-ace/aceup) repository to your system:

```sh
# SSH Authentication
git clone ssh://git@github.com/act3-ace/aceup.git

# HTTPS Authentication
git clone https://github.com/act3-ace/aceup.git
```

Then, run the [`dod-certs` script](./dod-certs):

```sh
./aceup/dod-certs/dod-certs
```

## Additional Resources

### Documentation

- [FAQ](../docs/troubleshooting-faq.md)
- [Firefox Browser Supplement](../docs/apt-firefox-supplement.md)

### Support

- [Mattermost channel](https://chat.git.act3-ace.com/act3/channels/devops): Create a post in the DevOps channel for assistance
- Create a GitHub issue in the ACEup repository:
  - [Via browser](https://git.act3-ace.com/ace/aceup/-/issues/new)
