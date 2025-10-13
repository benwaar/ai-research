# Git Pre-Commit PII Check Process

## Overview

A systematic process to prevent committing Personally Identifiable Information (PII), sensitive data, and company-specific identifiers to git repositories.

## 🎯 What This Process Prevents

### Personal Identifiable Information (PII)
- Social Security Numbers (SSNs)
- Credit card numbers
- Email addresses (personal)
- Phone numbers
- Physical addresses

### Company-Specific Data
- Internal project codes (e.g., DPP-XXXX, SSNC references)
- Employee IDs
- Internal system names
- API keys and tokens
- Database connection strings
- Internal URLs and endpoints

### Sensitive Technical Data
- Passwords and secrets
- Private keys
- Internal configuration details
- Proprietary algorithms or business logic identifiers

## 🛠️ Implementation

### Step 1: Create Pre-Commit Hook Script

Create the following script at `.git/hooks/pre-commit`:

```bash
#!/bin/bash

# Git Pre-Commit PII and Sensitive Data Check
# Prevents committing potentially sensitive information

echo "🔍 Running PII and sensitive data check..."

# Color codes for output
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Flag to track if any issues are found
issues_found=false

# Get list of files to be committed
files_to_check=$(git diff --cached --name-only --diff-filter=ACM)

if [ -z "$files_to_check" ]; then
    echo "${GREEN}✅ No files to check${NC}"
    exit 0
fi

# Define patterns to search for (customize for your organization)
declare -a patterns=(
    # Company-specific patterns (customize these)
    "SSNC"
    "DPP-[0-9]+"
    "SSN[0-9]+"
    
    # Common PII patterns
    "[0-9]{3}-[0-9]{2}-[0-9]{4}"  # SSN format
    "[0-9]{4}[[:space:]]*[0-9]{4}[[:space:]]*[0-9]{4}[[:space:]]*[0-9]{4}"  # Credit card
    "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}"  # Email addresses
    "[0-9]{3}-[0-9]{3}-[0-9]{4}"  # Phone numbers
    
    # Sensitive technical data
    "password[[:space:]]*=[[:space:]]*['\"][^'\"]+['\"]"
    "api[_-]?key[[:space:]]*=[[:space:]]*['\"][^'\"]+['\"]"
    "secret[[:space:]]*=[[:space:]]*['\"][^'\"]+['\"]"
    "token[[:space:]]*=[[:space:]]*['\"][^'\"]+['\"]"
    "jdbc:[^[:space:]]+"
    "mongodb://[^[:space:]]+"
    "redis://[^[:space:]]+"
    
    # Private keys
    "-----BEGIN [A-Z ]+PRIVATE KEY-----"
    "-----BEGIN RSA PRIVATE KEY-----"
    "-----BEGIN OPENSSH PRIVATE KEY-----"
)

# Define file extensions to check (add more as needed)
declare -a extensions=(
    "*.md"
    "*.txt"
    "*.json"
    "*.js"
    "*.ts"
    "*.py"
    "*.java"
    "*.cs"
    "*.php"
    "*.rb"
    "*.go"
    "*.cpp"
    "*.c"
    "*.h"
    "*.yml"
    "*.yaml"
    "*.xml"
    "*.html"
    "*.css"
    "*.scss"
    "*.sql"
    "*.sh"
    "*.bash"
    "*.ps1"
    "*.env"
    "*.config"
    "*.ini"
    "*.properties"
)

# Function to check if file matches allowed extensions
should_check_file() {
    local file="$1"
    
    # Always check files without extensions
    if [[ "$file" != *.* ]]; then
        return 0
    fi
    
    for ext in "${extensions[@]}"; do
        if [[ "$file" == $ext ]]; then
            return 0
        fi
    done
    return 1
}

# Check each staged file
echo "📁 Checking files: $files_to_check"
echo ""

for file in $files_to_check; do
    # Skip if file doesn't exist (deleted files)
    if [ ! -f "$file" ]; then
        continue
    fi
    
    # Check if we should scan this file type
    if ! should_check_file "$file"; then
        echo "⏭️  Skipping $file (file type not checked)"
        continue
    fi
    
    echo "🔍 Checking: $file"
    
    # Check each pattern
    for pattern in "${patterns[@]}"; do
        # Use grep with case-insensitive and line number
        matches=$(grep -inE "$pattern" "$file" 2>/dev/null || true)
        
        if [ ! -z "$matches" ]; then
            echo "${RED}❌ POTENTIAL PII/SENSITIVE DATA FOUND in $file:${NC}"
            echo "${RED}   Pattern: $pattern${NC}"
            echo "${YELLOW}   Matches:${NC}"
            echo "$matches" | sed 's/^/     /'
            echo ""
            issues_found=true
        fi
    done
done

# Summary
echo "----------------------------------------"
if [ "$issues_found" = true ]; then
    echo "${RED}❌ COMMIT BLOCKED: Potential PII or sensitive data found!${NC}"
    echo ""
    echo "${YELLOW}🔧 How to fix:${NC}"
    echo "1. Review the flagged content above"
    echo "2. Remove or anonymize any sensitive information"
    echo "3. Replace company-specific identifiers with generic placeholders"
    echo "4. Use environment variables for sensitive configuration"
    echo "5. Add sensitive patterns to .gitignore if needed"
    echo ""
    echo "${YELLOW}💡 Common fixes:${NC}"
    echo "   • Replace 'SSNC' with 'COMPANY' or 'ORG'"
    echo "   • Replace 'DPP-1234' with 'TICKET-001'"
    echo "   • Use 'user@example.com' instead of real emails"
    echo "   • Remove actual API keys/passwords"
    echo ""
    exit 1
else
    echo "${GREEN}✅ No PII or sensitive data detected${NC}"
    echo "${GREEN}✅ Commit approved${NC}"
    exit 0
fi
```

