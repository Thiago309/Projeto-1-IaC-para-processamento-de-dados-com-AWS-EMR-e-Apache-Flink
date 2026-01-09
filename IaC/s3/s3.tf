variable "project" {}

# Obtém informações da conta atual automaticamente
data "aws_caller_identity" "current" {}

# BUCKET 1: LOGS DO EMR
resource "aws_s3_bucket" "dsa_bucket_logs" {
  # Usa o ID da conta dinâmico (account_id) obtido pelo data source acima
  bucket = "dsa-${var.project}-logs-${data.aws_caller_identity.current.account_id}" 

  force_destroy = true

  tags = {
    Name        = "Registros de logs do EMR"
    Environment = var.project
  }
}

# BUCKET 2: DADOS
resource "aws_s3_bucket" "dsa_bucket_jobs" {
  bucket = "dsa-p1-jobs-${data.aws_caller_identity.current.account_id}"

  # Permite destruir o bucket mesmo se houver arquivos dentro
  force_destroy = true

  tags = {
    Name        = "Dados"
    Environment = var.project
  }
}

# UPLOAD DOS DADOS

# Este bloco pega todos os arquivos de uma pasta local jobs e sobe para o S3.
# Isso garante o controle de estado e atualização automática dos dadoss.

resource "aws_s3_object" "upload_scripts" {
  # Ajustei o caminho abaixo para a pasta onde estão meus dados
  # O "**/*" pega arquivos recursivamente (pastas dentro de pastas)
  for_each = fileset("${path.module}/job/", "**/*") 

  bucket = aws_s3_bucket.dsa_bucket_jobs.id
  
  # Mantém a mesma estrutura de pastas no S3
  key    = "job/${each.value}"
  
  # Caminho de origem local
  source = "${path.module}/job/${each.value}"

  # A MÁGICA: Verifica se o arquivo mudou. Se você editar o script,
  # o Terraform sobe a nova versão automaticamente no próximo apply.
  etag = filemd5("${path.module}/job/${each.value}")
}