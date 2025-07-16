#!/bin/bash
if [ ! -f .env ]; then
  ./inject_repo_creds.sh
fi

source .env

# Create temporary container to copy nginx config
docker volume create project_nginx_conf
docker container create --name nginx_tmp -v project_nginx_conf:/etc/nginx/conf.d alpine
docker cp nginx/default.conf nginx_tmp:/etc/nginx/conf.d/
docker compose exec nginx nginx -s reload
docker rm nginx_tmp

# Run Docker Compose without local volumes
docker-compose --profile core up --build --no-deps -d
