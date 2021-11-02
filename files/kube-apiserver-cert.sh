#!/bin/bash
openssl genrsa -out /var/lib/kubernetes/kubernetes.key 2048
openssl req -new -key /var/lib/kubernetes/kubernetes.key -out /var/lib/kubernetes/kubernetes.csr -subj "/CN=kube-apiserver/O=system:masters" -config /var/lib/kubernetes/openssl-controller.conf
openssl x509 -req -in /var/lib/kubernetes/kubernetes.csr -CA /var/lib/kubernetes/ca.crt -CAkey /var/lib/kubernetes/ca.key -CAcreateserial -out /var/lib/kubernetes/kubernetes.crt  -days 365 -extensions v3_req -extfile /var/lib/kubernetes/openssl-controller.conf
