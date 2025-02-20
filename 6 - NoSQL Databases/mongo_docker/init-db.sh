#!/bin/bash

echo "Waiting for MongoDB to start..."
sleep 10

echo "Importing JSON files into MongoDB..."
mongoimport --host localhost --db class --collection users --file /docker-entrypoint-initdb.d/users.json --jsonArray --username root --password password --authenticationDatabase admin
mongoimport --host localhost --db class --collection books --file /docker-entrypoint-initdb.d/books.json --jsonArray --username root --password password --authenticationDatabase admin

echo "MongoDB data import complete."
