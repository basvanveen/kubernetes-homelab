rm -f /var/lib/kubernetes/kube-scheduler.kubeconfig
kubectl config set-cluster dopdop \
--certificate-authority=/var/lib/kubernetes/ca.crt \
--embed-certs=true \
--server=https://INTERNAL_IP:6443 \
--kubeconfig=/var/lib/kubernetes/kube-scheduler.kubeconfig

kubectl config set-credentials system:kube-scheduler \
--client-certificate=/var/lib/kubernetes/kube-scheduler.crt \
--client-key=/var/lib/kubernetes/kube-scheduler.key \
--embed-certs=true \
--kubeconfig=/var/lib/kubernetes/kube-scheduler.kubeconfig

kubectl config set-context default \
--cluster=dopdop \
--user=system:kube-scheduler \
--kubeconfig=/var/lib/kubernetes/kube-scheduler.kubeconfig

kubectl config use-context default --kubeconfig=/var/lib/kubernetes/kube-scheduler.kubeconfig
