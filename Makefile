# Homelab k8s Bas van Veen
#
help:
	@echo "Usage \"\e[32mmake <target> with Possible options:\""
infra-init:
	terraform init
infra-etcd:
	terraform plan -target openstack_compute_instance_v2.etcd_node
	terraform apply -target openstack_compute_instance_v2.etcd_node
infra-controller:
	terraform plan -target openstack_compute_instance_v2.controller_node
	terraform apply -target openstack_compute_instance_v2.controller_node
infra-worker:
	terraform plan -target openstack_compute_instance_v2.worker_node
	terraform apply -target openstack_compute_instance_v2.worker_node
infra-all:
	terraform plan
	terraform apply
destroy-all:
	terraform destroy
create-ca:
	ansible-playbook -i inventory create-ca.yaml
inventory:
	sh hosts_create.sh
etcd:
	ansible-playbook -i inventory etcd.yaml
etcd-start:
	ansible-playbook -i inventory etcd-start.yaml
etcd-health:
	ansible-playbook -i inventory etcd-health.yaml
controller-full:
	ansible-playbook -i inventory controller-binaries.yaml
	ansible-playbook -i inventory controller-certificates.yaml
	ansible-playbook -i inventory add-ca.yaml
	ansible-playbook -i inventory controller-kube-apiserver.yaml
	ansible-playbook -i inventory controller-kube-controller-manager.yaml
	ansible-playbook -i inventory controller-kube-scheduler.yaml
	ansible-playbook -i inventory controller-kube-admin-user.yaml
	ansible-playbook -i inventory controller-kube-apiserver-clusterrole.yaml
controller-binaries:
	ansible-playbook -i inventory controller-binaries.yaml
controller-certificates:
	ansible-playbook -i inventory controller-certificates.yaml
controller-start:
	ansible-playbook -i inventory controller-start.yaml
kube-apiserver:
	ansible-playbook -i inventory controller-kube-apiserver.yaml
kube-controller-manager:
	ansible-playbook -i inventory controller-kube-controller-manager.yaml
kube-scheduler:
	ansible-playbook -i inventory controller-kube-scheduler.yaml
kube-admin-user:
	ansible-playbook -i inventory controller-kube-admin-user.yaml
kube-apiserver-cluster-role:
	ansible-playbook -i inventory controller-kube-apiserver-clusterrole.yaml
node-full:
	ansible-playbook -i inventory node-binaries.yaml
	ansible-playbook -i inventory node-files.yaml
	ansible-playbook -i inventory node-certs.yaml
	ansible-playbook -i inventory node-config.yaml
	ansible-playbook -i inventory node-kube-admin-user.yaml
	ansible-playbook -i inventory node-enable.yaml
node-binaries:
	ansible-playbook -i inventory node-binaries.yaml
node-files:
	ansible-playbook -i inventory node-files.yaml
node-certs:
	ansible-playbook -i inventory node-certs.yaml
node-config:
	ansible-playbook -i inventory node-config.yaml
node-start:
	ansible-playbook -i inventory node-start.yaml
cni-cilium:
	ansible-playbook -i inventory controller-cilium.yaml
