#!/bin/sh

sed -i "s/KMD/${AC_NAME}/g" /home/node/explorer/node_modules/insight-ui-komodo/public/js/main.min.js

/home/node/explorer/node_modules/bitcore-node-komodo/bin/bitcore-node start