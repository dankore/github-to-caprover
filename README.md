# Deploy to CapRover Using GitHub Actions

A GitHub Action that deploys your app to a [CapRover](https://caprover.com/) server on every push. Point it at a Docker image (GitHub Container Registry, Docker Hub, Amazon ECR, Google Container Registry) or a branch, and it runs the CapRover CLI for you. It supports password login and CapRover app tokens, so it also works when two-factor authentication (OTP) is on.

**Who it's for:** developers who self-host apps on CapRover and want push-to-deploy from GitHub without writing the deploy script themselves. It is used in public repositories by other developers, and it deploys dozens of production sites run by Dankore Software.

**Built with:** a Docker container action (`action.yml`, `Dockerfile`, `run.sh`) on Node.js 20 with the CapRover CLI pinned to 2.3.1 (see [CapRover CLI pin](#caprover-cli-pin)). Releases are tagged (`v1.2.1` is the latest).

## Inputs

Detailed below are the required and optional inputs for the action:

### `server` (required)
- **Description:** URL of your CapRover server, such as `captain.your-domain.com`.
- **Example:** `${{ secrets.CAPROVER_URL }}`

### `password` (required unless `app_token` is set)
- **Description:** Your CapRover login password to authenticate deployment requests. Omit this when using `app_token` (for example on [CapRover Pro](https://caprover.com/) with two-factor authentication enabled).
- **Example:** `${{ secrets.CAPROVER_PASSWORD }}`

### `app_token` (optional)
- **Description:** App token from your app’s **Deployment** tab on CapRover. Use this when OTP/2FA is enabled and password-based `caprover deploy` no longer works. [CapRover documents](https://caprover.com/docs/) recommend app tokens for CI in that case.
- **Example:** `${{ secrets.CAPROVER_APP_TOKEN }}`

### `appName` (required)
- **Description:** The name of the application configured on CapRover to receive deployments.
- **Example:** `${{ secrets.CAPROVER_APP }}`

### `branch` (optional)
- **Description:** The GitHub repository branch from which to deploy. Defaults to the repository's main branch if not specified.
- **Example:** `main`

### `image` (optional)
- **Description:** The Docker image to be deployed. This can be an image hosted on Docker Hub or another registry.
- **Example:** `my-docker-image-name`

## Usage Examples

Below are examples of how to use the action in your workflows.

### CapRover Pro (OTP / 2FA)
When two-factor authentication is on, deploy with an app token instead of a password:

```yaml
- name: Deploy to CapRover Using GitHub Actions
  uses: dankore/github-to-caprover@v1.2.1
  with:
    server: '${{ secrets.CAPROVER_URL }}'
    app_token: '${{ secrets.CAPROVER_APP_TOKEN }}'
    appName: '${{ secrets.CAPROVER_APP }}'
    image: 'my-docker-image-name'
```

You can create the token in the app’s **Deployment** tab. The workflow is unchanged for everyone else: keep passing `password` and leave `app_token` unset.

### Basic Usage
Deploy an application using a Docker image specified in the workflow:

```yaml
- name: Deploy to CapRover Using GitHub Actions
  uses: dankore/github-to-caprover@v1.2.1
  with:
    server: '${{ secrets.CAPROVER_URL }}'
    password: '${{ secrets.CAPROVER_PASSWORD }}'
    appName: '${{ secrets.CAPROVER_APP }}'
    image: 'my-docker-image-name'
```

### Using GitHub Container Registry
For deploying an application using an image from the GitHub Container Registry:

```yaml
- name: Deploy to CapRover Using GitHub Actions
  uses: dankore/github-to-caprover@v1.2.1
  with:
    server: '${{ secrets.CAPROVER_URL }}'
    password: '${{ secrets.CAPROVER_PASSWORD }}'
    appName: '${{ secrets.CAPROVER_APP }}'
    image: 'ghcr.io/mygithub-username/my-docker-image-name:my-label'
```

### Using Docker Hub
Deploy using an image hosted on Docker Hub:

```yaml
- name: Deploy to CapRover Using GitHub Actions
  uses: dankore/github-to-caprover@v1.2.1
  with:
    server: '${{ secrets.CAPROVER_URL }}'
    password: '${{ secrets.CAPROVER_PASSWORD }}'
    appName: '${{ secrets.CAPROVER_APP }}'
    image: 'username/my-docker-image-name:latest'
```

### Using Amazon Elastic Container Registry (ECR)
Deploy using an image from Amazon ECR:

```yaml
- name: Deploy to CapRover Using GitHub Actions
  uses: dankore/github-to-caprover@v1.2.1
  with:
    server: '${{ secrets.CAPROVER_URL }}'
    password: '${{ secrets.CAPROVER_PASSWORD }}'
    appName: '${{ secrets.CAPROVER_APP }}'
    image: '123456789012.dkr.ecr.region.amazonaws.com/my-repo-name:tag'
```

### Using Google Container Registry (GCR)
Deploy using an image from Google Container Registry:

```yaml
- name: Deploy to CapRover Using GitHub Actions
  uses: dankore/github-to-caprover@v1.2.1
  with:
    server: '${{ secrets.CAPROVER_URL }}'
    password: '${{ secrets.CAPROVER_PASSWORD }}'
    appName: '${{ secrets.CAPROVER_APP }}'
    image: 'gcr.io/my-project-id/my-image-repo:my-tag'
```

## Security Recommendations

- **Sensitive Data:** Always use GitHub Secrets to store sensitive information such as the server URL, password, and app name to ensure security.
- **Access Control:** Limit access to the repository containing this workflow to trusted collaborators only.

## CapRover CLI pin

This action installs **`caprover@2.3.1`**. CapRover CLI **`2.4.0+`** crashes on load because Commander rejects a duplicate short flag (`-t` used by both `--tarFile` and `--appToken`). Keep the pin until upstream ships a fix.

For further details on setting up and managing deployments with CapRover, consult the [CapRover documentation](https://caprover.com/).

## Development

```bash
git clone https://github.com/dankore/github-to-caprover.git
cd github-to-caprover
docker build -t github-to-caprover .
# Arguments: server, password, app_token, appName, branch, image
docker run --rm github-to-caprover captain.example.com "" "$CAPROVER_APP_TOKEN" my-app "" ghcr.io/me/my-app:latest
```

To try a change in a real workflow, push it to a branch and use `uses: dankore/github-to-caprover@your-branch`.

## Roadmap

See [ROADMAP.md](./ROADMAP.md).

## License

[MIT](./LICENSE) © Dankore Software LLC
