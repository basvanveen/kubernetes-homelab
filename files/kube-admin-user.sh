rm -f /var/lib/kubernetes/admin.kubeconfig
kubectl config set-cluster dopdop \
--certificate-authority=/var/lib/kubernetes/ca.crt \
--embed-certs=true \
--server=https://controller-0:6443 \
--kubeconfig=/var/lib/kubernetes/admin.kubeconfig

kubectl config set-credentials admin \
--client-certificate=/var/lib/kubernetes/admin.crt \
--client-key=/var/lib/kubernetes/admin.key \
--embed-certs=true \
--kubeconfig=/var/lib/kubernetes/admin.kubeconfig

kubectl config set-context default \
--cluster=dopdop \
--user=admin \
--kubeconfig=/var/lib/kubernetes/admin.kubeconfig

kubectl config use-context default --kubeconfig=/var/lib/kubernetes/admin.kubeconfig
