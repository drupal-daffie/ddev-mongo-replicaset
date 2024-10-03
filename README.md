[![tests](https://github.com/ddev/ddev-mongo/actions/workflows/tests.yml/badge.svg)](https://github.com/ddev/ddev-mongo/actions/workflows/tests.yml) ![project is maintained](https://img.shields.io/maintenance/yes/2024.svg)


## What is ddev-mongo-replicaset?

This repository provides MongoDB as a [replica set](https://www.mongodb.com/docs/manual/replication/) and Mongo Express add-on to [DDEV](https://ddev.readthedocs.io).

MongoDB as a replica set offers a couple of extras that a standalone MongoDB setup does not offer (for development):
 - [Transactions](https://www.mongodb.com/docs/manual/replication/#transactions)
 - [Change streams](https://www.mongodb.com/docs/manual/replication/#change-streams)

This DDEV addon is not compatible with the DDEV addon for standalone MongoDB (`ddev-mongo`). Use the standalone MongoDB OR use the MongoDB as a replica set. NOT BOTH!

It's based on [MongoDB from Docker Hub](https://hub.docker.com/_/mongo?tab=description#-via-docker-stack-deploy-or-docker-compose), [DDEV custom compose files](https://ddev.readthedocs.io/en/stable/users/extend/custom-compose-files/) and [API Platform tutorial](https://api-platform.com/docs/core/mongodb/#enabling-mongodb-support).

## How to install

Run the command: `ddev get drupal-daffie/ddev-mongo-replicaset`

## Connection to the MongoDB replica set

 - Inside docker: `mongodb://db:db@mongo/?replicaSet=dbrs`
 - Outside docker: `mongodb://db:db@localhost:27017`
 - MongoDB Compass: `mongodb://db:db@localhost:27017/?directConnection=true&replicaSet=dbrs`
 - Mongo Express will now be accessible from `http://<project>.ddev.site:9091`


## The replica.key file

For security reasons MongoDB requires a replication key file. This DDEV addon has such a file. If you would like to create your own, you can do that with the following command
`openssl rand -base64 741 > replica.key`. For more information about [generating a key file](https://www.mongodb.com/docs/v2.4/tutorial/generate-key-file/).


## `ddev mongosh` command

This command will run the `mongosh` (mongoDB Shell) command in the `mongo` container. Please [read the documentation](https://www.mongodb.com/docs/mongodb-shell/) for more information.


## Caveats:

* The php extension (phpX.X-mongodb) is set up in `.ddev/config.mongo.yaml` using `webimage_extra_packages`. If you have an earlier `webimage_extra_packages` in your config.yaml, this will override it. You may want to edit your config.yaml to do what you want and remove the config.mongo.yaml.
* You can't define custom MongoDB configuration with this current setup.
* You can't use `ddev import-db` to import to mongo.
