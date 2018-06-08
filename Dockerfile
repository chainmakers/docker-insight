FROM node:6-stretch

RUN apt update && apt install nodejs libsodium-dev libzmq3-dev -y

USER node
WORKDIR /home/node

RUN npm install git+https://git@github.com/DeckerSU/bitcore-node-komodo && \
    ./node_modules/bitcore-node-komodo/bin/bitcore-node create explorer && \
    cd explorer && \
    ../node_modules/bitcore-node-komodo/bin/bitcore-node install git+https://git@github.com/DeckerSU/insight-api-komodo git+https://git@github.com/DeckerSU/insight-ui-komodo

ADD ./bitcore-node.json ./explorer/bitcore-node.json

WORKDIR /home/node/explorer

CMD ["./node_modules/bitcore-node-komodo/bin/bitcore-node", "start"]
