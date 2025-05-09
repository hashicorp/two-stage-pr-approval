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

## Implementation Steps

1. **Use the workflow:**
   - If you already have a ci configured for checking PR, feel free to add it over there OR you can take a reference from [two-stage-pr-approval](./.github/workflows/two-stage-pr-approval.yml) for creating a workflow file.
   - To use the workflow, add in the following snippet in list of steps with the required inputs
   ```yaml
      - name: two-stage-pr-review
        uses: hashicorp/two-stage-pr-approval@main
        with:
         token: ${{ secrets.PAT_TOKEN }}
         team-members: "team-member-1 team-member-2 team-member-3"
   ```
   - Make sure you only run it on pull_request and pull_request_review.

2. **Set up repository permissions:**
   - Ensure the GitHub Actions have appropriate permissions to modify PRs and add labels
   - You can adjust permissions in repository settings

3. **Create the required label:**
   - Create an `internal-approval` label in your repository

## Additional Configuration Options

You might want to consider these additional enhancements:

1. **Branch protection rules:**
   - Require the `internal-approval` label before merging
   - This ensures no PR can be merged without going through your internal review process

2. **Add approval requirements:**
   - You could modify the workflow to require multiple approvals from your team before applying the internal-approval label
