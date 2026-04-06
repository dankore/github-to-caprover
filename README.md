# Deploy to CapRover Using GitHub Actions

This GitHub Action enables automatic deployment of applications to a CapRover server, streamlining continuous deployment workflows. Ensure you have administrative access to the CapRover server and the necessary GitHub repository permissions to implement this action.

## Inputs

Detailed below are the required and optional inputs for the action:

### `server` (required)
- **Description:** URL of your CapRover server, such as `captain.your-domain.com`.
- **Example:** `${{ secrets.CAPROVER_URL }}`

### `password` (required unless `app-token` is set)
- **Description:** Your CapRover login password to authenticate deployment requests. Omit this when using `app-token` (for example on [CapRover Pro](https://caprover.com/) with two-factor authentication enabled).
- **Example:** `${{ secrets.CAPROVER_PASSWORD }}`

### `app-token` (optional)
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
  uses: dankore/github-to-caprover@v1.1.0
  with:
    server: '${{ secrets.CAPROVER_URL }}'
    app-token: '${{ secrets.CAPROVER_APP_TOKEN }}'
    appName: '${{ secrets.CAPROVER_APP }}'
    image: 'my-docker-image-name'
```

You can create the token in the app’s **Deployment** tab. The workflow is unchanged for everyone else: keep passing `password` and leave `app-token` unset.

### Basic Usage
Deploy an application using a Docker image specified in the workflow:

```yaml
- name: Deploy to CapRover Using GitHub Actions
  uses: dankore/github-to-caprover@v1.1.0
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
  uses: dankore/github-to-caprover@v1.1.0
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
  uses: dankore/github-to-caprover@v1.1.0
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
  uses: dankore/github-to-caprover@v1.1.0
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
  uses: dankore/github-to-caprover@v1.1.0
  with:
    server: '${{ secrets.CAPROVER_URL }}'
    password: '${{ secrets.CAPROVER_PASSWORD }}'
    appName: '${{ secrets.CAPROVER_APP }}'
    image: 'gcr.io/my-project-id/my-image-repo:my-tag'
```

## Security Recommendations

- **Sensitive Data:** Always use GitHub Secrets to store sensitive information such as the server URL, password, and app name to ensure security.
- **Access Control:** Limit access to the repository containing this workflow to trusted collaborators only.

For further details on setting up and managing deployments with CapRover, consult the [CapRover documentation](https://caprover.com/).
