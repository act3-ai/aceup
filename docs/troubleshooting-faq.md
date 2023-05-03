# ACEup Troubleshooting & FAQ

<!--This document is a place to capture questions that have come up repeatedly by existing users and that can be answered in a helpful manner through written documentation. The contents included here should be generalizable enough to apply to all users with the same or similar questions. This is not an appropriate place to document issues or questions that are individualized to a particular environment or use case.-->

## ACT3 Login Troubleshooting

**ACT3 Login produces a log file with detailed logs from its execution. This is the first place to check when troubleshooting an issue with the script.**

My previous token is still stored when I check the keyring.

> Try relaunching the keyring GUI, it might not have updated yet.

I am getting this error during Git credential setup: `git: 'credential-osxkeychain' is not a git command. See 'git --help'.`

> You may be using an alternate installation of Git.
>
> 1. Check what `git` executable you are using: `which -a git`
> 2. If there are multiple entries, run `brew uninstall git` and then rerun ACT3 Login

I am getting this error during Kubernetes secret creation: `error: unable to load root certificates: unable to parse bytes as PEM block`

> You may have an out of date certificate in your cluster configuration. Back up your `~/.kube/` directory, delete the `~/.kube/` directory, and rerun ACT3 Login.

If you are still not able to identify the problem:

1. Check the log file created by ACT3 Login
2. Run `brew doctor` to check your installation of Homebrew for issues
3. Check your Docker config: `~/.docker/config.json`
   1. Remove all references to `reg.git.act3-ace.com`
   2. Remove all references to `credsStore` and `credHelpers`
   3. Run ACT3 Login again
4. Check if the `ssh-agent` is running on your system
   - `ssh-add -l` checks if the agent is running and lists its known identities

## Additional Resources

- [Documentation](../README.md)
- [Support](../README.md#support)
