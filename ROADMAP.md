# Roadmap

Planned work, roughly in order. Each item is tracked as a GitHub issue.

- [ ] **Move the container to Node.js 24.** Node.js 20 reached end of life in April 2026.
- [ ] **Drop the CapRover CLI pin** once upstream fixes the duplicate `-t` flag in 2.4.0+, and add a check that warns when a newer CLI works.
- [ ] **CI for the action itself:** ShellCheck on `run.sh`, a Docker build, and a smoke test that runs the action against a throwaway CapRover instance on every pull request.
- [ ] **Clear errors when neither `image` nor `branch` is set**, and when the server URL is missing `https://`.
- [ ] **Tar file deploys** (`tarFile` input) for repos that don't build a Docker image.
- [ ] **Action outputs** (deployed image and app URL) so later steps can post them to a pull request or Slack.
- [ ] **Publish to the GitHub Marketplace** with a short getting-started guide and a full example workflow.
