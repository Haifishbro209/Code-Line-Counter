# GitHub Repo Code Line Counter

This script clones all repositories from your GitHub account, counts the lines of code using **tokei**, and then cleans up by deleting the cloned repositories. It supports HTTPS cloning and outputs a detailed summary of code statistics.

---

## Features
- Clone all your GitHub repos with `--depth=1` (shallow clone)
- Count code lines excluding unnecessary files
- Automatically deletes cloned repos after analysis
- Supports Windows, macOS, and Debian-based Linux

---

## Prerequisites

- GitHub CLI (`gh`) installed and authenticated
- `tokei` installed (a code line counter)
- `git` installed

---

## Installation & Setup

### 1. Install dependencies

#### Windows (using [Chocolatey](https://chocolatey.org/))

```powershell
choco install gh
choco install git
choco install rustup
rustup install stable
cargo install tokei
```

#### macOS (using [Homebrew](https://brew.sh/))

```bash
brew install gh
brew install git
brew install rustup
rustup install stable
cargo install tokei
```

#### Debian/Ubuntu Linux

```bash
sudo apt update
sudo apt install gh git curl build-essential
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
rustup install stable
cargo install tokei
```

---

### 2. Authenticate GitHub CLI

Run the following command and follow the prompts to log in:

```bash
gh auth login
```

Choose **GitHub.com**, select **HTTPS** as the preferred protocol, and authenticate via web browser.

---

## Usage

1. Create a script file, e.g. `count_repos.sh`, and paste the following script:

```bash
#!/bin/bash

USERNAME="your_github_username"

mkdir -p all_repos
cd all_repos

gh repo list $USERNAME --limit 1000 --json name,cloneUrl -q '.[] | .cloneUrl' | while read repo; do
  echo "Cloning $repo ..."
  git clone --depth=1 "$repo"
done

echo -e "\\n\\n📊 --- Code line count ---\\n"
tokei .

cd ..
rm -rf all_repos
echo "✅ Done."
```

2. Replace `your_github_username` with your actual GitHub username.

3. Make the script executable and run it:

```bash
chmod +x count_repos.sh
./count_repos.sh | tee code_line_count.txt
```

---

## Notes

- The script uses **HTTPS** to avoid SSH key issues.
- The `--depth=1` option clones only the latest snapshot of each repo to save time and disk space.
- It is recommended to **pipe the output to a file** using `tee` or redirection (`>`) to save the code statistics.
- After the count finishes, all cloned repos will be deleted automatically.

---

## Troubleshooting

- If you encounter permission issues, ensure you have authenticated `gh` with sufficient access.
- If `tokei` is not found, verify Rust and Cargo are properly installed.
- For Windows users, consider running the script inside Git Bash or WSL for best compatibility.

---

Feel free to modify or extend the script to suit your needs!
"""
```
