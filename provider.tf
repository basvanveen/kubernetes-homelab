# Define providers and set versions
terraform {
required_version    = ">= 1.0.2"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.42.0"
    }

  }
}

# Configure the OpenStack provider hosted by DOPDOPcloud
provider "openstack" {
  auth_url    = "http://os.dopdop.nl:35357/v3" # Authentication URL
  domain_name = "default"
  alias       = "dopdop" # An alias
}
