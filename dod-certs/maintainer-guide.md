# DoD Certs Maintainer Guide

## Intended Audience

This guide is for ACT3 developers and technical writers who maintain updates to the script and/or related process documentation when the DoD issues new certificates (certs) that are used to access Public Key Infrastructure (PKI) protected content.

## Summary

When new DoD certs are released, ACT3 technical writers need to:

- Update the URL of the zip file in the wget line of the `dod-certs` script
- Verify the authenticity of the zip file
- Update the shasum string

## Check for Updated DoD Certs

New DoD Certs are released and published via the [DoD Cyber Exchange](https://public.cyber.mil/pki-pke/).

The current version used in the ACT3 DoD script is 5.12.

## Update the URL to Download Certs in the Script

When a new version of the certificates are issued update the URL in the portion of the `dod-certs` script following the comment: `Get the new DoD certs`

## Verification

The README file that comes from cyber.mil will have instructions for verifying the authenticity of the new files. Per those instructions, use the value posted at the [Defense Information Systems Agency](https://crl.disa.mil) page for the certificate verification process.

Follow the instructions in the README for all verification steps.

After verification is complete, generate a new string to be updated in the script.

## Generate New String

To read the digest value of the zip file and generate the value as the new string to check against, run the command below:

```sh
shasum -a 512 <name of file>
```

Example:

```sh
shasum -a 512 unclass-certificates_pkcs7_DoD.zip
```

## Update shasum String in Script

Then, update the value of the string in the line that writes the file to use for the checksum. Make this update in the portion of the script following the comment: `The string below will need to be updated each time a new certificate is released`

Example:
echo "6f4ce0d60fc11a410aa7bd71d478a55876ebaa756435d072fcf342c25b46dd7266689b6a4030a1a5a7d926482fa31083183af771a7ca7b48984baf1daef6bb02  unclass-certificates_pkcs7_DoD.zip" > unclass-certificates_pkcs7_DoD.zip.checksum

## Notes

There must be two spaces between the end of the string and the beginning of the file name inside of the quotation marks

See [StackExchange post for why two spaces are needed](https://unix.stackexchange.com/questions/139891/why-does-verifying-sha256-checksum-with-sha256sum-fail-on-debian-and-work-on-u)

## Update Cert Version

When a new version of the certificates are issued update the version of the cert in the portion of the `dod-certs` script following the comment: `Unzip and write out the new certs`

Example:

```sh
openssl pkcs7 -in DoD_certs/certificates_pkcs7_v5_11_dod/certificates_pkcs7_v5_11_dod_pem.p7b -print_certs -out DoD_CAs.crt
```

gets updated to

```sh
openssl pkcs7 -in DoD_certs/certificates_pkcs7_v5_12_dod/certificates_pkcs7_v5_12_dod_pem.p7b -print_certs -out DoD_CAs.crt
```

## References

The following resources were consulted in the creation of the DoD Certs maintainer guide.

- [DoD Cyber Exchange Public Key Infrastructure/Enabling (PKI/PKE)](https://public.cyber.mil/pki-pke/end-users/getting-started/#toggle-id-3-closed) provides documentation for using CAC for multiple operating systems
- [MilitaryCAC.com](https://militarycac.com/) provides information for multiple operating systems
- The `linux_cac` [GitHub repository](https://github.com/jdjaxon/linux_cac) provides information for "consistently configuring DoD CACs on Linux."
