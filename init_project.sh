if uname -a | grep --quiet Darwin; then
  # before continue on mac install envsubst
  export $(grep -v '^#' .env | xargs -0)
else
  export $(grep -v '^#' .env | xargs -d '\n')
fi

mkdir -p "$PWD/$PROJECT_DIR" "$PWD/$CONFIG_DIR"

cat > "$PWD/$PM2_CONFIG_FILE" <<EOF
{
  "name": "code",
  "script": "index.js"
}

EOF

# create package.json in $PROJECT_DIR
docker run --rm -ti -v "$PWD/$PROJECT_DIR":"$DOCKER_PROJECT_DIR" -w "$DOCKER_PROJECT_DIR" $NODE_IMAGE npm init
# add express dependency in $PROJECT_DIR (add node_modules)
docker run --rm -ti -v "$PWD/$PROJECT_DIR":"$DOCKER_PROJECT_DIR" -w "$DOCKER_PROJECT_DIR" $NODE_IMAGE npm i --save express
# remove node_modules from $PROJECT_DIR
rm -rf "$PWD/$PROJECT_DIR/node_modules"
envsubst '$CONTAINER_DB_NAME' < docker-compose.yml_template > docker-compose.yml
