# two-stage-pr-approval
Reusable Github Actions Workflow that implements a two-stage review process using labels to control PR visibility and review status.

## How This Workflow Works

This workflow implements a two-stage review process that:

1. **Automatically manages PR visibility based on internal approval status:**
   - New PRs are automatically converted to draft status until approved by your team
   - PRs remain in draft mode until they receive internal approval
   - Once approved, they are automatically marked as ready for review

2. **Uses labels to track approval status:**
   - The `internal-approval` label indicates a PR has passed internal review
   - The workflow adds/removes this label based on approval status

3. **Notifies stakeholders when a PR is ready for external review:**
   - When a PR transitions to "ready for review" status, it identifies affected teams
   - It automatically mentions relevant teams based on which files were changed

## Implementation Steps

1. **Save the workflow file:**
   - Create a `.github/workflows/two-stage-pr-approval.yml` file in your repository
   - Copy the provided workflow code into this file

2. **Configure team members:**
   - In the workflow file, replace `['team-member-1', 'team-member-2', 'team-member-3']` with the GitHub usernames of your team members who are authorized to grant internal approval

3. **Configure directory-to-team mapping:**
   - Update the `dirToTeamMapping` object to reflect your repository's structure and the teams responsible for different components

4. **Set up repository permissions:**
   - Ensure the GitHub Actions have appropriate permissions to modify PRs and add labels
   - You can adjust permissions in repository settings

5. **Create the required label:**
   - Create an `internal-approval` label in your repository

## Additional Configuration Options

You might want to consider these additional enhancements:

1. **Branch protection rules:**
   - Require the `internal-approval` label before merging
   - This ensures no PR can be merged without going through your internal review process

2. **Customize notification logic:**
   - The current implementation notifies teams based on directories, but you could enhance this to use more sophisticated routing rules

3. **Add approval requirements:**
   - You could modify the workflow to require multiple approvals from your team before applying the internal-approval label
