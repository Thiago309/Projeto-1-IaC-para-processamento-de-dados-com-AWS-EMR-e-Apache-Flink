output "final_bucket_name" {
  description = "Nome do bucket logs concatenado com o id da conta atual AWS."
  value = aws_s3_bucket.dsa_bucket_logs
}