#!/bin/sh
# github.sh - Git Deployment and Initialization Engine

clear
echo "========================================="
echo "      GITHUB DEPLOYMENT CONFIGURATOR     "
echo "========================================="

# 1. Ask for GitHub Username to calculate URLs
printf "Enter your GitHub Username: "
read GH_USER

# 2. Choose Repository Type
echo "\nSelect Repository Domain Type:"
echo "A- $GH_USER.github.io (Standard GitHub Pages)"
echo "B- Custom Domain (e.g., myrepo.com)"
printf "Selection [A/B]: "
read DOMAIN_OPT

case "$DOMAIN_OPT" in
    [bB])
        printf "Enter your Custom Domain Name: "
        read CUSTOM_NAME
        
        echo "\nSelect Domain Protocol:"
        echo "A- Native Protocol (HTTP)"
        echo "B- Secured Protocol (HTTPS)"
        printf "Selection [A/B]: "
        read PROTO_OPT
        
        if [ "$PROTO_OPT" = "b" ] || [ "$PROTO_OPT" = "B" ]; then
            FINAL_URL="https://$CUSTOM_NAME"
        else
            FINAL_URL="http://$CUSTOM_NAME"
        fi
        ;;
    *)
        FINAL_URL="https://$GH_USER.github.io"
        ;;
esac

# 3. Enter the Target Repository Name
printf "\nEnter your GitHub Repository Name (e.g., cydia-repo): "
read REPO_NAME

# Complete remote URL mapping string
REMOTE_URL="https://github.com/$GH_USER/$REPO_NAME.git"

echo "\n[*] Preparing local Git repository tracking..."

# 4. Initialize Git tracking inside your Preparate folder
git init

# 5. Stage everything, then remove all private .sh scripts from tracking index
git add .
git rm --cached *.sh 2>/dev/null
git rm --cached *.[sS][hH] 2>/dev/null

# 6. Specifically force-add ONLY the public lowercase update.sh file
if [ -f "update.sh" ]; then
    git add -f update.sh
else
    echo "Warning: update.sh not found! Make sure to run Update.sh first."
fi

# 7. Create the initial deployment commit
git commit -m "Initial commit - Cydia Repo Structure Setup"

echo "\n========================================="
echo "Target Deployment URL: $FINAL_URL"
echo "Remote Git Destination: $REMOTE_URL"
echo "========================================="
printf "Verify your repository is created at github.com/new\nPress ENTER to push downstream..."
read pause_push

# 8. Link your terminal project and force push upstream
git remote add origin "$REMOTE_URL" 2>/dev/null || git remote set-url origin "$REMOTE_URL"
git branch -M main
git push -u origin main --force

echo "\n[V] Repository successfully pushed! All setup tools are hidden except update.sh"
