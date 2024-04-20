# Deploy to CapRover Using GitHub Actions

This GitHub Action enables automatic deployment of applications to a CapRover server, streamlining continuous deployment workflows. Ensure you have administrative access to the CapRover server and the necessary GitHub repository permissions to implement this action.

## Inputs

Detailed below are the required and optional inputs for the action:

### `server` (required)
- **Description:** URL of your CapRover server, such as `captain.your-domain.com`.
- **Example:** `${{ secrets.CAPROVER_URL }}`

### `password` (required)
- **Description:** Your CapRover login password to authenticate deployment requests.
- **Example:** `${{ secrets.CAPROVER_PASSWORD }}`

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

### Basic Usage
Deploy an application using a Docker image specified in the workflow:

```yaml
- name: Deploy to CapRover Using GitHub Actions
  uses: dankore/github-to-caprover@v1.0.9
  with:
    server: '${{ secrets.CAPROVER_URL }}'
    password: '${{ secrets.CAPROVER_PASSWORD }}'
    appName: '${{ secrets.CAPROVER_APP }}'
    image: 'my-docker-image-name'
```

### Advanced Usage with GitHub Container Registry
For deploying an application using an image from the GitHub Container Registry:

```yaml
- name: Deploy to CapRover Using GitHub Actions
  uses: dankore/github-to-caprover@v1.0.9
  with:
    server: '${{ secrets.CAPROVER_URL }}'
    password: '${{ secrets.CAPROVER_PASSWORD }}'
    appName: '${{ secrets.CAPROVER_APP }}'
    image: 'ghcr.io/mygithub-username/my-docker-image-name:my-label'
```

## Security Recommendations

- **Sensitive Data:** Always use GitHub Secrets to store sensitive information such as the server URL, password, and app name to ensure security.
- **Access Control:** Limit access to the repository containing this workflow to trusted collaborators only.

For further details on setting up and managing deployments with CapRover, consult the [CapRover documentation](https://caprover.com/).
