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

Image to be deployed. It should either exist on server, or it has to be public, or on a private repository that CapRover has access to.

> _NOTE:_ if image is used `branch` will be ignored

## Usage

```
uses: dankore/action-caprover@v1
with:
  server: '${{ secrets.CAPROVER_URL }}'
  password: '${{ secrets.CAPROVER_PASSWORD }}'
  appName: '${{ secrets.CAPROVER_APP }}'
  image: 'YOUR-DOCKER-IMAGE-NAME'

```
