# Troubleshooting Guide 🔍

This guide helps you resolve the most common issues encountered when initializing, configuring, indexing, or deploying your repository using the Cydia Repo Builder suite.

---

## 📁 1. Script Execution Issues

### ❌ Error: `Permission denied`
When attempting to run `./Projects.sh`, `./Update.sh`, `./Packages.sh`, or `./github.sh`, the terminal throws a permission error.
* **Cause:** The scripts do not have executable permissions flag set.
* **Solution:** Run the following command in your terminal to grant global execution rights:
```bash
  chmod +x Projects.sh Packages.sh Update.sh github.sh
