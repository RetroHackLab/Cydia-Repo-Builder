#!/bin/sh
# Projects.sh - Cydia Repo Structure Setup

echo "========================================="
echo "       CYDIA REPO BUILDER - SETUP        "
echo "========================================="

# Core Prompts
printf "Enter Repo Name: "
read REPO_NAME
printf "Enter Your Name: "
read YOUR_NAME
printf "Description: "
read DESC
printf "Version (e.g., 1.0.0): "
read VERSION

echo "Select Architecture Option:"
echo "1) iphoneos-arm"
echo "2) iphoneos-arm64"
printf "Selection [1-2]: "
read ARCH_OPT
if [ "$ARCH_OPT" = "2" ]; then ARCH="iphoneos-arm64"; else ARCH="iphoneos-arm"; fi

# Directory Structure Generation
mkdir -p debs
mkdir -p .github/workflows

# Generate Initial Release File
cat << EOF > Release
Origin: $REPO_NAME
Label: $REPO_NAME
Suite: stable
Version: $VERSION
Codename: ios
Architectures: $ARCH
Description: $DESC
EOF

# License Selection Menu
echo "\nSelect LICENSE (Open-Source):"
echo "A- MIT LICENSE"
echo "B- GNU GPLv3"
echo "C- Apache 2.0"
printf "Selection [A/B/C]: "
read LIC_OPT

case "$LIC_OPT" in
    [bB]) LIC_NAME="GPLv3" ;;
    [cC]) LIC_NAME="Apache-2.0" ;;
    *) LIC_NAME="MIT" ;;
esac

# Web UI Setup (Nostalgic iOS 6 Theme)
printf "\nWould you like to add UI of your repo that can access on your web? (yes/no): "
read UI_OPT
if [ "$UI_OPT" = "yes" ] || [ "$UI_OPT" = "y" ]; then
    cat << EOF > index.html
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>$REPO_NAME</title>
    <style>
        body { background: #c5cbd4; font-family: "Helvetica Neue", Helvetica, Arial, sans-serif; margin: 0; padding: 0; }
        .bar { background: linear-gradient(#b4bbc6, #6d7b92); padding: 10px; text-align: center; color: white; font-weight: bold; text-shadow: 0 -1px 0 rgba(0,0,0,0.5); box-shadow: 0 1px 3px rgba(0,0,0,0.3); }
        .box { background: white; border: 1px solid #999; border-radius: 10px; margin: 20px; padding: 15px; box-shadow: 0 1px 2px rgba(0,0,0,0.1); }
        .btn { display: block; background: linear-gradient(#5ea4f3, #155ec9); border: 1px solid #0f499c; border-radius: 5px; color: white; text-align: center; padding: 12px; font-weight: bold; text-decoration: none; text-shadow: 0 -1px 0 rgba(0,0,0,0.6); }
        h2 { font-size: 18px; color: #4c566c; margin: 0 0 10px 0; text-shadow: 0 1px 0 white; }
    </style>
</head>
<body>
    <div class="bar">$REPO_NAME</div>
    <div class="box">
        <h2>Welcome to $REPO_NAME</h2>
        <p>$DESC</p>
        <p><strong>Author:</strong> $YOUR_NAME</p>
        <p><strong>License:</strong> $LIC_NAME</p>
        <a class="btn" href="cydia://url/https://cydia.saurik.com/api/share#?source=https://github.com/yourname/yourrepo/">Add to Cydia</a>
    </div>
</body>
</html>
EOF
fi

# Profile / Readme Redirection Option
printf "\nWould you like to add Simple UI that contain One of your readme link of your other projects or your profile readme? (yes/no): "
read REDIRECT_OPT
if [ "$REDIRECT_OPT" = "yes" ] || [ "$REDIRECT_OPT" = "y" ]; then
    printf "Enter a Valid Readme LINK: "
    read README_LINK
    mkdir -p prj
    cat << EOF > prj/index.html
<script>window.location.replace('$README_LINK');</script>
EOF
fi

# Funding / Donation Profiles Option
printf "\nWould you want to add FUNDING.yml? (yes/no): "
read FUND_OPT
if [ "$FUND_OPT" = "yes" ] || [ "$FUND_OPT" = "y" ]; then
    mkdir -p .github
    printf "Enter GitHub Username: "
    read GH_USER
    printf "Enter Ko-fi URL name (optional): "
    read KO_FI
    printf "Enter Paypal Username (optional): "
    read PAYPAL
    
    cat << EOF > .github/FUNDING.yml
github: [$GH_USER]
ko_fi: $KO_FI
custom: [$PAYPAL]
EOF
fi

# Native GitHub Actions Automator File Creation
cat << 'EOF' > .github/workflows/compiler.yml
name: Compiler and Deploy Repo

on:
  push:
    branches:
      - main

permissions:
  contents: write
  id-token: write
  pages: write

concurrency:
  group: pages
  cancel-in-progress: true

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout Repository
      uses: actions/checkout@v4
      with:
        fetch-depth: 0

    - name: Dynamically Scan and Generate Indexes
      run: |
        sudo apt-get update && sudo apt-get install -y bzip2
        rm -f Packages.gz Packages.bz2
        gzip -9fk Packages
        bzip2 -9fk Packages

    - name: Upload and Push Generated Files to Main Branch
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      run: |
        git config --local user.email "41898282+github-actions[bot]@users.noreply.github.com"
        git config --local user.name "github-actions[bot]"
        git add -f Packages Packages.gz Packages.bz2 Release
        git commit -m "Autogen: Refresh repo indexes (.bz2, .gz) [skip ci]" || echo "No changes"
        git push origin main

    - name: Setup Pages
      uses: actions/configure-pages@v5

    - name: Upload Artifact
      uses: actions/upload-pages-artifact@v3
      with:
        path: '.'

    - name: Deploy to GitHub Pages
      uses: actions/deploy-pages@v4
      echo "\n [V] Environement initialized Succesfuly"
