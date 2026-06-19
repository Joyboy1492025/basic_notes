# **Git guide**
---

## 🔹 1. Creating a New Repository (from scratch)
Use this when you’re starting a brand‑new project.

```bash
# Step 1: Create a README file
echo "# myproject" >> README.md

# Step 2: Initialize Git
git init

# Step 3: Stage files
git add README.md

# Step 4: Commit changes
git commit -m "first commit"

# Step 5: Rename branch to main
git branch -M main

# Step 6: Connect to GitHub
git remote add origin https://github.com/username/myproject.git

# Step 7: Push to GitHub
git push -u origin main
```

---

## 🔹 2. Pushing an Existing Repository
Use this if you already have code locally and want to link it to GitHub.

```bash
# Step 1: Connect to GitHub
git remote add origin https://github.com/username/myproject.git

# Step 2: Rename branch to main
git branch -M main

# Step 3: Push existing commits
git push -u origin main
```

---

## 🔹 3. Cloning a Repository
Use this when you want to copy a project from GitHub to your computer.

```bash
# Step 1: Clone the repo
git clone https://github.com/username/myproject.git

# Step 2: Move into the project folder
cd myproject

# Step 3: Check branches
git branch -a
```

---

## 🔹 4. Everyday Git Commands
These are the ones you’ll use constantly:

- **Check status**
  ```bash
  git status
  ```
- **Stage all files**
  ```bash
  git add .
  ```
- **Commit changes**
  ```bash
  git commit -m "updated feature X"
  ```
- **Push changes**
  ```bash
  git push
  ```
- **Pull latest changes**
  ```bash
  git pull
  ```
- **View history**
  ```bash
  git log
  ```

---

## 🔹 5. Branching & Merging
For working on features separately:

```bash
# Create new branch
git checkout -b feature-branch

# Switch back to main
git checkout main

# Merge branch into main
git merge feature-branch
```

---

## 🔹 6. Quick Mental Map
- **New repo** → `init → add → commit → push`
- **Existing repo** → `remote → branch → push`
- **Clone repo** → `clone → work → commit → push`
