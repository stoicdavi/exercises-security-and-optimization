# GitHub Docker Image Builder

This container clones a public GitHub repository, builds its Docker image, and pushes the image to Docker Hub.

## Prerequisites

- Docker Engine on a Linux host
- Network access to GitHub and Docker Hub
- A public GitHub repository containing a `Dockerfile`
- A Docker Hub account and access token with permission to push the target image

The container needs access to a Docker daemon to build and push images. The Dockerfile replaces the base image's default entrypoint, so it does not start the `dind-rootless` daemon itself. The command below mounts the host Docker socket instead. **A container with access to this socket can control the host's Docker daemon.**

## Build the builder image

Run this from the directory containing the Dockerfile:

```sh
docker build -t github-image-builder .
```

## Set Docker Hub credentials

Use a Docker Hub access token rather than your account password:

```sh
export DOCKER_USER="your-dockerhub-username"
read -rsp "Docker Hub access token: " DOCKER_PWD
printf '\n'
export DOCKER_PWD
```

The token is passed to the container as an environment variable. Avoid putting it directly in the `docker run` command or committing it to a file in this project.

## Run

Pass the GitHub repository as `owner/repository` and the target Docker Hub image as `owner/image:tag`:

```sh
docker run --rm \
  --group-add "$(stat -c '%g' /var/run/docker.sock)" \
	--env DOCKER_USER \
	--env DOCKER_PWD \
	--mount type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
	github-image-builder \
	owner/repository owner/image:tag
```

For example:

```sh
docker run --rm \
	--group-add "$(stat -c '%g' /var/run/docker.sock)" \
	--env DOCKER_USER \
	--env DOCKER_PWD \
	--mount type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
	github-image-builder \
	stoicdavi/express_app daviddean181/testing:latest
```

The script logs in to Docker Hub, builds the repository's Dockerfile, and pushes the resulting image. The target image name should include your Docker Hub namespace and a tag.

## Troubleshooting

- If the build cannot resolve `auth.docker.io`, check that the host has working DNS and internet access, then retry.
- If Docker reports a permission error for `/var/run/docker.sock`, confirm your user can access the host socket and that the socket's group ID is being passed with `--group-add`.
- If the script reports its usage, provide exactly two arguments: the GitHub repository and the target image name.
