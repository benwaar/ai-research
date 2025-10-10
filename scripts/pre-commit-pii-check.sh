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
    "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}"  # Email addresses (exclude example.com)
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

# Define safe patterns to exclude (whitelist)
declare -a safe_patterns=(
    "example\.com"
    "test@example\.com"
    "user@example\.com"
    "admin@example\.com"
    "localhost"
    "127\.0\.0\.1"
    "0\.0\.0\.0"
    "JIRA-[0-9]+"
    "TICKET-[0-9]+"
    "PROJECT-[0-9]+"
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

# Function to check if content matches safe patterns
is_safe_pattern() {
    local content="$1"
    for safe in "${safe_patterns[@]}"; do
        if echo "$content" | grep -qE "$safe"; then
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
            # Filter out safe patterns
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

# Summary
echo "----------------------------------------"
if [ "$issues_found" = true ]; then
    echo "${RED}❌ COMMIT BLOCKED: Potential PII or sensitive data found!${NC}"
    echo ""
    echo "${YELLOW}🔧 How to fix:${NC}"
    echo "1. Review the flagged content above"
    echo "2. Remove or anonymize any sensitive information"
    echo "3. Replace company-specific identifiers with generic placeholders:"
    echo "   • SSNC → COMPANY or PROJECT"
    echo "   • DPP-1234 → JIRA-001 or TICKET-001"
    echo "4. Use environment variables for sensitive configuration"
    echo "5. Replace real emails with user@example.com"
    echo ""
    echo "${YELLOW}💡 To bypass this check (emergency only):${NC}"
    echo "   git commit --no-verify -m \"your message\""
    echo ""
    exit 1
else
    echo "${GREEN}✅ No PII or sensitive data detected${NC}"
    echo "${GREEN}✅ Commit approved${NC}"
    exit 0
fi