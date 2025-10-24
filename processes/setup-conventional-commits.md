# Setup Conventional Commits Hook

## Instructions for Copilot

1. Create a new file at:
   ```
   scripts/commit-msg-hook.sh
   ```

2. Add the following content to that file:

   ```sh
   #!/bin/sh
   #
   # commit-msg-hook.sh
   # Enforces Conventional Commits message format
   #
   # Allowed types:
   # feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert
   #
   # Format:
   #   <type>(optional scope)!?: <subject>
   #
   # Subject must not be empty and must be <= 72 characters.
   # Allow "Merge" commits and version bumps such as "chore(release): 1.2.3".
   # Script must be POSIX sh compatible.

   commit_msg_file=$1
   commit_msg=$(head -n1 "$commit_msg_file")

   # Allow merge commits and release bumps
   case "$commit_msg" in
     Merge*|chore\(release\)*)
       exit 0
       ;;
   esac

   # Conventional Commits regex
   pattern='^(feat|fix|docs|style|refactor|perf|test|build|ci|chore|revert)(\([a-z0-9._-]+\))?(!)?: .{1,72}$'

   if echo "$commit_msg" | grep -Eq "$pattern"; then
     exit 0
   else
     echo "❌ Invalid commit message!"
     echo ""
     echo "Your commit message must follow the Conventional Commits format:"
     echo "  <type>(optional scope)!?: <subject>"
     echo ""
     echo "Examples:"
     echo "  feat: add shader lighting controls"
     echo "  fix(renderer): correct matrix transform bug"
     echo "  docs: update README with setup steps"
     echo "  chore(release): 1.2.3"
     echo ""
     echo "Allowed types: feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert"
     exit 1
   fi
   ```

3. Make the script executable and install it as a Git hook.

   For **Unix / macOS / WSL**, run:
   ```bash
   chmod +x scripts/commit-msg-hook.sh
   mkdir -p .git/hooks
   cp scripts/commit-msg-hook.sh .git/hooks/commit-msg
   chmod +x .git/hooks/commit-msg
   ```

   For **Windows (PowerShell)**, run:
   ```powershell
   New-Item -ItemType Directory -Force .git/hooks | Out-Null
   Copy-Item scripts/commit-msg-hook.sh .git/hooks/commit-msg
   # If using Git Bash on Windows, ensure LF line endings and executable permission
   ```

4. Verify the hook works:

   Invalid example (should fail):
   ```bash
   git commit -m "update shader"
   ```

   Valid example (should pass):
   ```bash
   git commit -m "feat: add fragment shader blending"
   ```

   Breaking change example (should pass):
   ```bash
   git commit -m "refactor!: migrate to new rendering engine"
   ```

## Done

This setup enforces Conventional Commits locally for all contributors using a simple POSIX shell hook.
