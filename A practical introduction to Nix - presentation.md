
# A practical introduction to Nix

---

## Prelude

![[Pasted image 20250512112828.png]]

---

## 🗂️ Overview

| Section                      | Description                                                                                  |
| ---------------------------- | -------------------------------------------------------------------------------------------- |
| **Introduction**             | Nix on my new MacBook Air                                                                    |
| **Nix as a Package Manager** | Installing Nix, managing profiles, installing/upgrading packages, version pinning, rollbacks |

---

| Section            | Description                                                    |
| ------------------ | -------------------------------------------------------------- |
| **Under the Hood** | How Nix stores packages on disk, Git analogy                   |
| **What Is Nix?**   | The roles of Nix, its ecosystem, Nixpkgs, NixOS), and “flakes” |

---

## Use case: Consistent Cross-platform Setup

- **Context**  
  - New MacBook Air → replicate Ubuntu setup  
- **Goals**  
  - Consistent, declarative package installs  
  - Cross-platform parity (macOS & Linux)  
  
---

## Use case: Pin native deps version

- **Context**  
  - Set up personal blog with Hugo static site generator
  - Newer version of Hugo breaks backward compatibility
- **Goals**  
  - Easy version pinning & rollback  

---
## Use case: Holistics dev environment

- **Context**  
  - Set up Holistics development environment on both MacOS/Linux
- **Goals**  
  - Consistent, declarative package installs  
  - Cross-platform parity (macOS & Linux)  
  - Easy to adopt by everyone
  
---
## Why Nix?

**Pros:**  
- True cross-platform reproducibility  
- Declarative configs  
- Atomic upgrades & rollbacks  

**Cons:**  
- Steeper learning curve  
- Heavy initial setup  
- Flakes & tooling evolving  

---

## Installing Nix

Installing Nix
```bash
curl -L https://nixos.org/nix/install | sh # Official Nix
curl -fsSL https://install.determinate.systems/nix | sh -s -- install # Determinate Nix
```

Enable modern CLI interface and flakes
```
# Add to ~/.config/nix/nix.conf
experimental-features = nix-command flakes
```

---

## Managing Your Profile

- **Install**
    ```bash
    nix profile install nixpkgs#wget
    ```
- **Search**:  [NixOS Search – Packages](https://search.nixos.org/)
- Explore **older versions** via [Nix Package Versions](https://lazamar.co.uk/nix-versions/)

---
## Managing Your Profile (cont.)

- **Upgrade**
    ```bash
    nix profile upgrade
    ```
- **Pin a Version**
    ```bash
    # Latest version
    nix profile install nixpkgs#hugo
    # Specific version
    nix profile install nixpkgs/4ab8a3de296914f3b631121e9ce3884f1d34e1e5#hugo
    ```

---

## Profile History & Rollbacks

- **View history**
    ```bash
    nix profile history
    ```
- **Roll back**
    ```bash
    nix profile rollback --to <version>
    ```
- **Benefit:** Atomic, reversible changes

---

## Ad Hoc Usage

- **Run a package once**
    ```bash
    nix run nixpkgs#hello
    nix run nixpkgs#{hello,cowsay}
    ```
- **Temporary shell**
    ```bash
    nix shell nixpkgs#nodejs
    echo $PATH
    ```
- Try without polluting main profile

---
## Advantages compared to other package managers
* History tracking, easy rollback
* Install any version of a package easily
* No conflict across packages
* Easy adhoc environment setup

---

## Under the Hood: Profile Storage

1. **Inspect symlink**
    ```bash
    ls -la ~/.nix-profile
    ```
2. **Tree view** (with `nix-tree`)
    ```bash
    nix-tree ~/.nix-profile
    ```
3. **Profile structure**  
    ![Profile Structure](../../files/Pasted image 20250421152238.png)
---

## Git Analogy

| Concept            | Git Equivalent |
| ------------------ | -------------- |
| Profile            | Branch         |
| Version (revision) | Commit         |

- **Use custom profile**
    
    ```bash
    nix profile install --profile /tmp/my-other-profile nixpkgs#{ripgrep,jq}
    export PATH="/tmp/my-other-profile/bin:$PATH"
    ```
    
- Issue: [#8560 nix profile switch](https://github.com/NixOS/nix/issues/8560)
```
nix-env --switch-profile /tmp/my-other-profile
```
    

---
## Declarative package installation
```
nix profile install github:9diov/nix-workshop#example1
```

---
## Registry
```
nix registry add nix-workshop github:9diov/nix-workshop
nix profile install nix-workshop#example1
```

--- 

## Example package: oracle-instant-client

https://github.com/holistics/oracle-instant-client

```
nix profile install github:holistics/oracle-instant-client
```

---

## Flox - friendly wrapper around Nix

* Using Nix like a normal language package manager (Ruby/NodeJS/etc.)
* Automatic dependency resolution
* Better shell integration across Bash/Zsh/Fish (nix shell only supports Bash)
* No need to learn Nix

---

## What Is Nix?
> Nix is the Latin word for "snow". 

An ecosystem of tools to create **reproducible** environments.

1. **Package Manager** (apt, brew, yum)
2. **Build System** (Make, CMake, Bazel)
3. **Dev-Env Manager** (pyenv, rbenv)

---

## Nix Ecosystem

- **Nix-lang**: Functional DSL for package recipes
- **Nixpkgs**: Collection of packages built using Nix-lang & binary cache
- **NixOS**: Declarative Linux distro (all configurations written in Nix-lang)
    - Fun fact: Mitchell Hashimoto runs NixOS in VM on MacBook
        

---
## Nix Flakes

- Standardized Nix composition
- Defines inputs/outputs clearly
- Ensures reproducible dependency graphs

---
## Nix adoption
* More and more Github repos are using Nix for reproducible development environment
* Examples
    * [GitHub - helix-editor/helix: A post-modern modal text editor.](https://github.com/helix-editor/helix)
    * [GitHub - zed-industries/zed: Code at the speed of thought – Zed is a high-performance, multiplayer code editor from the creators of Atom and Tree-sitter.](https://github.com/zed-industries/zed)

---


## Conclusion & Next Steps

- **Why Nix?**
    - Reproducibility, atomicity, cross-platform
- **Explore:**
    - [Nixpkgs manual](https://nixos.org/manual/nixpkgs/)
    - [home-manager](https://github.com/nix-community/home-manager)
    - [nix-darwin](https://github.com/LnL7/nix-darwin)
- **Experiment:** Write your first `flake.nix`

---

