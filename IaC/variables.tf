# Variáveis

variable "region" {
  type        = string
  description = "Local de provisionamento dos serviços"
}

variable "project" {
  type        = string
  description = "Nome do projeto"
}    

variable "owner" {
  type        = string
  description = "Mantedor do projeto"
}

variable "environment" {
  type        = string
  description = "Tipo de ambiente"
}

variable "name_ssh" {
    type = string
    description = "Nome da chave SSH"
}

variable "applications" {
  type = list(string)
  description = "Lista de aplicações para instalar no EMR"
}

variable "emr_release_label" {
  type        = string
  description = "Versão do serviço EMR"
}

variable "emr_main_instance_type" {
  type        = string
  description = "Tipo de instancia Master"
}

variable "emr_core_instance_type" {
  type        = string
  description = "Tipo de instancia worker"
}

variable "emr_core_instance_count" {
  type        = string
  description = "Numero de instancias workers em um nó"
}

