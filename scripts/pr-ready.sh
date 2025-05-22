#!/bin/bash

# This script is used to prepare a pull request for the repository.
# It marks the pull request as ready for review and adds a comment indicating that it has been approved internally.
# Usage: pr-ready.sh <PR_NUMBER>
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <PR_NUMBER>"
    exit 1
fi

PR_NUMBER=$1

gh pr ready $PR_NUMBER
gh pr comment $PR_NUMBER --body "This PR has been marked as ready for review following internal approval."
