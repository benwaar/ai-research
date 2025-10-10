#!/bin/bash

# Setup PII Check for Git Repository
# This script installs the pre-commit hook to prevent PII commits

echo "🔧 Setting up PII check for repository..."

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo "${RED}❌ Error: Not in a git repository root directory${NC}"
    echo "Please run this script from the root of your git repository"
    exit 1
fi

# Create hooks directory if it doesn't exist
mkdir -p .git/hooks

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check if pre-commit-pii-check.sh exists
if [ -f "$SCRIPT_DIR/pre-commit-pii-check.sh" ]; then
    echo "📋 Copying pre-commit hook from local script..."
    cp "$SCRIPT_DIR/pre-commit-pii-check.sh" .git/hooks/pre-commit
else
    echo "📥 Downloading pre-commit hook..."
    # If the local script doesn't exist, you could download from a central location
    # For now, we'll create it inline
    cat > .git/hooks/pre-commit << 'EOF'
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
    "(?<!example\.)[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}"  # Email addresses (exclude example.com)
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
)

# Define safe patterns to exclude
declare -a safe_patterns=(
    "example\.com"
    "test@example\.com"
    "user@example\.com"
    "localhost"
    "127\.0\.0\.1"
    "JIRA-[0-9]+"
    "TICKET-[0-9]+"
    "PROJECT"
    "DAVIDSPROJ"
    # Documentation examples
    "Replace.*SSNC"
    "SSNC.*→"
    "e\.g\..*SSNC"
    "DPP-XXXX"
    "Pattern:.*SSNC"
    "# Company.*SSNC"
    "\"SSNC\""
    "jdbc:\[.*\]"
    "mongodb://\[.*\]"
    "redis://\[.*\]"
    "echo.*SSNC"
    "\.md:.*SSNC"
    "\.sh:.*SSNC"
)

# Define file extensions to check
declare -a extensions=(
    "*.md" "*.txt" "*.json" "*.js" "*.ts" "*.py" "*.java"
    "*.cs" "*.php" "*.rb" "*.go" "*.cpp" "*.c" "*.h"
    "*.yml" "*.yaml" "*.xml" "*.html" "*.css" "*.scss"
    "*.sql" "*.sh" "*.bash" "*.ps1" "*.env" "*.config"
)

should_check_file() {
    local file="$1"
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

is_safe_pattern() {
    local content="$1"
    for safe in "${safe_patterns[@]}"; do
        if echo "$content" | grep -qE "$safe"; then
            return 0
        fi
    done
    return 1
}

echo "📁 Checking files: $files_to_check"
echo ""

for file in $files_to_check; do
    if [ ! -f "$file" ]; then
        continue
    fi
    
    if ! should_check_file "$file"; then
        continue
    fi
    
    echo "🔍 Checking: $file"
    
    for pattern in "${patterns[@]}"; do
        matches=$(grep -inE "$pattern" "$file" 2>/dev/null || true)
        
        if [ ! -z "$matches" ]; then
            filtered_matches=""
            while IFS= read -r match; do
                if ! is_safe_pattern "$match"; then
                    filtered_matches="$filtered_matches$match\n"
                fi
            done <<< "$matches"
            
            if [ ! -z "$filtered_matches" ] && [ "$filtered_matches" != "\n" ]; then
                echo "${RED}❌ POTENTIAL PII/SENSITIVE DATA FOUND in $file:${NC}"
                echo "${RED}   Pattern: $pattern${NC}"
                echo "${YELLOW}   Matches:${NC}"
                echo -e "$filtered_matches" | sed 's/^/     /'
                echo ""
                issues_found=true
            fi
        fi
    done
done

echo "----------------------------------------"
if [ "$issues_found" = true ]; then
    echo "${RED}❌ COMMIT BLOCKED: Potential PII or sensitive data found!${NC}"
    echo ""
    echo "${YELLOW}🔧 How to fix:${NC}"
    echo "   • Replace SSNC → PROJECT or DAVIDSPROJ"
    echo "   • Replace DPP-XXXX → JIRA-001"
    echo "   • Use user@example.com for email examples"
    echo "   • Remove actual API keys/passwords"
    echo ""
    echo "${YELLOW}💡 Emergency bypass:${NC} git commit --no-verify"
    exit 1
else
    echo "${GREEN}✅ No PII or sensitive data detected${NC}"
    exit 0
fi
EOF
fi

# Make the hook executable
chmod +x .git/hooks/pre-commit

# Create a sample configuration file
cat > .pii-check-config << 'EOF'
# PII Check Configuration
# Customize patterns for this repository

# Company-specific patterns to detect
SSNC
DPP-[0-9]+
INTERNAL-[0-9]+

# Safe patterns to allow
PROJECT
DAVIDSPROJ
JIRA-[0-9]+
TICKET-[0-9]+
user@example.com
test@example.com

# Add more patterns as needed
EOF

echo "${GREEN}✅ PII check setup complete!${NC}"
echo ""
echo "📝 Configuration:"
echo "   • Pre-commit hook installed at .git/hooks/pre-commit"
echo "   • Configuration file created: .pii-check-config"
echo "   • Edit .pii-check-config to customize patterns"
echo ""
echo "🧪 Test the setup:"
echo "   echo 'SSNC-test' > test.txt"
echo "   git add test.txt"
echo "   git commit -m 'test'  # Should be blocked"
echo ""
echo "${YELLOW}⚠️  Remember to customize the patterns in the hook for your organization!${NC}"