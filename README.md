# Cydia Repo Builder 🛠️

An automated, lightweight Unix shell script suite designed to instantly generate, configure, and deploy custom Cydia repositories. Written in pure POSIX-compliant shell logic, this suite is built to run flawlessly across any environment—whether it's **Linux (Ubuntu/WSL2)**, **macOS Terminal**, or directly on an iOS device using **MTerminal**.

This suite automates repository creation, interactive tweak indexing, and GitHub Pages deployment, while enforcing a strict security boundary to keep your internal setup scripts hidden from your public repository.

---

## 🚀 Features

- **Dynamic Initialization (`Projects.sh`):** Instantly scaffolds Cydia architecture, automated GitHub Actions workflows (`compiler.yml`), metadata (`Release`), open-source licenses, and optional `FUNDING.yml` structures.
- **Nostalgic Web UI:** Optional setup of an iOS 6 themed repository homepage with authentic fonts, styling, and native "Add to Cydia" protocol triggers.
- **Interactive Tweak Indexing (`Packages.sh`):** Scans binary `.deb` tweaks, extracts internal metadata fields, prompts for mandatory maintainer contact details, and auto-calculates Unix cryptographic signatures (`MD5`, `SHA1`, `SHA256`).
- **Self-Generating Runtime Tools (`Update.sh`):** Generates a lowercase execution binary (`update.sh`) locally on command.
- **Secure Firewalled Deployment (`github.sh`):** Handles automated git tracking structures, isolates or matches secure protocols (HTTP/HTTPS) for custom or GitHub Pages domains, and strips out your private developer utilities from being pushed online.

---

## 📂 Core Utility Structure

Your local suite consists of 4 primary executable scripts:

| Script Name | Purpose | Target Environment | Distributable? |
| :--- | :--- | :--- | :--- |
| **`Projects.sh`** | Repository & Architecture Scaffolder | Local Terminal | ❌ Private (Local Only) |
| **`Packages.sh`** | Interactive `.deb` Checksum Database Builder | Local Terminal | ❌ Private (Local Only) |
| **`Update.sh`** | Code Generator for the `update.sh` index compiler | Local Terminal | ❌ Private (Local Only) |
| **`github.sh`** | Secure Git Deployment Engine & Domain Manager | Local Terminal | ❌ Private (Local Only) |

---

## 🛠️ Step-by-Step Usage

### 1. Set Permissions
Clone or copy the 4 management scripts into your local working directory and grant them global Unix execution privileges:
```bash
chmod +x *.sh
