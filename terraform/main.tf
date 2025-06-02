module "vms_network" {

    source = "./modules/ec2_networks"
  
}

module "vpc" {

    source = "./modules/ec2_networks/networks.tf"
    
    
  
}