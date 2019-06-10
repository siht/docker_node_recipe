export $(grep -v '^#' .env | xargs -d '\n')

docker run --rm -ti -v "$PWD/$PROJECT_DIR":"$DOCKER_PROJECT_DIR" -w "$DOCKER_PROJECT_DIR" $NODE_IMAGE npm install
envsubst '$CONTAINER_DB_NAME' < docker-compose.yml_template > docker-compose.yml
