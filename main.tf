terraform {
  backend "s3" {
    bucket = "dawid-terra"
    key    = "do-it-dynamic/terraform.tfstate"
    region = "eu-central-1"
  }
}

provider "aws" {
  region                   = var.region
  shared_credentials_files = var.credentials
}

module "network" {
  source = "./modules/network"
  name   = var.name
  num    = var.num
}

module "compute" {
  depends_on  = [module.network]
  source      = "./modules/compute"
  subnet_id_1 = module.network.subnet_id_1
  subnet_id_2 = module.network.subnet_id_2
  vpc_id      = module.network.vpc_id
  name        = var.name
  num         = var.num
}
