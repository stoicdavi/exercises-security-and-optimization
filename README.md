# Docker Security and Image Optimization Exercises

This repository contains Docker exercises for building and publishing images, running containers with reduced privileges, and producing smaller runtime images. The example application is in [`code/`](code/), and exercise-specific Dockerfiles and instructions are grouped by exercise number.

## Exercises

| Directory | Topic |
| --- | --- |
| [`3_3/`](3_3/) | Build and push an image from a GitHub repository with a shell script. |
| [`3_4/`](3_4/) | Run the image-builder script in a container. |
| [`3_5/`](3_5/) | Run the example frontend and backend as non-root users. |
| [`3_6/`](3_6/) | Optimize the frontend and backend images while retaining non-root execution. |
| [`3_7/`](3_7/) | Use prebuilt Alpine-based Node.js and Go images. |
| [`3_89/`](3_89/) | Use a multi-stage frontend build and a minimal `scratch` backend image (exercises 3.8 and 3.9). |

See each directory's README for exercise-specific prerequisites and commands where available.

## Build Context

Run application image builds from the repository root. The Dockerfiles use files under `code/`, so the repository root must be the build context. For example:

```sh
docker build -f 3_5/Dockerfile.backend -t exercise-3-5-backend ..
docker build -f 3_5/Dockerfile.frontend -t exercise-3-5-frontend ..
```

## Tests

The standalone checks are in [`tests/`](tests/). Run an individual check from the repository root with Bash, for example:

```sh
bash tests/test_3_05_nonroot_dockerfiles.sh
```

Some checks build and run Docker images; the integration checks also use the Playwright setup in [`tests/playwright/`](tests/playwright/). Check a test's prerequisites before running it.
