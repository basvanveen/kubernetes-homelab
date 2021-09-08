#!/bin/bash
openssl genrsa -out /var/lib/kubernetes/admin.key 2048
openssl req -new -key /var/lib/kubernetes/admin.key -out /var/lib/kubernetes/admin.csr -subj "/CN=admin/O=system:masters" -config /var/lib/kubernetes/openssl-controller.conf
openssl x509 -req -in /var/lib/kubernetes/admin.csr -CA /var/lib/kubernetes/ca.crt -CAkey /var/lib/kubernetes/ca.key -CAcreateserial -out /var/lib/kubernetes/admin.crt  -days 365 -extensions v3_req -extfile /var/lib/kubernetes/openssl-controller.conf
