# Running Containers as a Non-Root User

This exercise updates the example backend and frontend Dockerfiles to run their application processes as unprivileged users instead of root. The backend runs as `serveruser`; the frontend runs as `appuser`.

## Build the images

Run these commands from the repository root. The Dockerfiles copy application code from the repository's `code/` directory, so the build context must be the repository root:

```sh
docker build -f 3_5/Dockerfile.backend -t exercise-3-5-backend .
docker build -f 3_5/Dockerfile.frontend -t exercise-3-5-frontend .
```

## Run the applications

Start the backend and frontend containers:

```sh
docker run -d --name exercise-3-5-backend -p 8080:8080 exercise-3-5-backend
docker run -d --name exercise-3-5-frontend -p 5001:5001 exercise-3-5-frontend
```

Open [http://localhost:5001](http://localhost:5001). The frontend is configured to connect to the backend at `http://localhost:8080`.

To verify that each container is running as a non-root user:

```sh
docker exec exercise-3-5-backend id -u
docker exec exercise-3-5-frontend id -u
```

Both commands should print a UID other than `0`. Remove the containers when finished:

```sh
docker rm -f exercise-3-5-backend exercise-3-5-frontend
```
