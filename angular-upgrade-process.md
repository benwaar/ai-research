# Angular Library Upgrade Process

---

## � **Project Configuration**

**IMPORTANT**: Before starting the upgrade process, determine the project identifier for your organization:

**Default Project**: `DAVIDSPROJ`

**Prompt**: "What project identifier should we use for this upgrade? (Default: DAVIDSPROJ)"

This PROJECT identifier will be used for:
- Package naming: `@{PROJECT}-tech/package-name`
- Library references throughout the upgrade process
- Dependency management for project-specific packages

---

## �📝 **Developer Notes** (For Reference Only - Ignore During Process Execution)

### Useful Commands for Troubleshooting Upgrades
```bash
# Environment setup
nvm use 18

# Dependency management
npm i
npm run build
npm ls some-lib  
npx depcheck 
npx npm-check-updates --target minor

# Angular CLI management
npm uninstall -g @angular/cli
npm install -g @angular/cli@16
ng update
ng update @angular-eslint/schematics@16
```

---

## Overview
A standardized process for upgrading Angular libraries to the next major version while maintaining compatibility and ensuring all dependencies are updated appropriately.

## Prerequisites
- Access to npm registry (check `.npmrc` configuration)
- Git repository with proper permissions
- JIRA ticket for tracking the upgrade

---

## Step-by-Step Process

### 1. **Get JIRA Ticket Number**
**IMPORTANT**: Before starting the upgrade process, determine the JIRA ticket number based on the Angular version you are upgrading TO:

**Predefined JIRA Numbers:**
- **Upgrading TO Angular 16**: JIRA-001
- **Upgrading TO Angular 17**: JIRA-001

**For other Angular versions**: Ask the user "What JIRA ticket number should we use for this Angular {version} upgrade?"

This JIRA number will be used in:
- Branch naming: `feature/[JIRA]_Upgrade_Angular_to_{version}`
- Commit messages: `[JIRA]: Description of changes`
- Pull request title and description

### 2. **Check Registry Access**
Verify that the npm registry in `.npmrc` is accessible:
```bash
npm config get registry
npm view @angular/core version
```

### 3. **Switch to Master Branch**
Ensure you're starting from the latest master branch:
```bash
git checkout master
git pull origin master
```

### 4. **Create Feature Branch**
Create a new branch using the provided JIRA number:
```bash
git checkout -b feature/[JIRA]_Upgrade_Angular_to_{next_major_version}
```
Example: `git checkout -b feature/JIRA-001_Upgrade_Angular_to_17`

### 5. **Verify Clean State**
Install dependencies and build to ensure everything works before upgrading:
```bash
npm install
npm run build
```
Verify no compilation errors exist.

### 6. **Run Angular Update**
Update Angular and related packages to the next major version:
```bash
ng update @angular-eslint/schematics@{next_version}
```
Example: `ng update @angular-eslint/schematics@17`

This will:
- Update all Angular packages
- Update Angular CLI and dev tools
- Run necessary migrations
- Update configuration files

### 7. **Commit Angular Upgrade**
Commit the initial Angular upgrade using the JIRA number:
```bash
git add .
git commit -m "[JIRA]: Upgrade Angular to v{version} and related dependencies"
```
Example: `git commit -m "JIRA-001: Upgrade Angular to v17 and related dependencies"`

### 8. **Update Supporting Libraries**
Update other libraries to be compatible with the new Angular version:
```bash
npx npm-check-updates --target minor -u
npm install
```

Fix any peer dependency conflicts by adjusting versions to be compatible with the new Angular version.

### 9. **Update PROJECT Libraries**
Update only the PROJECT-specific libraries that are found in the project:
```bash
# List all PROJECT packages to see what's currently installed
npm list | grep @{PROJECT}-tech

# Update PROJECT packages individually by name with Angular version
# Example: if @{PROJECT}-tech/common-config is found:
npm install @{PROJECT}-tech/common-config@{angular_version} --legacy-peer-deps
# Add other packages as needed based on what's found above

npm install --legacy-peer-deps
```

**Note**: Update each PROJECT package individually by name with the target Angular version (e.g., `@{PROJECT}-tech/common-config@17`). Use `npm list | grep @{PROJECT}-tech` to see which packages are present, then update them one by one. Check for and resolve any peer dependency warnings for all PROJECT libraries.

### 10. **Commit Library Updates**
Commit the supporting and PROJECT library updates using the JIRA number:
```bash
git add .
git commit -m "[JIRA]: Update supporting libraries and PROJECT packages to Angular {version} compatible versions"
```

### 11. **Clean Workspace**
Remove generated folders to ensure a fresh build:
```bash
rm -rf coverage dist node_modules
```

### 12. **Fresh Install**
Create a clean dependency installation:
```bash
rm package-lock.json
npm install --legacy-peer-deps
```