### Step 2: Make the Hook Executable

```bash
chmod +x .git/hooks/pre-commit
```

### Step 3: Test the Hook

```bash
# Create a test file with sensitive data
echo "SSNC-internal-system" > test-sensitive.txt
git add test-sensitive.txt
git commit -m "test commit"  # This should be blocked

# Remove the test file
rm test-sensitive.txt
git reset HEAD test-sensitive.txt
```

## 🔧 Customization

### Adding Your Organization's Patterns

Edit the `patterns` array in the script:

```bash
declare -a patterns=(
    # Your company patterns
    "YOURCOMPANY"
    "PROJ-[0-9]+"
    "INTERNAL-[A-Z0-9]+"
    
    # Department codes
    "DEPT[0-9]+"
    "DIV-[A-Z]+"
    
    # Add more specific patterns here
)
```

### Configuring File Types

Modify the `extensions` array to include/exclude file types:

```bash
declare -a extensions=(
    "*.md"
    "*.txt"
    "*.json"
    # Add or remove extensions as needed
)
```

### Whitelist Specific Files

Add this function to skip certain files:

```bash
# Files to skip (add to the script after the patterns array)
declare -a whitelist_files=(
    "README.md"
    "CHANGELOG.md"
    "docs/examples.md"
)

is_whitelisted() {
    local file="$1"
    for whitelisted in "${whitelist_files[@]}"; do
        if [[ "$file" == "$whitelisted" ]]; then
            return 0
        fi
    done
    return 1
}
```

## 📋 Setup Process for New Repositories

### Automated Setup Script

Create `setup-pii-check.sh`:

```bash
#!/bin/bash

# Setup PII check for new repository
echo "🔧 Setting up PII check for repository..."

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo "❌ Not in a git repository root directory"
    exit 1
fi

# Create hooks directory if it doesn't exist
mkdir -p .git/hooks

# Download or copy the pre-commit script
curl -o .git/hooks/pre-commit https://raw.githubusercontent.com/your-org/security-tools/main/pre-commit-pii-check.sh

# Make it executable
chmod +x .git/hooks/pre-commit

# Create configuration file for custom patterns
cat > .pii-check-config << 'EOF'
# PII Check Configuration
# Add your organization-specific patterns here

# Company patterns (one per line)
YOURCOMPANY
PROJ-[0-9]+
INTERNAL-[A-Z0-9]+

# Additional sensitive patterns
# Add more patterns as needed
EOF

echo "✅ PII check setup complete!"
echo "📝 Edit .pii-check-config to customize patterns for this repository"
```

### Usage Instructions

1. **For each new repository:**
   ```bash
   cd /path/to/your-repo
   curl -sSL https://your-domain.com/setup-pii-check.sh | bash
   ```

2. **Customize patterns:**
   ```bash
   # Edit the configuration
   nano .pii-check-config
   ```

3. **Test the setup:**
   ```bash
   # Create test file with sensitive data
   echo "SENSITIVE-DATA-123" > test.txt
   git add test.txt
   git commit -m "test"  # Should be blocked
   ```

## 🚨 Bypass Instructions (Emergency Use Only)

If you need to bypass the check temporarily:

```bash
# Skip pre-commit hooks (use with extreme caution)
git commit --no-verify -m "emergency commit"
```

**⚠️ Warning:** Only use `--no-verify` in genuine emergencies and ensure manual review of the content.

## 📊 Monitoring and Reporting

### Generate PII Check Report

```bash
#!/bin/bash
# Generate report of potential PII in repository

echo "📊 PII Check Report for $(basename $(pwd))"
echo "Generated: $(date)"
echo "========================================"

find . -type f \( -name "*.md" -o -name "*.txt" -o -name "*.json" \) | while read file; do
    if grep -iqE "(SSNC|DPP-[0-9]+|[0-9]{3}-[0-9]{2}-[0-9]{4})" "$file" 2>/dev/null; then
        echo "⚠️  $file contains potential PII"
    fi
done
```

## 🔄 Maintenance

### Regular Updates

1. **Review patterns monthly** - Update based on new findings
2. **Test with sample data** - Ensure the hook catches new patterns
3. **Update across repositories** - Distribute updates to all repos
4. **Train team members** - Ensure everyone understands the process

### Version Control for the Hook

Store the hook script in a central repository:

```bash
# Create a security-tools repository
mkdir security-tools
cd security-tools
git init
cp /path/to/pre-commit pre-commit-pii-check.sh
git add .
git commit -m "Add PII check pre-commit hook"
```

## 📚 Additional Resources

- [Git Hooks Documentation](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks)
- [GDPR Compliance Guidelines](https://gdpr.eu/)
- [PII Detection Best Practices](https://owasp.org/www-project-data-security-top-10/)

---

*This process should be customized for your organization's specific requirements and compliance needs.*