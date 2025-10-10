#!/bin/bash

# Setup Conventional Commits for Git Repository
# This script configures commit message template and optional tooling

echo "🔧 Setting up Conventional Commits configuration..."

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo "${RED}❌ Error: Not in a git repository root directory${NC}"
    echo "Please run this script from the root of your git repository"
    exit 1
fi

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(git rev-parse --show-toplevel)"

echo "📋 Setting up commit message template..."

# Set up git commit template
if [ -f "$REPO_ROOT/.gitmessage" ]; then
    git config commit.template .gitmessage
    echo "${GREEN}✅ Commit template configured${NC}"
else
    echo "${YELLOW}⚠️  .gitmessage file not found in repository root${NC}"
    echo "Creating basic template..."
    
    cat > .gitmessage << 'EOF'
# <type>[optional scope]: <description>
#
# [optional body]
#
# [optional footer(s)]

# --- COMMIT END ---
# Type: feat, fix, docs, style, refactor, perf, test, chore, build, ci, revert
# Scope: api, auth, ui, docs, tests, config, deps, scripts (optional)
# 
# Examples:
#   feat(auth): add OAuth2 integration
#   fix: resolve memory leak in data processing  
#   docs: update API documentation
EOF
    
    git config commit.template .gitmessage
    echo "${GREEN}✅ Basic commit template created and configured${NC}"
fi

# Check if package.json exists for Node.js tooling
if [ -f "package.json" ]; then
    echo ""
    echo "${BLUE}📦 Node.js project detected. Setting up enhanced tooling...${NC}"
    
    # Ask user if they want to install commitizen and commitlint
    read -p "Install Commitizen (interactive commit helper)? [y/N]: " install_commitizen
    read -p "Install CommitLint (commit message validation)? [y/N]: " install_commitlint
    read -p "Install Husky (git hooks manager)? [y/N]: " install_husky
    
    if [[ $install_commitizen =~ ^[Yy]$ ]]; then
        echo "📦 Installing Commitizen..."
        npm install --save-dev commitizen cz-conventional-changelog
        
        # Add to package.json scripts
        npm pkg set scripts.commit="cz"
        npm pkg set config.commitizen.path="cz-conventional-changelog"
        
        echo "${GREEN}✅ Commitizen installed. Use 'npm run commit' for interactive commits${NC}"
    fi
    
    if [[ $install_commitlint =~ ^[Yy]$ ]]; then
        echo "📦 Installing CommitLint..."
        npm install --save-dev @commitlint/cli @commitlint/config-conventional
        
        # Create commitlint config
        cat > .commitlintrc.js << 'EOF'
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
    'header-max-length': [2, 'always', 72],
    'scope-enum': [1, 'always', [
      'api', 'auth', 'ui', 'docs', 'tests', 'config', 
      'deps', 'scripts', 'core', 'utils'
    ]]
  }
};
EOF
        
        echo "${GREEN}✅ CommitLint installed and configured${NC}"
        
        # Install husky if user wants commitlint
        if [[ $install_husky =~ ^[Yy]$ ]] || [[ -z $install_husky ]]; then
            install_husky="y"
        fi
    fi
    
    if [[ $install_husky =~ ^[Yy]$ ]]; then
        echo "📦 Installing and configuring Husky..."
        npm install --save-dev husky
        
        # Initialize husky
        npx husky install
        
        # Add husky install to package.json prepare script
        npm pkg set scripts.prepare="husky install"
        
        # Add commit-msg hook if commitlint is installed
        if [[ $install_commitlint =~ ^[Yy]$ ]]; then
            npx husky add .husky/commit-msg 'npx --no -- commitlint --edit ${1}'
            echo "${GREEN}✅ Husky configured with commit-msg hook${NC}"
        else
            echo "${GREEN}✅ Husky installed. Add hooks manually as needed${NC}"
        fi
    fi
    
else
    echo "${YELLOW}📝 No package.json found. Skipping Node.js tooling setup${NC}"
    echo "   Manual tooling installation available in documentation"
fi

# Create or update git hooks directory for integration with existing PII check
echo ""
echo "🔗 Checking integration with existing git hooks..."

if [ -f ".git/hooks/commit-msg" ]; then
    echo "${YELLOW}⚠️  Existing commit-msg hook found${NC}"
    echo "   You may need to manually integrate conventional commits validation"
elif [ -f ".git/hooks/pre-commit" ]; then
    echo "${GREEN}✅ Pre-commit hook detected (likely PII check)${NC}"
    echo "   Conventional commits template is ready to work alongside existing hooks"
fi

# Summary
echo ""
echo "${GREEN}✅ Conventional Commits setup complete!${NC}"
echo ""
echo "📋 What's configured:"
echo "   • Git commit message template (.gitmessage)"
echo "   • Conventional commits documentation"

if [[ $install_commitizen =~ ^[Yy]$ ]]; then
    echo "   • Commitizen for interactive commits (npm run commit)"
fi

if [[ $install_commitlint =~ ^[Yy]$ ]]; then
    echo "   • CommitLint for message validation"
fi

if [[ $install_husky =~ ^[Yy]$ ]]; then
    echo "   • Husky git hooks management"
fi

echo ""
echo "🚀 Usage:"
echo "   ${BLUE}git commit${NC}                    # Opens template in editor"

if [[ $install_commitizen =~ ^[Yy]$ ]]; then
    echo "   ${BLUE}npm run commit${NC}               # Interactive commit helper"
fi

echo "   ${BLUE}git commit -m 'feat: add feature'${NC} # Direct conventional commit"
echo ""
echo "📚 Examples:"
echo "   feat(auth): add OAuth2 integration"
echo "   fix: resolve memory leak in processing"
echo "   docs: update README with setup guide"
echo "   chore(deps): update dependencies"
echo ""
echo "${YELLOW}📖 See conventional-commits.md for full documentation${NC}"