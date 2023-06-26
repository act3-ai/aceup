# ACEup Troubleshooting & FAQ

<!--This document is a place to capture questions that have come up repeatedly by existing users and that can be answered in a helpful manner through written documentation. The contents included here should be generalizable enough to apply to all users with the same or similar questions. This is not an appropriate place to document issues or questions that are individualized to a particular environment or use case.-->

## ACT3 Login Troubleshooting

**ACT3 Login produces a log file with detailed logs from its execution. This is the first place to check when troubleshooting an issue with the script.**

If you are not able to identify the problem, first consult the FAQs below. Then, complete the following troubleshooting steps:

1. Read the log file created by ACT3 Login
2. Run `brew doctor` to check your installation of Homebrew for issues
    - Address any issues
    - Re-run `brew doctor` and continue addressing issues until running the command results in a confirmation message stating that `Your system is ready to brew.`
    - If you are unable to address all issues, use [the script to uninstallHomebrew](https://github.com/homebrew/install#uninstall-homebrew), then [reinstall Homebrew](https://brew.sh/)
    - Complete all Homebrew prompts displayed in the CLI
    - Re-run `brew doctor` to verify that you receive a confirmation message stating that `Your system is ready to brew.`
3. Check your Docker config: `~/.docker/config.json`
   - Remove all references to `reg.git.act3-ace.com`
   - Remove all references to `credsStore` and `credHelpers`
   - Re-run ACT3 Login
4. Verify the ssh-agent is running on your system
   - Run `ssh-add -l` to check if the agent is running and list its known identities
  
If you are still not able to resolve the issue, [create a support ticket](https://git.act3-ace.com/ace/aceup/-/issues/new?issuable_template=Support%20Ticket).

## FAQs

### How do I find the logs for ACT3 Login script?

When the ACT3 Login script runs, a log folder is created. The path to log storage is printed in the ACT3 Login Script output.

After the GitLab Personal Access Token is validated, the login script echoes that it is Handing off to the private ACT3 Login script. In the **Preparing for Login** section, the path to the log file is displayed after the OS type detected.

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
