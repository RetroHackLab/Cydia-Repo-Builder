# Contributing to Cydia Repo Builder 🚀

Thank you for your interest in contributing to **Cydia Repo Builder**! This project is designed to help legacy iOS developers and security researchers easily build and manage custom Cydia repositories. 

To maintain code stability and protect developer workflows, please review the guidelines below before submitting issues or pull requests.

---

## 🔒 Crucial Security Rule

This project uses a selective deployment strategy to keep administrative tools private while deploying only production assets to GitHub Pages.

* **DO NOT MODIFY** the `.sh` tracking rules inside `github.sh` without a thorough review.
* **NEVER commit or push** your personal repository configurations, private keys, or customized setup scripts to any public upstream branches.
* The only shell script meant to be uploaded to your final repository is the generated lowercase `update.sh` file.

---

## 🛠️ Development Environment

To ensure your contributions run flawlessly across all native platforms, please verify that your environment matches these standards:
- **Languages:** Pure POSIX-compliant Shell Scripting (`sh`, `bash`).
- **Target OS Compatibility:** Linux (Ubuntu 22.04 LTS / WSL2), macOS Terminal, and native iOS environments (MTerminal / NewTerm).
- **Line Endings:** All shell scripts **MUST** use Unix line endings (**LF**). Avoid Windows-style `CRLF` at all costs, as it breaks shell executions on Unix systems.

---

## 🔀 Workflow & Pull Requests

1. **Fork the Repository:** Create a personal fork of the project on GitHub.
2. **Create a Feature Branch:** Keep your branches focused on a single feature or bug fix.
   ```bash
   git checkout -b feature/amazing-tweak
