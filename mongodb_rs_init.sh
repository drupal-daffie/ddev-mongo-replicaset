#!/bin/bash

echo "###### Waiting for mongo primary member instance startup.."
until mongosh --host mongo:27017 --eval 'quit(db.runCommand({ ping: 1 }).ok ? 0 : 2)' &>/dev/null; do
  printf '.'
  sleep 1
done
echo "###### Working mongo primary member instance found, initiating user setup & initializing rs setup.."

# setup user + pass and initialize replica sets
mongosh --host mongo:27017 <<EOF
var rootUser = 'db';
var rootPassword = 'db';
var admin = db.getSiblingDB('admin');
admin.auth(rootUser, rootPassword);

var config = {
    "_id": "dbrs",
    "version": 1,
    "members": [
        {
            "_id": 1,
            "host": "mongo:27017",
            "priority": 2
        },
        {
            "_id": 2,
            "host": "mongo-secondary:27017",
            "priority": 1
        },
        {
            "_id": 3,
            "host": "mongo-arbiter:27017",
            "priority": 1,
            "arbiterOnly": true
        }
    ]
};
rs.initiate(config, { force: true });
rs.status();
EOF

# use rs.reconfig() to change the config instead of rs.initiate() for startup.
