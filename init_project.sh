if uname -a | grep --quiet Darwin; then
  export $(grep -v '^#' .env | xargs -0)
else
  export $(grep -v '^#' .env | xargs -d '\n')
fi

mkdir -p "$PWD/$PROJECT_DIR/" "$PWD/src/project/config"

cat > "$PWD/src/project/config/pm2.json" <<EOF
{
  "name": "code",
  "script": "index.js"
}

EOF

docker run --rm -ti -v "$PWD/$PROJECT_DIR":"$DOCKER_PROJECT_DIR" -w "$DOCKER_PROJECT_DIR" $NODE_IMAGE npm init
docker run --rm -ti -v "$PWD/$PROJECT_DIR":"$DOCKER_PROJECT_DIR" -w "$DOCKER_PROJECT_DIR" $NODE_IMAGE npm i --save express
rm -rf "$PWD/$PROJECT_DIR/node_modules"
envsubst '$CONTAINER_DB_NAME' < docker-compose.yml_template > docker-compose.yml
