# Docker compose managed test harness

Example for a blog post about nginx docker compose

## Setup

To run this you will execute one of the following commands depending on your build source:

### Local Build

To build from local directories, run:

```bash
./build_local.sh
```

This setup allows for hot-swapping of code. Any changes made in the `repo_refs` directories will be immediately reflected in the running containers, allowing developers to see their changes in real-time via the nginx server.

### GitHub Build

Prerequisites:
- This requires a github token with access to the repos.  As such we need to add an `ENV` var `GH_TOKEN`. You can add this to your local shell or directing into the `.env`

To build from GitHub repositories, run:

```bash
./build_github.sh
```

The GitHub build process is isolated from the local development environment, ensuring a clean and isolated build environment. This prevents any potential conflicts with local volumes.

### CircleCi Oddities

You'll notice that the build_github.sh script does not share volumes to inject the default.conf into nginx. This is because circleci does not allow volume sharing between the host and the docker executor. This is a limitation of the circleci platform, and not a limitation of docker.
As such we copy the nginx file into the container after the build process and restart the nginx service.

CircleCI is also not a huge fan of docker compose port forwarding, so we run the tests from inside their docker container to be able to access the ngninx service on the network.

## Once Built

Once the container is up and running, you can hit `http://localhost:8089/` it `/` will route you to FE react project by default.

`http://localhost:8089/backend/` will route you to the backend service.

`http://localhost:8089/api/` will route you to the backend service with the api path.
