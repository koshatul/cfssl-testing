#!/bin/bash

docker exec -i postgres-cfssl psql -U postgres postgres <<<'select serial_number, expiry, revoked_at from certificates\x'