### 13. **Verify Build and Tests**
Ensure everything works with the new versions:
```bash
npm run build
npm test
```
Verify:
- Build completes successfully
- All tests pass
- Good test coverage maintained

### 14. **Update Package Versions**
Update the main package version to match the Angular major version:
- In `package.json`: Update version to `{angular_major}.0.0`
- In `projects/{library}/package.json`: 
  - Update version to match main package
  - Update peer dependencies to new Angular versions
  - **Update PROJECT peer dependencies**: Change `@{PROJECT}-tech/*` packages to match Angular version (e.g., `~15.2.12` → `~16.2.12`)
  - Update other dependencies as needed

### 15. **Commit Version Updates**
Commit the version and peer dependency changes using the JIRA number:
```bash
git add .
git commit -m "[JIRA]: Update version to {version} and Angular {version} peer dependencies"
```

### 16. **Push Branch**
Push the feature branch to remote repository:
```bash
git push origin feature/[JIRA]_Upgrade_Angular_to_{version}
```

### 17. **Generate Commit Summary for PR**
Display the commit messages for easy copy-paste into pull request:
```bash
git log --oneline master..HEAD
```
This will show all commits made during the upgrade for inclusion in the PR description.

### 18. **Create Pull Request**
Create a pull request with the following template:

**Title**: `[JIRA]: Upgrade Angular to v{version} and update dependencies`

**Description**:
```markdown
## Summary
Upgrades Angular from v{old_version} to v{new_version} and updates all supporting dependencies to compatible versions.

## Changes Made
- ⬆️ Upgraded Angular core packages to v{new_version}
- ⬆️ Updated Angular CLI and dev tools to v{new_version}
- ⬆️ Updated TypeScript to compatible version
- ⬆️ Updated supporting libraries (ESLint, Karma, Jasmine, etc.)
- 📦 Updated package version from {old_version} → {new_major}.0.0
- 🔄 Updated peer dependencies in library package.json
- ✅ All tests passing
- ✅ Build successful
- ✅ Code coverage maintained

## Testing
- [x] Build passes
- [x] All tests pass
- [x] No breaking changes in library API
- [x] Peer dependencies updated correctly

## JIRA Ticket
[JIRA_NUMBER]
```

---

## Key Principles

### ✅ **Do's**
- Always start from a clean master branch
- Commit changes in logical groups
- Verify build and tests after each major step
- Update peer dependencies to match Angular version
- Maintain version consistency across packages
- Use semantic versioning aligned with Angular major versions

### ❌ **Don'ts**
- Don't skip the initial clean state verification
- Don't commit all changes in one large commit
- Don't ignore peer dependency warnings
- Don't upgrade beyond what's needed (stick to target Angular version)
- Don't forget to update the library's package.json

---

## Troubleshooting

### Common Issues
1. **Peer Dependency Conflicts**: Adjust versions to match Angular requirements
2. **TypeScript Version Issues**: Use Angular-compatible TypeScript version
3. **Build Failures**: Check for breaking changes in Angular migration guide
4. **Test Failures**: Update test configurations if needed

### Version Compatibility
- **Angular 16**: TypeScript ~5.1.x, RxJS ~7.8.x, zone.js ~0.13.x
- **Angular 17**: TypeScript ~5.4.x, RxJS ~7.8.x, zone.js ~0.14.x
- **Angular 18**: TypeScript ~5.4.x, RxJS ~7.8.x, zone.js ~0.14.x

---

## Example Commands Summary
```bash
# Complete upgrade workflow example 
# Step 1: Determine JIRA number based on Angular version:
#   - Angular 16: JIRA-001
#   - Angular 17: JIRA-001
#   - Others: Ask user
# Step 2: Execute workflow (example shows Angular 17)
git checkout master && git pull origin master
git checkout -b feature/JIRA-001_Upgrade_Angular_to_17
npm install && npm run build
ng update @angular-eslint/schematics@17
git add . && git commit -m "JIRA-001: Upgrade Angular to v17 and related dependencies"
npx npm-check-updates --target minor -u && npm install
npm list | grep @{PROJECT}-tech && npm install @{PROJECT}-tech/common-config@17 --legacy-peer-deps
git add . && git commit -m "JIRA-001: Update supporting libraries and PROJECT packages to Angular 17 compatible versions"
rm -rf coverage dist node_modules && rm package-lock.json && npm install --legacy-peer-deps
npm run build && npm test
# Update versions in package.json files
git add . && git commit -m "JIRA-001: Update version to 17.0.0 and Angular 17 peer dependencies"
git push origin feature/JIRA-001_Upgrade_Angular_to_17
# Generate commit summary for PR
git log --oneline master..HEAD
```

---

*Last Updated: October 8, 2025*
*Process developed for Angular library upgrades*