# Docker Image Builder

`builder.sh` clones a GitHub repository, builds a Docker image from the repository's root `Dockerfile`, and pushes the image to Docker Hub.

## Prerequisites

- Git and Docker are installed.
- The Docker daemon is running.
- You can access the GitHub repository.
- You have a Docker Hub account and permission to push to the target image repository.
- The cloned repository contains a file named `Dockerfile` in its root directory.

The script runs `docker login` before building and pushing. Docker may prompt you to authenticate. Do not put your Docker Hub password or access token in the command line or script.

## Usage

Run the script from the directory where you want the repository cloned. Pass the GitHub repository as `OWNER/REPOSITORY` and the Docker Hub image as `USERNAME/IMAGE:TAG`:

```sh
sh ./builder.sh OWNER/REPOSITORY USERNAME/IMAGE:TAG
```

For example:

```sh
sh ./builder.sh example-org/example-app mydockerhubuser/example-app:latest
```

The script clones `https://github.com/OWNER/REPOSITORY.git` into a directory named after the repository. It then changes into that directory, builds the root `Dockerfile` using the supplied image name as the tag, and pushes that same tag to Docker Hub.

The target clone directory must not already exist. If you have cloned the repository there before, remove or rename that directory before running the script again.

The script expects exactly two arguments. It exits when cloning, building, or pushing fails; check the command output if an operation does not complete.
