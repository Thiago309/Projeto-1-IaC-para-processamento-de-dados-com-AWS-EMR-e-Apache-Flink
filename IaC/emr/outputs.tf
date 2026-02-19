output "emr_main_address" {
  description = "Endereço hadoop do cluster EMR da instância EC2 Master."
  value = aws_emr_cluster.emr_cluster.master_public_dns
}