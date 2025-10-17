# AI Research & Development Experience


This repository contains research, documentation, and re-usabe processes for integrating AI-powered development tools into everyday workflows. My focus is on practical, actionable guidance that developers can immediately apply to improve their productivity.
I often use card games for experimenting with new technology as I like them :)

This project uses [Conventional Commits](docs/conventional-commits.md)

**Read the [AI Development Guide](docs/ai-development-guide.md)** for comprehensive setup and best practices

### 🔬 Research

- **[Guide to using GitHub Copilot to write unit tests](research/copilot-unit-tests.md)** ✅  
  _Comprehensive guide covering test generation, troubleshooting, and best practices for AI-assisted testing_
- **[Game Playing AI with PPO Reinforcement Learning](research/ppo-reinforement-learning.md)** 🚧 _TODO_  
  _Research and guidance for implementing AI agents for game environments using Proximal Policy Optimization_
- **[Agentic AI Research](research/agentic-ai-research.md)** 🚧 _TODO_  
  _Investigation into autonomous AI agents for development workflows_
- **[Model Context Protocol (MCP) Integration Research](research/mcp-integration-research.md)** 🚧 _TODO_  
  _Advanced AI tool integration using MCP for enhanced development workflows and coordination_
- **[AI-Powered Pull Request Review Research](research/pr-review-research.md)** 🚧 _TODO_  
  _Investigation into automated code review workflows using GitHub Copilot and AI_

### 💡 Future Research Ideas

#### 🎫 AI-Enhanced Jira Workflows
- **Automated Story Point Estimation** - AI analysis of ticket complexity and historical data
- **Smart Sprint Planning** - AI-driven capacity planning and backlog prioritization  
- **Intelligent Ticket Categorization** - Auto-tagging and assignment based on content analysis
- **Predictive Delivery Estimates** - ML models for more accurate timeline predictions
- **Automated Acceptance Criteria Generation** - AI-assisted test case and criteria creation

#### 🐙 GitHub AI Integration
- **Intelligent Issue Triage** - Auto-labeling, assignment, and priority scoring of new issues
- **AI-Powered Code Migration** - Automated refactoring and dependency upgrade suggestions
- **Smart Branch Protection** - Dynamic rules based on code change impact analysis
- **Automated Documentation Generation** - AI-generated README updates from code changes
- **Intelligent Merge Conflict Resolution** - AI-assisted conflict resolution with context awareness

#### 🔗 Cross-Platform AI Workflows  
- **Jira-GitHub Sync Intelligence** - Smart linking of commits, PRs, and tickets with context
- **Automated Release Notes** - AI-generated changelogs from Jira tickets and GitHub commits
- **Development Velocity Analytics** - Cross-platform insights and bottleneck identification
- **Smart Notification Management** - AI-filtered alerts to reduce noise and improve focus

### 🔄 Re-usable Development Processes (spec-driven development)

- **[Angular Library Upgrade Process](processes/angular-upgrade-process.md)**  
  _Step-by-step automated process for upgrading Angular libraries with AI assistance_
- **[Git Pre-Commit PII Check Process](processes/commit-pii-check.md)**  
  _Automated prevention of PII and sensitive data commits across repositories_

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

## 🤝 Contributing

Found an improvement or have a new AI process to share? Contributions are welcome!

1. Fork the repository
2. Create a feature branch for your changes
3. Add or update documentation with clear examples
4. Submit a pull request with a detailed description

---

_For detailed setup instructions, best practices, and available scripts, see the [AI Development Guide](docs/ai-development-guide.md)_
