# cfssl-testing

CFSSL Testing

## Process

```shell
./start-postgres.sh
./serve.sh
```

```shell
./create-user.sh | tee tmp-user.json
./cert-from-json.sh < tmp-user.json
./list-certs.sh
./revoke.sh tmp-user.pem
./list-certs.sh
```
