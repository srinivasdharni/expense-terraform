		module "vpc" {
		  source          = "./modules/vpc"
		  vpc_cidr        = var.vpc_cidr
		  env             = var.env
		  private_subnets = var.private_subnets
		  public_subnets  = var.public_subnets
		  azs             = var.azs
		  account_no             = var.account_no
	 	  default_vpc_id         = var.default_vpc_id
	 	  default_vpc_cidr       = var.default_vpc_cidr
	  	  default_route_table_id = var.default_route_table_id
		}
		
	module "private-lb" {
	  source            = "./modules/alb"
	  alb_sg_allow_cidr = var.vpc_cidr
	  alb_type          = "private"
	  env               = var.env
	  internal          = true
	  subnets           = module.vpc.private_subnets
	  vpc_id            = module.vpc.vpc_id
	  dns_name          = "backend-${var.env}.sddevops18.online"
      zone_id           = "Z0531070279OA6E0HE9DV"
      tg_arn            = module.backend.tg_arn
	}
		
	module "backend" {
	  source = "./modules/app"
	  app_port      = 8080
	  component     = "backend"
	  env           = var.env
	  instance_type = "t3.micro"
	  vpc_cidr      = var.vpc_cidr
	  vpc_id        = module.vpc.vpc_id
	  subnets       = module.vpc.private_subnets
	  bastion_node_cidr = var.bastion_node_cidr
	}
		
	module  "mysql" {
		  source = "./modules/rds"
		  component      = "mysql"
		  env            = var.env
		  subnets        = module.vpc.private_subnets
		  vpc_cidr       = var.vpc_cidr
		  vpc_id         = module.vpc.vpc_id
		  instance_class = var.instance_class
		}