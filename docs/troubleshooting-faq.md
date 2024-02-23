# ACEup Troubleshooting & FAQ

<!--This document is a place to capture questions that have come up repeatedly by existing users and that can be answered in a helpful manner through written documentation. The contents included here should be generalizable enough to apply to all users with the same or similar questions. This is not an appropriate place to document issues or questions that are individualized to a particular environment or use case.-->

## Troubleshooting

- [ACT3 Login Troubleshooting](../act3-login/docs/troubleshooting-faq.md)

## Frequently Asked Questions

### Why am I being prompted for a smartcard and PIN on the login screen after installing OpenSC?

Installing OpenSC causes Ubuntu installations to ask for a smartcard and PIN on the login screen, but only when a smartcard is plugged in. Unplugging the smartcard brings the normal username/password prompt back.

> Note: A YubiKey is recognized as a smartcard and therefore must also be unplugged at the login screen.

This is an issue with the GDM3 display manager for the GNOME Desktop. The LightDM display manager does not have this problem. To fix the display manager issue by using the LightDM display manager, run:

```sh
sudo apt install lightdm
```

### Why does my AFRL Google Cloud Authentication fail if my CAC is working?

There is a known issue when attempting to authenticate to the [AFRL Google Cloud](http://internal.afresearchlab.com/) that results in authentication failure if a YubiKey and CAC are both plugged in.

The resolution to this issue is to unplug the YubiKey before attempting to log in to an AFRL GSuite account.

### Can I still use my YubiKey for the ACT3 GitLab login if I have my CAC inserted?

YubiKey works correctly when authenticating to ACT3's GitLab instance, even if a CAC is inserted.

### I am running snap Firefox on Ubuntu. What should I do if I need to authenticate to a web site using a CAC?

The snap install of Firefox is not CAC compatible. Ensure that snap version of Firefox is uninstalled and that apt version of Firefox is being used.

The `pcscd` daemon is used to manage connections to smart card readers. Uninstalling the snap version of Firefox may cause the `pcscd` daemon to stop running and/or not be initiated after reboot.

To check that the card slot is still recognized at the system level:

```sh
pkcs11-tool -L
```

To check that `pcscd` is still running:

```sh
systemctl status pcscd
```

To restart `pcscd`:

```sh
systemctl restart pcscd
```

If `pcscd` is not running or the card slot is not recognized, ensure that `pcscd` is set to start on boot:

```sh
systemctl enable pcscd.socket
```

## Additional Resources

- [Documentation](../README.md)
- [Support](../README.md#support)
