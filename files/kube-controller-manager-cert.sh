#!/bin/bash
openssl genrsa -out /var/lib/kubernetes/kube-controller-manager.key 2048
openssl req -new -key /var/lib/kubernetes/kube-controller-manager.key -out /var/lib/kubernetes/kube-controller-manager.csr -subj "/CN=system:kube-controller-manager" -config /var/lib/kubernetes/openssl-controller.conf
openssl x509 -req -in /var/lib/kubernetes/kube-controller-manager.csr -CA /var/lib/kubernetes/ca.crt -CAkey /var/lib/kubernetes/ca.key -CAcreateserial -out /var/lib/kubernetes/kube-controller-manager.crt  -days 365 -extensions v3_req -extfile /var/lib/kubernetes/openssl-controller.conf
