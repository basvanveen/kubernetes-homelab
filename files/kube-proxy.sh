  kubectl config set-cluster dopdop \
    --certificate-authority=/var/lib/kubernetes/ca.crt \
    --embed-certs=true \
    --server=https://INTERNAL_IP:6443 \
    --kubeconfig=/var/lib/kube-proxy/kubeconfig

  kubectl config set-credentials system:kube-proxy \
    --client-certificate=/var/lib/kubernetes/kube-proxy.crt \
    --client-key=/var/lib/kubernetes/kube-proxy.key \
    --embed-certs=true \
    --kubeconfig=/var/lib/kube-proxy/kubeconfig

  kubectl config set-context default \
    --cluster=dopdop \
    --user=system:kube-proxy \
    --kubeconfig=/var/lib/kube-proxy/kubeconfig

  kubectl config use-context default --kubeconfig=/var/lib/kube-proxy/kubeconfig
