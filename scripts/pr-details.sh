#!/bin/bash

# This script retrieves the details of a pull request from the GitHub repository.
# Usage: ./pr-details.sh <PR_NUMBER> <TEAM_MEMBERS>

# Check if the required arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <PR_NUMBER> <TEAM_MEMBERS> <DEBUG>"
    exit 1
fi

PR_NUMBER=$1
TEAM_MEMBERS=$2
DEBUG=false
if [ "$3" == "true" ]; then
    DEBUG=true
fi

echoerr() {
    # Only used for debugging
    if $DEBUG; then
        echo "$@" 1>&2
    fi
}

if $DEBUG; then
    echoerr "Debugging enabled"
    pwd 1>&2
fi
    

# Get PR creator
PR_CREATOR=$(gh pr view $PR_NUMBER --json author --jq .author.login)
echo "PR_CREATOR=$PR_CREATOR"
echoerr "PR_CREATOR=$PR_CREATOR"


# Check Team Membership
if [[ $TEAM_MEMBERS == *"$PR_CREATOR"* ]]; then
    echo "IS_TEAM_MEMBER=true"
else
    echo "IS_TEAM_MEMBER=false"
fi
echoerr "IS_TEAM_MEMBER=$IS_TEAM_MEMBER"


# Check if PR has internal-approval label
LABELS=$(gh pr view $PR_NUMBER --json labels --jq '.labels[].name')
if [[ $LABELS == *"internal-approval"* ]]; then
    echo "HAS_APPROVAL_LABEL=true"
else
    echo "HAS_APPROVAL_LABEL=false"
fi
echoerr "HAS_APPROVAL_LABEL=$HAS_APPROVAL_LABEL"


# Check if PR is in draft state
IS_DRAFT=$(gh pr view $PR_NUMBER --json isDraft --jq .isDraft)
echo "IS_DRAFT=$IS_DRAFT"
echoerr "IS_DRAFT=$IS_DRAFT"


# Check for team member approvals (excluding self-approval)
REVIEWS=$(gh pr view $PR_NUMBER --json reviews --jq '.reviews[] | select(.state=="APPROVED") | .author.login')
HAS_TEAM_APPROVAL="false"
for REVIEWER in $REVIEWS; do
if [[ $TEAM_MEMBERS == *"$REVIEWER"* && "$REVIEWER" != "$PR_CREATOR" ]]; then
    HAS_TEAM_APPROVAL="true"
    break
fi
done
echo "HAS_TEAM_APPROVAL=$HAS_TEAM_APPROVAL"
echoerr "HAS_TEAM_APPROVAL=$HAS_TEAM_APPROVAL"
