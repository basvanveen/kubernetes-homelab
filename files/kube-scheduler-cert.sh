#!/bin/bash
openssl genrsa -out /var/lib/kubernetes/kube-scheduler.key 2048
openssl req -new -key /var/lib/kubernetes/kube-scheduler.key -out /var/lib/kubernetes/kube-scheduler.csr -subj "/CN=system:kube-scheduler" -config /var/lib/kubernetes/openssl-controller.conf
openssl x509 -req -in /var/lib/kubernetes/kube-scheduler.csr -CA /var/lib/kubernetes/ca.crt -CAkey /var/lib/kubernetes/ca.key -CAcreateserial -out /var/lib/kubernetes/kube-scheduler.crt  -days 365 -extensions v3_req -extfile /var/lib/kubernetes/openssl-controller.conf
