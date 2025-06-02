module "vpc" {

    source = "./modules/vpc"
  
}

module "rds" {
    source = "./modules/rds"
  
}