# cfssl-testing

CFSSL Testing CRL and certificate storage.

Starts a CFSSL server with postgresql backend.

## Process

```shell
./start-postgres.sh
goose -dir "${GOPATH}/src/github.com/cloudflare/cfssl/certdb/pg/migrations/" postgres "user=postgres password=cfssl dbname=postgres sslmode=disable" up
```

```shell
./serve.sh
```

```shell
./create-user.sh | tee tmp-user.json
./cert-from-json.sh < tmp-user.json
./list-certs.sh
./revoke.sh tmp-user.pem
./list-certs.sh
```
