# AI Development Guide

> Comprehensive guide for working with AI tools in development workflows

## 🚀 AI-Powered Workflow Integration

### Getting Started with AI Processes

1. **Setup Your Environment**
   - Install GitHub Copilot in VS Code
   - Open your project workspace
   - Have the relevant process documentation accessible

2. **Execute AI-Guided Processes**
   - Open the process document in your workspace
   - Use Copilot Chat to guide you through each step
   - Leverage AI for troubleshooting and optimization

### Essential VS Code Shortcuts
- **Open Copilot Chat**: `Cmd + Shift + I` (macOS) / `Ctrl + Shift + I` (Windows/Linux)
- **Inline Copilot**: `Tab` to accept suggestions
- **Alternative Suggestions**: `Alt + ]` / `Alt + [`

## 🛠️ Best Practices

### Working with AI Processes
- **Context is Key**: Keep relevant files open in your workspace
- **Be Specific**: Provide clear, detailed prompts to get better results
- **Iterative Improvement**: Refine and enhance AI-generated content
- **Validate Results**: Always review and test AI-generated code

### Process Execution Tips
- Follow processes step-by-step rather than jumping ahead
- Use AI chat to ask questions when steps are unclear
- Document any improvements or issues encountered
- Share learnings with the team

### Commit Standards
This project follows [Conventional Commits](https://www.conventionalcommits.org/):
- **feat**: New features
- **fix**: Bug fixes  
- **docs**: Documentation changes
- **chore**: Maintenance tasks
- **refactor**: Code improvements without feature changes

Examples: `feat(auth): add OAuth integration`, `fix: resolve memory leak`, `docs: update README`

## 🛠️ Available Scripts

### Security Scripts
- **`scripts/setup-pii-check.sh`** - Install PII detection pre-commit hook in any repository
- **`scripts/pre-commit-pii-check.sh`** - Core PII detection script for git hooks

### Development Scripts
- **`scripts/setup-conventional-commits.sh`** - Configure conventional commits with optional tooling

### Usage Examples
```bash
# Setup PII check in current repository
./scripts/setup-pii-check.sh

# Setup conventional commits
./scripts/setup-conventional-commits.sh

# Interactive conventional commit
npm run commit

# Standard conventional commit  
git commit -m "feat(docs): add conventional commits guide"

# Test PII detection
echo "SSNC-internal" > test.txt
git add test.txt
git commit -m "test"  # Will be blocked by PII check
```

## 📖 Additional Resources

- [GitHub Copilot Documentation](https://docs.github.com/en/copilot)
- [VS Code AI Extensions](https://marketplace.visualstudio.com/search?term=ai&target=VSCode)
- [Best Practices for AI-Assisted Development](https://github.blog/2023-06-20-how-to-write-better-prompts-for-github-copilot/)

---

*Last Updated: October 17, 2025*  
*Maintained by: David Benoy*