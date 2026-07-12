# boot

Bootstrap for setting up a fresh macOS machine — installs packages, provisions
dotfiles, configures system defaults, and sets up SSH/Git.

## Quick start

```sh
git clone git@github.com:rkchv/boot.git
cd boot
./run.local.sh
```

You'll be prompted twice:

- **BECOME password** — your macOS login/sudo password (`--ask-become-pass`).
- **Vault password** — the Ansible Vault password that decrypts the SSH keys
  in `.ssh/` (`--ask-vault-pass`).

## What it does

`run.local.sh` runs in order:

1. Installs **Homebrew**.
2. `brew bundle` — installs everything in the [`Brewfile`](./Brewfile)
   (CLI tools, casks, fonts).
3. Registers **asdf** plugins and installs the versions pinned in
   [`.tool-versions`](./.tool-versions) (golang, nodejs, lua).
4. Installs the stable **Rust** toolchain via `rustup`.
5. Runs the Ansible playbook [`local.yml`](./local.yml).

The playbook (`local.yml`) includes these task files:

| Task | What it does |
|------|--------------|
| `tasks/ssh.yml`      | Installs SSH keys and registers authorized keys |
| `tasks/zsh.yml`      | Sets zsh as the login shell, installs oh-my-zsh + plugins |
| `tasks/git.yml`      | Sets global Git user name/email |
| `tasks/nvim.yml`     | Installs build deps, clones and compiles Neovim from source |
| `tasks/dotfiles.yml` | Clones the dotfiles repo and symlinks it with GNU stow |
| `tasks/macos.yml`    | Applies macOS system defaults (keyboard, Finder, Dock, etc.) |

## Prerequisites

- macOS (Apple Silicon).
- **Xcode Command Line Tools** — required by Homebrew. If missing, run
  `xcode-select --install` first (the Homebrew installer will also prompt for it).

## Managing packages

Packages are declared in the [`Brewfile`](./Brewfile) and installed with
`brew bundle` (idempotent — safe to re-run).

- Add a package: add a `brew "name"` / `cask "name"` line, then `brew bundle`.
- Snapshot the current machine: `brew bundle dump --force`.
- See what's installed but not listed: `brew bundle cleanup`.

### Package reference

**Provisioning**
- `ansible` — automation tool that runs the `local.yml` playbook

**Shell & terminal**
- `zsh` — the shell
- `tmux` — terminal multiplexer
- `tmuxinator` — manage tmux sessions from YAML config

**CLI utilities**
- `coreutils` — GNU core utilities (GNU versions of ls, cp, etc.)
- `bat` — `cat` with syntax highlighting and paging
- `eza` — modern `ls` replacement
- `fd` — fast, user-friendly `find`
- `fzf` — fuzzy finder
- `ripgrep` — fast recursive search (`rg`)
- `jq` — command-line JSON processor
- `yq` — command-line YAML processor (query/edit k8s manifests, Helm values)
- `htop` — interactive process viewer
- `watch` — run a command repeatedly and watch its output
- `stow` — symlink manager used to deploy dotfiles
- `httpie` — human-friendly HTTP client
- `hey` — HTTP load generator
- `direnv` — per-directory environment variables via `.envrc`
- `zoxide` — smarter `cd` that learns your frequent directories (`z`)
- `btop` — resource monitor with a richer UI than `htop`
- `fx` — interactive terminal JSON viewer
- `jless` — JSON/YAML pager for exploring structured data
- `shellcheck` — static analysis linter for shell scripts
- `shfmt` — shell script formatter
- `mas` — Mac App Store command-line interface

**Languages & version management**
- `asdf` — manages runtime versions from `.tool-versions`
- `rustup` — Rust toolchain installer/manager
- `lua` — Lua interpreter
- `luarocks` — Lua package manager

**Neovim build dependencies**
- `cmake` — build system generator
- `ninja` — fast build backend
- `gettext` — provides `libintl`, required to compile Neovim

**Databases**
- `pgcli` — Postgres CLI with autocompletion and syntax highlighting
- `pgweb` — web-based Postgres client

**Go development**
- `delve` — Go debugger
- `grpcurl` — `curl`-like tool for interacting with gRPC services

**Containers & Kubernetes**
- `dive` — inspect Docker image layers
- `kubectl` — Kubernetes CLI
- `kind` — run local Kubernetes clusters in Docker
- `helm` — Kubernetes package manager
- `kustomize` — customize Kubernetes manifests
- `stern` — tail logs across multiple pods
- `k9s` — terminal UI for managing Kubernetes clusters
- `kubectx` — quickly switch kubectl contexts and namespaces (`kubectx`/`kubens`)

**Infrastructure**
- `opentofu` — infrastructure as code (open-source Terraform fork; `tofu`)

**Casks**
- `orbstack` — fast, lightweight Docker & Linux runtime (Docker Desktop replacement)
- `raycast` — launcher / productivity app
- `zed` — high-performance code editor

**Fonts**
- `font-cascadia-code` — Cascadia Code
- `font-jetbrains-mono` — JetBrains Mono

## Managing language versions

Runtime versions are pinned in [`.tool-versions`](./.tool-versions) and installed
via asdf. To bump one:

```sh
asdf install nodejs <version>
asdf set --home nodejs <version>
# then update .tool-versions to match
```

## Secrets (Ansible Vault)

The SSH private key in `.ssh/` is committed **encrypted** with Ansible Vault, so
the repo is safe to keep on GitHub. The vault password is entered interactively
at runtime.

```sh
# Edit an encrypted file
ansible-vault edit .ssh/id_ed25519

# Encrypt a new file
ansible-vault encrypt .ssh/<file>
```

## Re-running

The whole setup is idempotent — you can re-run `./run.local.sh` at any time to
converge the machine to the declared state.
