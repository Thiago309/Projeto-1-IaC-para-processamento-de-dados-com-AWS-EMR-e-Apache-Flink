# Arquivo principal de configuração

provider "aws" {
  region  = var.region
}

# Locals
locals {
  tags = {
    "owner"   = var.owner
    "project" = var.project
    "stage"   = var.environment
  }
}

# Provider


# Módulo do SSH
module "ssh" {
  source      = "./ssh"
  project     = var.project
  environment = var.environment
  name_ssh    = var.name_ssh
}

module "s3_bucket" {
  source = "./s3"
  project = var.project
  region = var.region
}

# Módulo da rede
module "network" {
  source = "./network"
  region = var.region
  tags   = local.tags
}

# Configurações do Flink
locals {
  configurations_json = jsonencode([
    {
      "Classification" : "flink-conf",
      "Properties" : {
        "parallelism.default" : "2",
        "taskmanager.numberOfTaskSlots" : "2",
        "taskmanager.memory.process.size" : "2G",
        "jobmanager.memory.process.size" : "1G",
        "execution.checkpointing.interval" : "180000",
        "execution.checkpointing.mode" : "EXACTLY_ONCE"
      }
    }
  ])
}

# Módulo EMR
module "emr" {
  source                       = "./emr"
  project                      = var.project
  environment                  = var.environment
  tags                         = local.tags
  name_bucket                  = module.s3_bucket.final_bucket_name 
  release_label                = var.emr_release_label
  applications                 = var.applications
  main_instance_type           = var.emr_main_instance_type
  core_instance_type           = var.emr_core_instance_type
  core_instance_count          = var.emr_core_instance_count
  configurations               = local.configurations_json
  key_name                     = module.ssh.deployer_key_name
  vpc_id                       = module.network.vpc_id
  public_subnet                = module.network.public_subnet_2
  additional_security_group_id = module.network.integration_service_security_group_id
  depends_on                   = [module.s3_bucket]
}

# Output
output "emr_main_connection_ssh" {
  value = "ssh -i ${var.name_ssh} hadoop@${module.emr.emr_main_address}"
}