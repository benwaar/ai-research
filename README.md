# 🧠 AI-Assisted Software Engineering Research

This repository explores how **AI** and **automation** can improve the **developer experience**, software quality, and delivery efficiency — with a focus on **secure, human-in-the-loop workflows**.

I develop **reusable processes**, **prompt frameworks**, and **automation pipelines** that integrate AI into everyday engineering tasks such as testing, dependency management, documentation, and workflow automation.

> _“Exploring how AI can enhance developer experience — from intelligent automation and testing to human-in-the-loop and agentic engineering systems.”_

---

## 🎓 Plan of Study

A structured path for applying AI to real-world engineering workflows.

### **Phase 1 – Practical AI for Developers**
- Master prompt design patterns for software tasks (structured, iterative, context-rich)
- Apply AI tools (Copilot, ChatGPT, etc.) for:
  - Test generation and debugging
  - Documentation and PR summaries
  - Process automation and code refactoring
- Build reusable **AI prompt templates** (“AI macros”) for daily development tasks

### **Phase 2 – Applied Engineering AI**
- Integrate AI into CI/CD and DevOps pipelines  
- Build **AI-assisted upgrade and migration tools** (e.g., Angular upgrade automation)  
- Research **AI-powered code review** and **dependency analysis**
- Develop AI-based quality and compliance checks

### **Phase 3 – Agentic & Orchestrated Systems**
- Experiment with **agentic AI** for autonomous workflow coordination  
- Explore **Model Context Protocol (MCP)** and cross-tool AI integrations  
- Research AI-enhanced developer analytics and security governance  

### **Phase 4 – Engineering Productivity & Security**
- Apply ML and analytics for delivery-time prediction and developer velocity  
- Strengthen software supply-chain security using automated PII detection and code scanning  
- Use AI insights to optimize development flow and reduce risk

---

## 🔬 Current Research

| Topic | Status | Summary |
|-------|--------|----------|
| **[Copilot for Unit Testing](research/copilot-unit-tests.md)** | ✅ | Practical guide for AI-assisted test generation and troubleshooting |
| **[AI-Powered Pull Request Reviews](research/pr-review-research.md)** | 🚧 | Automating code review feedback using LLMs |
| **[Model Context Protocol (MCP) Integration](research/mcp-integration-research.md)** | 🚧 | Advanced multi-tool AI orchestration |
| **[Agentic AI in Development Workflows](research/agentic-ai-research.md)** | 🚧 | Exploring autonomous agents for code and workflow management |
| **[Game-Playing AI with PPO](research/ppo-reinforcement-learning.md)** | 🧪 | Experimental reinforcement-learning agent for card-game environments |

---

## ♻️ Reusable Development Processes

| Process | Description |
|----------|--------------|
| **[Angular Library Upgrade Process](processes/angular-upgrade-process.md)** | **Human-in-the-loop, AI-assisted automation pipeline** for Angular version upgrades |
| **[Git Pre-Commit PII Check](processes/commit-pii-check.md)** | Automated prevention of sensitive-data commits across repositories |


---

## 🛠️ Scripts

### Security
- `scripts/setup-pii-check.sh` — installs PII-detection pre-commit hook  
- `scripts/pre-commit-pii-check.sh` — core PII scanning logic  

### Development
- `scripts/setup-conventional-commits.sh` — sets up Conventional Commits tooling  

**Examples:**
```bash
# Add security pre-commit checks
./scripts/setup-pii-check.sh

# Setup Conventional Commits
./scripts/setup-conventional-commits.sh

# Test PII detection
echo "SSNC-internal" > test.txt
git add test.txt
git commit -m "test"   # ❌ blocked by hook
