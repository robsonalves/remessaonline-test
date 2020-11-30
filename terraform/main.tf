provider "aws" {
  region                  = var.aws_region
  profile                 = "vittude"
}
terraform {
  required_version = ">= 0.13"
}

# terraform {
#     required_version = ">= 0.13"

#     # S3 bucket backend configuration store
#     backend "s3" {
#         profile = "vittude"
#         bucket  = "terraform-remote-state-remessaonline"
#         key     = "remessaonline-ecs/hml/terraform.tfstate"
#         region  = "us-east-1"
#         encrypt = true
#         }
# }

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"

  name               = join("-", ["vpc",var.environment])
  cidr               = "100.0.10.0/24"
  azs                = ["us-east-1a", "us-east-1b"]
  private_subnets    = ["100.0.11.0/24", "100.0.12.0/24"]
  public_subnets     = ["100.0.21.0/24", "100.0.22.0/24"]
  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Owner       = "remessaonline"
    Environment = var.environment
  }
}

module "ecs" {
  source = "./modules/ecs-cluster"

  environment          = var.environment
  name                 = var.application

  vpc_id      = module.vpc.vpc_id
  vpc_subnets = [module.vpc.private_subnets]
}

module "alb" { 
  source = "./modules/alb"

  environment           = var.environment
  
  application           = var.application
  vpc_id                = module.vpc.vpc_id
  public_subnet         = module.vpc.public_subnets
  internal              = false

}