FROM node:6-stretch

RUN apt update && apt install nodejs libsodium-dev libzmq3-dev -y

USER node
WORKDIR /home/node

ARG INSIGHT_UI_REPO="git+https://git@github.com/DeckerSU/insight-ui-komodo"

RUN npm install git+https://git@github.com/DeckerSU/bitcore-node-komodo && \
    ./node_modules/bitcore-node-komodo/bin/bitcore-node create explorer && \
    cd explorer && \
    ../node_modules/bitcore-node-komodo/bin/bitcore-node install git+https://git@github.com/DeckerSU/insight-api-komodo ${INSIGHT_UI_REPO} && \
    sed -i 's/3 \* 1e8/1 \* 1e4/g' ./node_modules/insight-api-komodo/lib/blocks.js

ADD ./bitcore-node.json ./explorer/bitcore-node.json

WORKDIR /home/node/explorer

ADD ./docker-entrypoint.sh /

ENTRYPOINT [ "/docker-entrypoint.sh" ]
