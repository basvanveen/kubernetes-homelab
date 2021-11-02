# kubernetes-homelab
Kubernetes lab env, created to test/bootstrap a kubernetes cluster in a homelab setting. Not the most elegant/clean ansible yaml/tf resource files but it works in my specific case 🙃

https://github.com/kelseyhightower/kubernetes-the-hard-way/ helped a lot with getting the right binaries and config files ❤️

## Bootstrapping a simple k8s cluster with multiple nodes

This setup is based on my own homelab setup using openstack (Wallaby), but any other provider would do (OVH etc...) be sure to change the provider details for terraform.

- Create infra (vms for etcd cluster and kubernetes controller/nodes)
```
make init
make infra-all
```

- Create Initial CA/Cert and Inventory for playbooks
```
make inventory
make create-ca
```

- Create 3 node ETCD cluster
```
make etcd
```

- Create Controller(s)
```
make controller-full
```

- Create worker/minion nodes
```
make node-full
```

All should be set now 🤞

## Checking cluster status

- Checking ETCD Cluster health
```
root@etcd-0:~# etcdctl endpoint health --endpoints=https://etcd-0:2379 --cacert=/etc/etcd/ca.crt --cert=/etc/etcd/etcd.crt --key=/etc/etcd/etcd.key
https://etcd-0:2379 is healthy: successfully committed proposal: took = 187.911999ms
```

- Checking kubernetes cluster health
```
root@node-0:~# kubectl cluster-info
Kubernetes control plane is running at https://controller-0:6443

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
```

- Check if all nodes are added and in Ready state
```
root@node-0:~# kubectl get nodes
NAME     STATUS   ROLES    AGE   VERSION
node-0   Ready    <none>   10m   v1.21.0
node-1   Ready    <none>   10m   v1.21.0
```

- Install Cilium as CNI
```
make cni-cilium
```

- Check if cilium operator/agents are deployed correctly as Daemonset
```
root@controller-0:~# cilium status
    /¯¯\
 /¯¯\__/¯¯\    Cilium:         OK
 \__/¯¯\__/    Operator:       OK
 /¯¯\__/¯¯\    Hubble:         disabled
 \__/¯¯\__/    ClusterMesh:    disabled
    \__/

DaemonSet         cilium             Desired: 2, Ready: 2/2, Available: 2/2
Deployment        cilium-operator    Desired: 1, Ready: 1/1, Available: 1/1
Containers:       cilium             Running: 2
                  cilium-operator    Running: 1
Cluster Pods:     0/0 managed by Cilium
Image versions    cilium             quay.io/cilium/cilium:v1.10.5: 2
                  cilium-operator    quay.io/cilium/operator-generic:v1.10.5: 1
```
