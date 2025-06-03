module "vpc" {

  source = "./modules/network"

}

module "rds" {
  source = "./modules/rds"

}