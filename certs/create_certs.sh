# Verify specific change to resolver of cloud projects/tenants
export DESIGNATE_IP="192.168.100.1"

# Certificate Authority
openssl genrsa -out ca.key 2048
openssl req -new -key ca.key -subj '/CN=KUBERNETES-CA' -out ca.csr
openssl x509 -req -in ca.csr -signkey ca.key -out ca.crt

# etcd certs
sed -i '/IP./d' openssl-etcd.cnf
echo "IP.1=`dig +short @$DESIGNATE_IP etcd-0.os.dopdop.nl`" >> openssl-etcd.cnf
echo "IP.2=`dig +short @$DESIGNATE_IP etcd-1.os.dopdop.nl`" >> openssl-etcd.cnf
echo "IP.3=`dig +short @$DESIGNATE_IP etcd-2.os.dopdop.nl`" >> openssl-etcd.cnf
openssl genrsa -out etcd.key 2048
openssl req -new -key etcd.key -subj "/CN=etcd" -out etcd.csr --config openssl-etcd.cnf
openssl x509 -req -in etcd.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out etcd.crt -days 3650 -extensions ssl_client -extfile openssl-etcd.cnf
# service account cert
openssl genrsa -out service-account.key 2048
openssl req -new -key service-account.key -subj "/CN=service-accounts" -out service-account.csr --config openssl.cnf
openssl x509 -req -in service-account.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out service-account.crt
