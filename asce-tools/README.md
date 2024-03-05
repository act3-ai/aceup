# ASCE Tools

ASCE Tools is a collection of common software packages for ASCE users and ACT3 developers.

Software installed by the ASCE Tools command will be kept up-to-date with `brew upgrade`.

## Usage

It is recommended to use the ACT3 Homebrew Tap's `install-asce-tools` command to install ASCE Tools. If you would like to install ASCE Tools without using the ACT3 Homebrew Tap, follow the [standalone usage instructions](#standalone-usage) below.

To add the ACT3 Homebrew Tap, run:

```sh
brew tap act3-ai/tap
```

Then, run the `install-asce-tools` command:

```sh
brew install-asce-tools
```

### Standalone Usage

ASCE Tools can be installed without the use of the ACT3 Homebrew Tap using Homebrew's [`brew bundle` command](https://github.com/Homebrew/homebrew-bundle).

Clone the [ACEup](https://github.com/act3-ace/aceup) repository to your system:

```sh
# SSH Authentication
git clone ssh://git@github.com/act3-ace/aceup.git

# HTTPS Authentication
git clone https://github.com/act3-ace/aceup.git
```

Then, install ASCE Tools by running `brew bundle` on the [ASCE Tools Brewfile](./Brewfile):

```sh
# Install ASCE Tools Homebrew Formulae
brew bundle -v --file ./aceup/asce-tools/Brewfile

# Install ASCE Tools VS Code Extensions
brew bundle -v --file ./aceup/asce-tools/Brewfile-vscode --formula
```

To install Kubectl and Helm plugins, run the `kubectl-plugins` and `helm-plugins` scripts:

```sh
# Install Kubectl plugins
./aceup/asce-tools/kubectl-plugins

# Install Helm plugins
./aceup/asce-tools/helm-plugins
```

> The -v/--verbose flag is used to output formula caveats, which can contain important post-installation instructions.
>
> For all available options, see Homebrew's documentation: [Bundle Command](https://docs.brew.sh/Manpage#bundle-subcommand)

## Packages

### Homebrew Formulae

The following ACT3 Homebrew Formulae are included in ASCE Tools:

- [ASCE Data Tool](https://git.act3-ace.com/ace/data/tool)
- [ACT3 Project Tool](https://git.act3-ace.com/devsecops/act3-pt)
- [ASCE Hub CLI](https://git.act3-ace.com/ace/hub/cli)
- [ASCE CLI](https://git.act3-ace.com/ace/cli)
- [ASCE Equilibria Kubectl Plugin](https://git.act3-ace.com/ace/kubectl-plugins)

The following third-party Homebrew Formulae are included in ASCE Tools:

- [Container Structure Tests](https://formulae.brew.sh/formula/container-structure-test#default)
- [crane](https://formulae.brew.sh/formula/crane#default)
- [direnv](https://formulae.brew.sh/formula/direnv#default)
- [Git LFS](https://formulae.brew.sh/formula/git-lfs#default)
- [glab](https://formulae.brew.sh/formula/glab#default)
- [Helm](https://formulae.brew.sh/formula/helm#default)
- [Helmfile](https://formulae.brew.sh/formula/helmfile#default)
- [K9s](https://formulae.brew.sh/formula/k9s#default)
- [kind](https://formulae.brew.sh/formula/kind#default)
- [Krew](https://formulae.brew.sh/formula/krew#default)
- [kubectl](https://formulae.brew.sh/formula/kubernetes-cli#default)
- [Kustomize](https://formulae.brew.sh/formula/kustomize#default)
- [oras](https://formulae.brew.sh/formula/oras#default)
- [Podman](https://formulae.brew.sh/formula/podman#default)
- [Skaffold](https://formulae.brew.sh/formula/skaffold#default)
- [websocat](https://formulae.brew.sh/formula/websocat#default)
- [yq](https://formulae.brew.sh/formula/yq#default)

### Kubectl Plugins

The following kubectl plugins are included in ASCE Tools:

- []

### VS Code Extensions

The following VS Code extensions are included in ASCE Tools:

- [`DavidAnson.vscode-markdownlint`](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint)
- [`GitHub.remotehub`](https://marketplace.visualstudio.com/items?itemName=GitHub.remotehub)
- [`GitHub.vscode-pull-request-github`](https://marketplace.visualstudio.com/items?itemName=GitHub.vscode-pull-request-github)
- [`GitLab.gitlab-workflow`](https://marketplace.visualstudio.com/items?itemName=GitLab.gitlab-workflow)
- [`Gruntfuggly.todo-tree`](https://marketplace.visualstudio.com/items?itemName=Gruntfuggly.todo-tree)
- [`James-Yu.latex-workshop`](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop)
- [`Remisa.shellman`](https://marketplace.visualstudio.com/items?itemName=Remisa.shellman)
- [`bierner.markdown-mermaid`](https://marketplace.visualstudio.com/items?itemName=bierner.markdown-mermaid)
- [`eamodio.gitlens`](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens)
- [`ecmel.vscode-html-css`](https://marketplace.visualstudio.com/items?itemName=ecmel.vscode-html-css)
- [`esbenp.prettier-vscode`](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)
- [`exiasr.hadolint`](https://marketplace.visualstudio.com/items?itemName=exiasr.hadolint)
- [`foxundermoon.shell-format`](https://marketplace.visualstudio.com/items?itemName=foxundermoon.shell-format)
- [`hediet.vscode-drawio`](https://marketplace.visualstudio.com/items?itemName=hediet.vscode-drawio)
- [`jeff-hykin.better-dockerfile-syntax`](https://marketplace.visualstudio.com/items?itemName=jeff-hykin.better-dockerfile-syntax)
- [`jinliming2.vscode-go-template`](https://marketplace.visualstudio.com/items?itemName=jinliming2.vscode-go-template)
- [`mindaro.mindaro`](https://marketplace.visualstudio.com/items?itemName=mindaro.mindaro)
- [`ms-azuretools.vscode-docker`](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker)
- [`ms-kubernetes-tools.vscode-kubernetes-tools`](https://marketplace.visualstudio.com/items?itemName=ms-kubernetes-tools.vscode-kubernetes-tools)
- [`ms-python.python`](https://marketplace.visualstudio.com/items?itemName=ms-python.python)
- [`ms-python.vscode-pylance`](https://marketplace.visualstudio.com/items?itemName=ms-python.vscode-pylance)
- [`ms-toolsai.jupyter`](https://marketplace.visualstudio.com/items?itemName=ms-toolsai.jupyter)
- [`ms-vscode-remote.vscode-remote-extensionpack`](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack)
- [`ms-vscode.cmake-tools`](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cmake-tools)
- [`ms-vscode.cpptools`](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools)
- [`ms-vscode.live-server`](https://marketplace.visualstudio.com/items?itemName=ms-vscode.live-server)
- [`ms-vscode.remote-explorer`](https://marketplace.visualstudio.com/items?itemName=ms-vscode.remote-explorer)
- [`ms-vsliveshare.vsliveshare`](https://marketplace.visualstudio.com/items?itemName=ms-vsliveshare.vsliveshare)
- [`njpwerner.autodocstring`](https://marketplace.visualstudio.com/items?itemName=njpwerner.autodocstring)
- [`peterj.proto`](https://marketplace.visualstudio.com/items?itemName=peterj.proto)
- [`redhat.vscode-yaml`](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml)
- [`shd101wyy.markdown-preview-enhanced`](https://marketplace.visualstudio.com/items?itemName=shd101wyy.markdown-preview-enhanced)
- [`tamasfe.even-better-toml`](https://marketplace.visualstudio.com/items?itemName=tamasfe.even-better-toml)
- [`timonwong.shellcheck`](https://marketplace.visualstudio.com/items?itemName=timonwong.shellcheck)
- [`tomoki1207.pdf`](https://marketplace.visualstudio.com/items?itemName=tomoki1207.pdf)
- [`twxs.cmake`](https://marketplace.visualstudio.com/items?itemName=twxs.cmake)
- [`vincaslt.highlight-matching-tag`](https://marketplace.visualstudio.com/items?itemName=vincaslt.highlight-matching-tag)
- [`yzane.markdown-pdf`](https://marketplace.visualstudio.com/items?itemName=yzane.markdown-pdf)
- [`yzhang.markdown-all-in-one`](https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one)
