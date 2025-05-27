#!/bin/bash
gh auth login

# 2.  fill in your github username
USERNAME="haifishbro209"
mkdir -p all_repos && cd all_repos

gh repo list $USERNAME --limit 1000 --json name,sshUrl -q '.[] | .sshUrl' |
while read repo; do
  git clone --depth=1 "$repo"
done

tokei . --exclude *.txt --exclude *.fst --exclude *.fsti

cd ..
echo -e "\n🧹 Deleting cloned repos ..."
rm -rf all_repos
echo "✅ Done"
