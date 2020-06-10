######################
# CFSSL
######################

.PHONY: cfssl
cfssl: artifacts/certs/server.pem artifacts/certs/client.pem

artifacts/certs/ca-config.json:
	-@mkdir -p "$(@D)"
	cp ./ca-config.json artifacts/certs/ca-config.json

artifacts/certs/ca.pem: artifacts/certs/ca-config.json ./ca-csr.json
	-@mkdir -p "$(@D)"
	cfssl gencert -initca -config="artifacts/certs/ca-config.json" -profile="ca" ./ca-csr.json | cfssljson -bare artifacts/certs/ca -
	cfssl sign -ca="artifacts/certs/ca.pem" -ca-key="artifacts/certs/ca-key.pem" -config="artifacts/certs/ca-config.json" -profile="ca" -csr=artifacts/certs/ca.csr ./ca-csr.json | cfssljson -bare artifacts/certs/ca

artifacts/certs/server.pem: ./test-host.json artifacts/certs/ca.pem 
	-@mkdir -p "$(@D)"
	cfssl gencert -initca -config="artifacts/certs/ca-config.json" -profile="server" "$(<)" | cfssljson -bare artifacts/certs/server -
	cfssl sign -ca="artifacts/certs/ca.pem" -ca-key="artifacts/certs/ca-key.pem" -config="artifacts/certs/ca-config.json" -profile="server" artifacts/certs/server.csr | cfssljson -bare artifacts/certs/server

artifacts/certs/client.pem: ./test-client.json artifacts/certs/ca.pem
	-@mkdir -p "$(@D)"
	cfssl gencert -initca -config="artifacts/certs/ca-config.json" -profile="client" "$(<)" | cfssljson -bare artifacts/certs/client -
	cfssl sign -ca="artifacts/certs/ca.pem" -ca-key="artifacts/certs/ca-key.pem" -config="artifacts/certs/ca-config.json" -profile="client" artifacts/certs/client.csr | cfssljson -bare artifacts/certs/client
