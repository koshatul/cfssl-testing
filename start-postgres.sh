#!/bin/bash

docker run \
 -d --name=postgres-cfssl \
 -p 5432:5432 \
 -e "POSTGRES_PASSWORD=cfssl" \
 postgres:latest
