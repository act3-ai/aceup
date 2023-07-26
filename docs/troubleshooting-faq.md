# ACEup Troubleshooting & FAQ

<!--This document is a place to capture questions that have come up repeatedly by existing users and that can be answered in a helpful manner through written documentation. The contents included here should be generalizable enough to apply to all users with the same or similar questions. This is not an appropriate place to document issues or questions that are individualized to a particular environment or use case.-->

## ACT3 Login Troubleshooting

**ACT3 Login produces a log file with detailed logs from its execution. This is the first place to check when troubleshooting an issue with the script.**

If you are not able to identify the problem, first consult the FAQs below. Then, complete the following troubleshooting steps:

1. Read the log file created by ACT3 Login
   - [How to find the log file](#how-do-i-find-the-logs-for-act3-login-script)
2. Run `brew doctor` to check your installation of Homebrew for issues
   - Address any issues
   - Repeat process until `brew doctor` states `Your system is ready to brew.`
3. Check your Docker config: `~/.docker/config.json`
   - Remove all references to `reg.git.act3-ace.com`
   - Remove all references to `credsStore` and `credHelpers`
   - Re-run ACT3 Login

If you are still not able to resolve the issue, [create a support ticket](https://git.act3-ace.com/ace/aceup/-/issues/new?issuable_template=Support%20Ticket).

## Troubleshooting

### Homebrew Issues

Run the following command to check for issues with your installation of Homebrew:

```sh
brew doctor
```

Address any issues identified by `brew doctor` and repeat the command until `brew doctor` states that `Your system is ready to brew.`

#### Installation issues/incomplete installation

The Homebrew installation script prompts the user with tasks to complete to finish installing Homebrew. If you did not complete these tasks, you may have an incomplete installation of Homebrew. If you recently installed Homebrew and are unsure if you completed Homebrew's finishing tasks, use [Homebrew's uninstall script](https://github.com/homebrew/install#uninstall-homebrew), then [reinstall](https://brew.sh/).

Run the following command to check if Homebrew's bin directories are on your PATH:

```sh
[[ ":$PATH:" == *":$(brew --prefix)/bin:"* ]] && [[ ":$PATH:" == *":$(brew --prefix)/sbin:"* ]] && echo "PASS" || echo "FAIL"
```

Add the following line to your `~/.bashrc` file to add Homebrew's bin directories to your PATH:

```sh
eval "$(brew shellenv)"
```

<!-- Source: https://github.com/Homebrew/install/blob/master/install.sh#L1021 -->

Your terminal will need to be restarted for these changes to take effect.

### SSH Authentication Issues

Run the following command to verify the ssh-agent is running on your system:

```sh
ssh-add -l; echo "Exit code: $?"
```

If the command fails with an exit code of 2, the ssh-agent is not running on your system, which may affect SSH authentication.

## FAQs

### How do I find the logs for ACT3 Login script?

ACT3 Login produces a log file at the location `$XDG_CACHE_HOME/act3/login/logs.txt`. If `$XDG_CACHE_HOME` unset or empty on your system, its default value is used. ACT3 Login prints the path to the log file on your system after the welcome message, in the format `Created log file <log file>`. If the script aborts, the path to the log file will be printed to your terminal before exiting.

Note: WSL2 users can open File Explorer from the Ubuntu terminal by running `explorer.exe <path>`

> `$XDG_CACHE_HOME` is defined by the [XDG Base Directory specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html).
>
> | System | Default `$XDG_CACHE_HOME` | Default log file                           |
> | ------ | ------------------------- | ------------------------------------------ |
> | Linux  | `$HOME/.cache`            | `$HOME/.cache/act3/login/logs.txt`         |
> | macOS  | `$HOME/Library/Caches`    | `$HOME/Library/Caches/act3/login/logs.txt` |

### My GitLab Personal Access Token expired. How do I update it?

1. Run the [ACT3 Login script](https://github.com/act3-ace/aceup#run-act3-login). You will be prompted to create a new Personal Access Token.
2. Create a token with the scope of `api` selected.
3. Provide the value of the new token when prompted.

### My previous token is still stored when I check the keyring. How do I update it?

Try relaunching the keyring GUI, it might not have updated yet.

### Why am I getting this error during Git credential setup? git: credential-osxkeychain' is not a git command

You may be using an alternate installation of Git.

1. Check what Git executable you are using: `which -a git`
2. If there are multiple entries, run `brew uninstall git` and then rerun ACT3 Login

If the problem persists, run `git --help`

### Why am I getting this error during Kubernetes secret creation? error: unable to load root certificates: unable to parse bytes as PEM block

You may have an out of date certificate in your cluster configuration. Back up your ~/.kube/ directory, delete the ~/.kube/ directory, and rerun ACT3 Login.

## Additional Resources

- [Documentation](../README.md)
- [Support](../README.md#support)
