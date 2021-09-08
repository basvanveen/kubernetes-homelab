#!/bin/bash
openssl genrsa -out /var/lib/kubernetes/kube-proxy.key 2048
openssl req -new -key /var/lib/kubernetes/kube-proxy.key -out /var/lib/kubernetes/kube-proxy.csr -subj "/CN=system:kube-proxy/O=system:node-proxier" -config /var/lib/kubernetes/openssl-controller.conf
openssl x509 -req -in /var/lib/kubernetes/kube-proxy.csr -CA /var/lib/kubernetes/ca.crt -CAkey /var/lib/kubernetes/ca.key -CAcreateserial -out /var/lib/kubernetes/kube-proxy.crt  -days 365 -extensions v3_req -extfile /var/lib/kubernetes/openssl-controller.conf
