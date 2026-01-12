variable "project" {}

variable "region" {}
# Obtém informações da conta atual automaticamente
data "aws_caller_identity" "current" {}

# BUCKET 1: LOGS DO EMR
resource "aws_s3_bucket" "dsa_bucket_logs" {
  # Usa o ID da conta dinâmico (account_id) obtido pelo data source acima
  bucket = "dsa-${var.project}-logs-${data.aws_caller_identity.current.account_id}" 

  # Permite destruir o bucket mesmo se houver arquivos dentro
  force_destroy = true

  tags = {
    Name        = "Registros de logs do EMR"
    Environment = var.project
  }
}

# BUCKET 2: DADOS
resource "aws_s3_bucket" "dsa_bucket_jobs" {
  bucket = "dsa-p1-jobs-${data.aws_caller_identity.current.account_id}"

  force_destroy = true

  tags = {
    Name        = "Dados"
    Environment = var.project
  }
}

  #Realiza o upload dos dados para o bucket s3
# --- USE ISSO NO LUGAR ---
resource "aws_s3_object" "upload_arquivos" {
  for_each = fileset("${path.module}/job/", "**/*")

  bucket = aws_s3_bucket.dsa_bucket_jobs.id  # O Terraform vai esperar o bucket ser criado aqui
  key    = "job/${each.value}"
  source = "${path.module}/job/${each.value}"
  etag   = filemd5("${path.module}/job/${each.value}")
}