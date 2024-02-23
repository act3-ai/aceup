# Firefox Browser Supplement

## Intended Audience

This supplement is written for ACT3 team members who use a Firefox browser.

## Overview

The Firefox browser has specific configurations that are known to cause errors when working in ACT3. The following recommendations are included in this supplement:

- Install an [Apt version of Firefox](#apt-firefox-install)
- Manually [Trust DoD Certificates](#trust-dod-certificates)

## APT Firefox Install

First, run updates:

```sh
sudo apt update
```

Check update progress:

```sh
sudo snap changes
```

Review the output from the previous command to verify that no changes or updates for Firefox are running. If there are, abort them:

```sh
sudo snap abort <number>
```

Remove snap firefox:

```sh
sudo snap remove firefox
```

Add the Mozilla repository to apt:

```sh
sudo add-apt-repository ppa:mozillateam/ppa
```

Set apt install priority higher than snap install:

```sh
echo '
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
' | sudo tee /etc/apt/preferences.d/mozilla-firefox
```

Install the correct version of Firefox

```sh
sudo apt install firefox -y
```

At this point, there may be both a snap install and an apt install of Firefox on your machine. A reboot may be required to flush out the snap install.

Reboot to flush out the snap install:

```sh
sudo reboot
```

## Trust DoD Certificates

- Import the certificates:
  - Open Firefox
  - Open application menu by clicking the hamburger menu (three bars) in the top right
  - Select **Settings**
  - Select **Privacy and Security**
  - Select **View Certificates**
  - Select **Import**
  - Navigate to the `.cache/ace/aceup/dod-certs/certificates_pkcs7_v5_12_dod` directory inside of the user's home directory
    - Example: ex: /home/USERNAME/.cache/ace/aceup/dod-certs/certificates_pkcs7_v5_12_dod/certificates_pkcs7_v5_12_dod_der.p7b
  - Upload the file named `certificates_pkcs7_v5_12_dod_der.p7b`
  - Uploading the file automatically presents the trust checkboxes for the DoD CA 6
  - Check all boxes to trust the cert and select **OK**
  - All root and intermediate certificates will be imported
- Trust the certificates:
  - In the Firefox Certificate Manager, locate DoD Root CA 3 in the files listed under the heading for U.S. Government
  - Select **Edit Trust**
  - Check the boxes to trust the cert and select **OK**; intermediate certs may not present as many boxes to check as the primary cert
  - Repeat this process for DoD Root CAs 4 and 5
  - Select **OK**
  - Close Firefox
- Reboot the machine
  - Reboot the machine before attempting to authenticate to a web site that requires a CAC and the DoD certificates installed during this process.
