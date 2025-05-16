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
   - Please note that the workflow requires this label to be created manually in your repository.

## Implementation Steps

1. **Use the workflow:**
   - If you already have a ci configured for checking PR, feel free to add it over there OR you can take a reference from [example workflow](#examples) for creating a workflow file.
   - To use the workflow, add in the following snippet in list of steps with the required inputs
   ```yaml
      - name: two-stage-pr-review
        uses: hashicorp/two-stage-pr-approval@main
        with:
         token: ${{ github.token }} # Default: ${{ github.token }}
         team-members: "<list of space-separated team members>" # Default: "ritikrajdev mukeshjc sonamtenzin2 abhijeetviswa mohanmanikanta2299"
         internal-approval-label: "<name of the label>" # Default: "internal-approval"
   ```
   - Make sure you **only run it on pull_request and pull_request_review**.
   - Make sure your app has the **required write permissions for pull_request and contents**.
   - Please note that each of the inputs is optional and has a default value. You can override them as per your requirement.

2. **Set up repository permissions:**
   - Ensure the GitHub Actions have appropriate permissions to modify PRs and add labels i.e. `pull-requests: write` and `contents: write`
   - You can adjust permissions in repository settings

3. **Create the `internal-approval` label:**
   - Create a label named `internal-approval` or any suitable label in your repository
   - This label is used to track the internal approval status of PRs
   - You can create this label manually in the GitHub UI or use the GitHub API

## Additional Configuration Options

You might want to consider these additional enhancements:

1. **Branch protection rules:**
   - Require the `internal-approval` label before merging
   - This ensures no PR can be merged without going through your internal review process

2. **Add approval requirements:**
   - You could modify the workflow to require multiple approvals from your team before applying the internal-approval label


## Examples

1. **Example usable workflow:**
```yaml
name: Two-Stage PR Review Process

on:
  pull_request:
    types: [opened, synchronize, reopened, labeled, unlabeled, ready_for_review, converted_to_draft]
  pull_request_review:
    types: [submitted]

jobs:
  manage-pr-status:
    runs-on: ubuntu-latest
    permissions:
      pull-requests: write
      contents: write
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
      
      - name: Two stage PR review
        uses: hashicorp/two-stage-pr-approval@main
```
