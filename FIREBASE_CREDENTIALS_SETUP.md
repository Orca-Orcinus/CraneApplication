# Firebase Credentials Security Setup

## Overview
This document provides security best practices for handling Firebase credentials in GitHub Actions.

## 🔒 GitHub Secrets Setup

### Step 1: Generate Firebase Service Account Key
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project: **craneapplication-a4a13**
3. Navigate to **Project Settings → Service Accounts**
4. Click **Generate New Private Key**
5. Save the JSON file securely

### Step 2: Add to GitHub Secrets
1. Go to your GitHub repository
2. Click **Settings**
3. Navigate to **Secrets and variables → Actions**
4. Click **New repository secret**
5. Add the following secrets:

| Secret Name | Value |
|------------|-------|
| `FIREBASE_TOKEN` | *See Step 3 below* |

### Step 3: Generate Firebase Token
Run this command locally to generate a reusable token:

```bash
firebase login:ci
# This will generate a long token
# Copy and paste it as FIREBASE_TOKEN in GitHub Secrets
```

**Note:** The `--token` parameter in GitHub Actions uses this CI token, NOT the service account JSON.

## ⚠️ Security Best Practices

### DO ✅
- ✅ Store all credentials in GitHub Secrets
- ✅ Use `${{ secrets.FIREBASE_TOKEN }}` in workflows
- ✅ Add sensitive files to `.gitignore`
- ✅ Use branch protection rules
- ✅ Rotate tokens regularly (quarterly recommended)
- ✅ Enable secret scanning in GitHub

### DON'T ❌
- ❌ Never commit `.json` credential files
- ❌ Never hardcode API keys in code
- ❌ Never paste credentials in issues or PRs
- ❌ Never use `GIT_DECRYPT=true` or similar hacks
- ❌ Never share your Firebase token publicly

## 🛡️ GitHub Security Features

### 1. Enable Secret Scanning
1. Go to **Settings → Security & analysis**
2. Enable **Secret scanning** and **Push protection**
3. This will prevent accidental credential pushes

### 2. Enable Branch Protection
1. Go to **Settings → Branches**
2. Add protection rule for `main` branch
3. Require status checks to pass before merging

### 3. Review Workflow Permissions
```yaml
permissions:
  contents: read  # Only read access to code
  # ❌ Avoid giving write access to secrets
```

## 📋 Workflow Security Features

Your updated workflows include:

### Credential Scanning in Merge Workflow
```bash
grep -r "AKIA" . --include="*.dart"  # AWS credentials
grep -r "ya29\." . --include="*.dart"  # Google tokens
```

This prevents accidental credential commits to the `main` branch.

### Environment Variables
- Credentials passed via `--token` parameter only
- Never logged or displayed in output
- Automatically masked in GitHub logs

## 🔄 Rotating Credentials

### Quarterly Rotation Checklist
1. Generate new Firebase token:
   ```bash
   firebase login:ci
   ```
2. Update `FIREBASE_TOKEN` secret in GitHub
3. Update `.github/workflows/firebase-hosting-*.yml` files if needed
4. Run test deployment to verify

## 🚨 If Credentials Are Compromised

1. **Immediately revoke the token:**
   ```bash
   firebase logout
   ```

2. **Remove from GitHub Secrets:**
   - Delete the compromised token
   - Generate a new one

3. **Clean Git History:**
   ```bash
   git log --all --grep="credentials\|firebase\|token" --oneline
   # Review and force push if needed
   ```

4. **Enable push protection** in GitHub to prevent future incidents

## 📚 Useful Commands

```bash
# Test Firebase deployment locally
firebase deploy --only hosting

# List current Firebase projects
firebase projects:list

# Verify credentials are loaded
firebase auth:export ./test-export --project=craneapplication-a4a13

# Check for exposed secrets in history
gitleaks detect --source git --verbose
```

## References
- [Firebase CLI Docs](https://firebase.google.com/docs/cli)
- [GitHub Secrets Documentation](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
- [GitHub Secret Scanning](https://docs.github.com/en/code-security/secret-scanning/about-secret-scanning)
