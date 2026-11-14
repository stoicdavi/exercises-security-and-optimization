# Optimizing Docker Images

This exercise updates the backend and frontend Dockerfiles from `3_5` to reduce image size and avoid unnecessary image layers while keeping both applications running as non-root users.

## Backend

The backend uses a multi-stage build. Go compiles the application in a Go Alpine build image, with compiler metadata and debug symbols omitted. The final image uses Alpine and contains only the compiled server binary, rather than the Go toolchain and application source. The server runs as UID/GID `1001:1001`.

## Frontend

The frontend keeps its Ubuntu base image, but combines its package setup, dependency installation, production build, and `serve` installation into a single `RUN` instruction. This reduces the number of layers compared with the separate `RUN` instructions in `3_5`. The frontend runs as the unprivileged `appuser`.

## Build the images

Run these commands from the repository root so the Dockerfiles can access the `code/` directory:

```sh
docker build -f 3_6/Dockerfile.backend -t exercise-3-6-backend ..
docker build -f 3_6/Dockerfile.frontend -t exercise-3-6-frontend ..
```
