# ACT3 Login Developer Guide

## Components

ACT3 Login is divided into three components:

- A public script that acts as the entrypoint
- A private script that contains all authentication setup and storage
- A public utility script that loads helper functions for output formatting, standard tasks, and system checks

## Execution

The script runs in the following order:

1. The user starts the public script with the one line command in the README.
2. The public script calls the setup script to load helper functions
3. The public script verifies that all system prerequisites are met
4. The public script prompts the user for a GitLab Personal Access Token
5. The token input is verified with GitLab to confirm its existence, scope, and active status
6. The private script is downloaded using the token
7. The public script hands off to the private script
8. The private script calls the setup script to load helper functions
9. The private script executes all authentication setup and storage tasks

## Where Credentials Are Stored

The following graph illustrates how securely stored credentials are surfaced for different tools.

```mermaid
graph TD
  classDef insecure fill:#f99,stroke:#000,color:#000
  classDef secure fill:#afa,stroke:#000,color:#000
  classDef tool fill:#7af,stroke:#000,color:#000
  classDef noauth fill:#fff,stroke:#f99,stroke-dasharray: 5 5,color:#000

  start[[Stored Credentials Flow]]

  keychain[(System Keychain<br>Linux: GNOME Keyring<br>macOS: Keychain)]:::secure
  ssh[("SSH Keys")]:::secure
  oidc[("OpenID Connect (GitLab Login)")]:::secure
  ips[("Image pull secret")]:::secure
  %%noauth(("No Authentication!")):::noauth
  %%text[(Plaintext)]:::insecure

  start ~~~ git[git]:::tool
  start ~~~ brew:::tool
  start ~~~ regtools[Registry tools:<br>ace-dt,<br>podman,<br>docker]:::tool
  start ~~~ act3pt[act3-pt]:::tool
  start ~~~ kubectl:::tool

  %% Container Registry Authentication
  regtools --> regauth{"Container Registry Auth<br>~/.docker/config.json<br>credHelpers/credsStore"}
  regauth -->|secretservice<br>osxkeychain| keychain
  %%dockerconf -->|none| text

  %% Git Authentication
  git --> gitauth{Git Authentication}
  gitauth -->|SSH| ssh
  gitauth -->|HTTPS| gch{git config credential.helper}
  gch -->|"libsecret<br>osxkeychain"| keychain
  %%gch -->|"none"| noauth

  %% Homebrew Authentication
  brew -->|Update Taps| gitauth
  brew -->|"Install ACT3 Formula"| formula{Formula download<br>strategy}
  formula -->|"Uses Git to<br>clone from<br>GitLab"| gitauth
  formula -->|"Uses oras to<br>download from<br>GitLab registry"| regauth

  %% ACT3 Project Tool
  act3pt -->|"Accessing GitLab API"| gokr{"go-keyring Go package"}
  act3pt -->|"Accessing Git Repository"| gitauth
  gokr -->|"secretservice<br>/usr/bin/security"| keychain

  %% Cluster Access
  kubectl -->|Basic cluster access| clusterconf{"Cluster configuration<br>~/.kube/config"}
  clusterconf -->|oidc-connect| oidc
  kubectl -->|Pull image| ips

```

## Development Rules

1. Must be cross platform for Linux and macOS
   - Required platform-specific steps must be executed in conditionals, with a fallback case for "unsupported" systems
2. Do not add prerequisites
   - The only dependencies are:
     - Bash: to execute the script
     - Curl: to download the script, comes preinstalled on supported systems
     - Git: comes preinstalled on supported systems
     - Homebrew: enables cross-platform package management and use of our private Homebrew Tap
   - Any additional dependencies required during the script must be installed during the script using Homebrew
3. Check first
