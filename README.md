# Deploy to Caprover Using GitHub Actions

Action to deploy application to CapRover server

## Inputs

### `server`: required

The URL to your caprover e.g captain.your-domain.com

### `password`: required

Your Caprover login password

### `appName`: required

The name of the app on Caprover

### `branch`

The GitHub Repo branch to deploy

### `image`

Image to be deployed.

## Usage

```
uses: dankore/action-caprover@v1
with:
  server: '${{ secrets.CAPROVER_URL }}'
  password: '${{ secrets.CAPROVER_PASSWORD }}'
  appName: '${{ secrets.CAPROVER_APP }}'
  image: 'YOUR-DOCKER-IMAGE-NAME'

```
