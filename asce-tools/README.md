# ASCE Tools

ASCE Tools is a collection of common software packages for ASCE users and ACT3 developers.

Software installed by the ASCE Tools command will be kept up-to-date with `brew upgrade`.

> [!IMPORTANT]
>
> The [ACT3 Homebrew Tap's prerequisites](https://github.com/act3-ai/homebrew-tap#prerequisites) are required in order to install ACT3 packages included in ASCE Tools.

## Usage

It is recommended to use the ACT3 Homebrew Tap's `asce-tools` command to install ASCE Tools. If you would like to install ASCE Tools without using the ACT3 Homebrew Tap, follow the [standalone usage instructions](#standalone-usage) below.

To add the ACT3 Homebrew Tap, run:

```sh
brew tap act3-ai/tap
```

Then, run the `asce-tools` command:

```sh
brew asce-tools
```

### Standalone Usage

ASCE Tools can be installed without the use of the ACT3 Homebrew Tap using Homebrew's [`brew bundle` command](https://github.com/Homebrew/homebrew-bundle).

Clone the [ACEup](https://github.com/act3-ace/aceup) repository to your system:

```sh
git clone https://github.com/act3-ace/aceup.git
```

Then, install ASCE Tools by running `brew bundle` on the [ASCE Tools Brewfile](./Brewfile):

```sh
# Install ASCE Tools Homebrew Formulae
brew bundle -v --file ./aceup/asce-tools/Brewfile

# Install ASCE Tools VS Code Extensions
brew bundle -v --file ./aceup/asce-tools/Brewfile-vscode --formula
```

> [!TIP]
>
> The `-v`/`--verbose` flag is used to output formula caveats, which can contain important post-installation instructions

To install Kubectl and Helm plugins, run the `kubectl-plugins` and `helm-plugins` scripts:

```sh
# Install Kubectl plugins
./aceup/asce-tools/kubectl-plugins

# Install Helm plugins
./aceup/asce-tools/helm-plugins
```

## Packages

### Homebrew Formulae

The following ACT3 Homebrew Formulae are included in ASCE Tools:

- [`ace-dt`](https://git.act3-ace.com/ace/data/tool): ASCE Data Tool
- [`asce-hub-cli`](https://git.act3-ace.com/ace/hub/cli): ASCE Hub CLI
- [`asce`](https://git.act3-ace.com/ace/cli): ASCE CLI
- [`act3-pt`](https://devsecops.git.act3-ace.com/act3-pt): ACT3 Project Tool
- [`kubectl-equilibria`](https://git.act3-ace.com/ace/equilibria#kubectl-plugin): ASCE Equilibria `kubectl` plugin

The following third-party Homebrew Formulae are included in ASCE Tools:

- [`container-structure-test`](https://github.com/GoogleContainerTools/container-structure-test)
- [`crane`](https://github.com/google/go-containerregistry/blob/main/cmd/crane/README.md)
- [`direnv`](https://github.com/direnv/direnv)
- [`fluxcd/tap/flux`](https://github.com/fluxcd/flux2) (`flux`)
- [`git-lfs`](https://github.com/git-lfs/git-lfs)
- [`glab`](https://gitlab.com/gitlab-org/cli)
- [`helm`](https://github.com/helm/helm)
- [`helmfile`](https://github.com/helmfile/helmfile)
- [`k9s`](https://github.com/derailed/k9s)
- [`kind`](https://github.com/kubernetes-sigs/kind)
- [`krew`](https://github.com/kubernetes-sigs/krew)
- [`kubectx`](https://github.com/ahmetb/kubectx)
- [`kubernetes-cli`](https://github.com/kubernetes/kubectl) (`kubectl`)
- [`kustomize`](https://github.com/kubernetes-sigs/kustomize)
- [`norwoodj/tap/helm-docs`](https://github.com/norwoodj/helm-docs) (`helm-docs`)
- [`oras`](https://github.com/oras-project/oras)
- [`podman`](https://github.com/containers/podman)
- [`skaffold`](https://github.com/GoogleContainerTools/skaffold)
- [`websocat`](https://github.com/vi/websocat)
- [`yq`](https://github.com/mikefarah/yq)

### Kubectl Plugins

The following [`kubectl` plugins](https://kubernetes.io/docs/tasks/extend-kubectl/kubectl-plugins) are included in ASCE Tools:

- [`kubectl view-secret`](https://artifacthub.io/packages/krew/krew-index/view-secret)
- [`kubectl view-allocations`](https://github.com/elsesiy/kubectl-view-secret)
- [`kubectl konfig`](https://github.com/corneliusweig/konfig)
- [`crossplane`](https://docs.crossplane.io/latest/cli) (not a kubectl plugin)

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

## Support

- **[Troubleshooting FAQ](../docs/troubleshooting-faq.md)**: consult list of frequently asked questions and their answers.
- **[Create a support ticket](https://github.com/act3-ace/aceup/issues/new)**: create a support ticket issue on the ACEup GitHub project.
- **[Mattermost channel](https://chat.git.act3-ace.com/act3/channels/devops)**: create a post in the DevOps channel for assistance.
