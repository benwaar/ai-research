# Conventional Commits Configuration

## Overview

This project follows the [Conventional Commits](https://www.conventionalcommits.org/) specification to ensure consistent, readable, and automatically processable commit messages.

## 🎯 Commit Message Format

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Examples
```bash
feat(auth): add OAuth2 integration
fix: resolve memory leak in data processing
docs: update API documentation
chore: update dependencies to latest versions
```

## 📋 Commit Types

### Primary Types
- **feat**: A new feature for the user
- **fix**: A bug fix for the user
- **docs**: Documentation only changes
- **style**: Changes that do not affect the meaning of the code (formatting, etc.)
- **refactor**: A code change that neither fixes a bug nor adds a feature
- **perf**: A code change that improves performance
- **test**: Adding missing tests or correcting existing tests
- **chore**: Changes to the build process or auxiliary tools

### Additional Types (Optional)
- **build**: Changes that affect the build system or external dependencies
- **ci**: Changes to CI configuration files and scripts
- **revert**: Reverts a previous commit

## 🔧 Scope Guidelines

Scopes help identify the area of change:

### For This Project
- **auth**: Authentication and authorization
- **api**: API-related changes
- **ui**: User interface components
- **docs**: Documentation updates
- **tests**: Test-related changes
- **config**: Configuration changes
- **deps**: Dependency updates
- **scripts**: Build/development scripts

### Examples with Scopes
```bash
feat(api): add user profile endpoint
fix(auth): resolve token expiration issue
docs(readme): update installation instructions
test(api): add integration tests for login
chore(deps): update Angular to v17
```

## 🚨 Breaking Changes

For breaking changes, use one of these formats:

### Option 1: Exclamation Mark
```bash
feat!: remove deprecated user API endpoints
refactor(auth)!: change authentication method
```

### Option 2: Footer
```bash
feat(api): add new user management system

BREAKING CHANGE: The old user API has been removed. 
Migrate to the new endpoints documented in /docs/api.md
```

## 📐 Message Guidelines

### Description (Required)
- Use imperative mood ("add" not "added" or "adds")
- Don't capitalize first letter
- No period at the end
- Keep under 50 characters when possible

### Body (Optional)
- Explain WHAT and WHY, not HOW
- Wrap at 72 characters
- Separate from description with blank line

### Footer (Optional)
- Reference issues: `Closes #123`, `Fixes #456`
- Breaking changes: `BREAKING CHANGE: description`
- Co-authored commits: `Co-authored-by: Name <email>`

## ✅ Good Examples

```bash
feat: add user authentication system

Implement OAuth2 integration with Google and GitHub providers.
This allows users to log in using their existing accounts instead
of creating new credentials.

Closes #142
```

```bash
fix(api): handle null response in user service

The getUserProfile method was not handling cases where the API
returns null. Added proper error handling and default values.

Fixes #298
```

```bash
docs: add contributing guidelines

- Add code style requirements  
- Include pull request template
- Document testing procedures

Co-authored-by: Jane Smith <jane@example.com>
```

## ❌ Poor Examples

```bash
# Too vague
fix: bug fix

# Wrong tense  
feat: added new feature

# Too long description
feat: implement a new user authentication system with OAuth2 integration that supports multiple providers

# No type
update documentation

# Capitalized description
feat: Add new API endpoint
```

## 🛠️ Tooling Setup

### Commitizen (Interactive Commit Helper)

Install globally:
```bash
npm install -g commitizen cz-conventional-changelog
```

Configure in package.json:
```json
{
  "scripts": {
    "commit": "cz"
  },
  "config": {
    "commitizen": {
      "path": "cz-conventional-changelog"
    }
  }
}
```

Usage:
```bash
git add .
npm run commit  # Interactive prompt for conventional commits
```

### CommitLint (Commit Message Validation)

Install:
```bash
npm install --save-dev @commitlint/cli @commitlint/config-conventional
```

Create `.commitlintrc.js`:
```javascript
module.exports = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [2, 'always', [
      'feat', 'fix', 'docs', 'style', 'refactor', 
      'perf', 'test', 'chore', 'build', 'ci', 'revert'
    ]],
    'subject-case': [2, 'never', ['start-case', 'pascal-case', 'upper-case']],
    'subject-empty': [2, 'never'],
    'subject-full-stop': [2, 'never', '.'],
    'header-max-length': [2, 'always', 72]
  }
};
```

### Husky (Git Hooks)

Install:
```bash
npm install --save-dev husky
npx husky install
```

Add commit-msg hook:
```bash
npx husky add .husky/commit-msg 'npx --no -- commitlint --edit ${1}'
```

## 🔄 Integration with Existing PII Check

The conventional commits setup works alongside the existing PII check:

1. **Pre-commit**: PII and sensitive data validation
2. **Commit-msg**: Conventional commits format validation

Both hooks will run automatically on commits.

## 📊 Benefits

### For Development
- **Consistency**: Standardized commit messages across team
- **Readability**: Clear understanding of change types
- **Navigation**: Easy browsing of project history

### for Automation  
- **Changelog Generation**: Automatic release notes
- **Semantic Versioning**: Automated version bumps
- **CI/CD Integration**: Trigger different workflows based on commit type

### for Project Management
- **Issue Tracking**: Automatic issue linking and closing
- **Release Planning**: Clear feature and fix categorization  
- **Code Review**: Better understanding of change intent

## 🚀 Quick Start

1. **Install tools** (optional but recommended):
   ```bash
   npm install -g commitizen cz-conventional-changelog
   npm install --save-dev @commitlint/cli @commitlint/config-conventional husky
   ```

2. **Use the format** for all commits:
   ```bash
   git commit -m "feat: add user login functionality"
   git commit -m "fix(auth): resolve token refresh issue"
   git commit -m "docs: update README with setup instructions"
   ```

3. **Follow the guidelines** for descriptions and optional body/footer

## 📚 Resources

- [Conventional Commits Specification](https://www.conventionalcommits.org/)
- [Commitizen GitHub](https://github.com/commitizen/cz-cli)
- [CommitLint Documentation](https://commitlint.js.org/)
- [Semantic Versioning](https://semver.org/)

---

*Following conventional commits improves code maintainability, enables automation, and enhances team collaboration.*