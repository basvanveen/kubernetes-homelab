#!/bin/bash
openssl genrsa -out /var/lib/kubernetes/kubelet.key 2048
openssl req -new -key /var/lib/kubernetes/kubelet.key -out /var/lib/kubernetes/kubelet.csr -subj "/CN=system:node:`hostname --short`/O=system:nodes" -config /var/lib/kubernetes/openssl-controller.conf
openssl x509 -req -in /var/lib/kubernetes/kubelet.csr -CA /var/lib/kubernetes/ca.crt -CAkey /var/lib/kubernetes/ca.key -CAcreateserial -out /var/lib/kubernetes/kubelet.crt  -days 365 -extensions v3_req -extfile /var/lib/kubernetes/openssl-controller.conf

