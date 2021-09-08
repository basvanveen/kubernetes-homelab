  kubectl config set-cluster dopdop \
    --certificate-authority=/var/lib/kubernetes/ca.crt \
    --embed-certs=true \
    --server=https://INTERNAL_IP:6443 \
    --kubeconfig=/var/lib/kubelet/kubeconfig

  kubectl config set-credentials system:node:node-0 \
    --client-certificate=/var/lib/kubelet/kubelet.crt \
    --client-key=/var/lib/kubelet/kubelet.key \
    --embed-certs=true \
    --kubeconfig=/var/lib/kubelet/kubeconfig

  kubectl config set-context default \
    --cluster=dopdop \
    --user=system:node:node-0 \
    --kubeconfig=/var/lib/kubelet/kubeconfig

  kubectl config use-context default --kubeconfig=/var/lib/kubelet/kubeconfig                                               
