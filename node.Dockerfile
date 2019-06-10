ARG NODE_IMAGE
FROM $NODE_IMAGE

ARG PROJECT_DIR
ARG DOCKER_PROJECT_DIR

RUN apk add --no-cache netcat-openbsd && \
    npm install pm2 -g

ADD $PROJECT_DIR $DOCKER_PROJECT_DIR
COPY src/config/pm2.json $DOCKER_PROJECT_DIR
COPY setup.sh $DOCKER_PROJECT_DIR
WORKDIR $DOCKER_PROJECT_DIR
RUN npm i

CMD ["pm2", "start", "pm2.json", "--no-daemon"]
