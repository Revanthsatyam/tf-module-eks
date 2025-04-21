output "eks_cluster" {
  value = data.tls_certificate.oidc_cert
}