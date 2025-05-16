#!/bin/bash

# This script retrieves the details of a pull request from the GitHub repository.
# Usage: ./pr-details.sh <PR_NUMBER> <TEAM_MEMBERS>

# Check if the required arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <PR_NUMBER> <TEAM_MEMBERS>"
    exit 1
fi

PR_NUMBER=$1
TEAM_MEMBERS=$2

# Get PR creator
PR_CREATOR=$(gh pr view $PR_NUMBER --json author --jq .author.login)
echo "PR_CREATOR=$PR_CREATOR"


# Check Team Membership
if [[ $TEAM_MEMBERS == *"$PR_CREATOR"* ]]; then
    echo "IS_TEAM_MEMBER=true"
else
    echo "IS_TEAM_MEMBER=false"
fi


# Check if PR has internal-approval label
LABELS=$(gh pr view $PR_NUMBER --json labels --jq '.labels[].name')
if [[ $LABELS == *"internal-approval"* ]]; then
    echo "HAS_APPROVAL_LABEL=true"
else
    echo "HAS_APPROVAL_LABEL=false"
fi


# Check if PR is in draft state
IS_DRAFT=$(gh pr view $PR_NUMBER --json isDraft --jq .isDraft)
echo "IS_DRAFT=$IS_DRAFT"


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
