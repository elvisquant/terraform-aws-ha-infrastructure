#!/bin/bash

# =============================
# Git Auto-Push Script
# Author: Ndayishimiye Elvis
# =============================

# ==== CONFIG ====
REMOTE_URL="git@github.com:elvisquant/terraform-aws-ha-infrastructure.git"  # ✅ Replace if needed
BRANCH_NAME="main"
COMMIT_MESSAGE="Update with new changes: Update thie project with new features"

# ==== Step 1: Confirm Git is at project root ====
echo "📁 Working from: $(pwd)"

# ==== Step 2: Initialize Git if needed ====
if [ ! -d ".git" ]; then
  echo "🌀 Initializing Git repository..."
  git init
  git checkout -b "$BRANCH_NAME"
else
  echo "✔️ Git already initialized."
fi

# ==== Step 3: Create .gitignore if not exists ====
if [ ! -f ".gitignore" ]; then
  echo "🔒 Creating .gitignore..."
  cat <<EOL > .gitignore
# Python
__pycache__/
*.py[cod]
*.env
.env

#file
push.sh

# Virtual Environment
venv/
env/

# OS & Logs
.DS_Store
*.log

# SQLite & Other DBs
*.sqlite3
*.db

# Frontend Builds (if any)
dist/
build/

# IDE & Editor Configs
.vscode/
.idea/
EOL
fi

# ==== Step 4: Add, Commit, Push ====
echo "📝 Staging all files..."
git add .

echo "✅ Committing changes..."
git commit -m "$COMMIT_MESSAGE" || echo "ℹ️ Nothing new to commit."

echo "🔗 Setting remote origin..."
git remote remove origin 2>/dev/null
git remote add origin "$REMOTE_URL"

echo "🌿 Switching to branch '$BRANCH_NAME'..."
git branch -M "$BRANCH_NAME"

echo "📤 Pushing to GitHub..."
git push -u origin "$BRANCH_NAME"

echo "✅ Done! Your code is now live on: $REMOTE_URL [$BRANCH_NAME]"
