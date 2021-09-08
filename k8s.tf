# Creating an SSH key pair resource
resource "openstack_compute_keypair_v2" "bas_keypair" {
  provider   = openstack.dopdop # Provider name declared in provider.tf
  name       = "bas" # Name of the SSH key to use for creation
  public_key = file("~/.ssh/id_bas.pub") #
}


resource "openstack_compute_instance_v2" "etcd_node" {
  count       = 3
  name        = "etcd-${count.index}" # Instance name
  provider    = openstack.dopdop  # Provider name
  image_name  = "ubuntu-bionic" # Image name
  flavor_name = "small" # Instance type name
  key_pair    = openstack_compute_keypair_v2.bas_keypair.name
  network {
    name      = "public1" # Adds the network component to reach your instance
  }
}

resource "openstack_compute_instance_v2" "controller_node" {
  count       = 1
  name        = "controller-${count.index}" # Instance name
  provider    = openstack.dopdop  # Provider name
  image_name  = "ubuntu-bionic" # Image name
  flavor_name = "mediumlarge" # Instance type name
  key_pair    = openstack_compute_keypair_v2.bas_keypair.name
  network {
    name      = "public1" # Adds the network component to reach your instance
  }
}

# Creating the instance
resource "openstack_compute_instance_v2" "worker_node" {
  count       = 2
  name        = "node-${count.index}" # Instance name
  provider    = openstack.dopdop  # Provider name
  image_name  = "ubuntu-bionic" # Image name
  flavor_name = "mediumlarge" # Instance type name
  key_pair    = openstack_compute_keypair_v2.bas_keypair.name
  network {
    name      = "public1" # Adds the network component to reach your instance
  }
}

