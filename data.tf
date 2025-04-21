data "aws_eks_cluster" "cluster" {
  name = aws_eks_cluster.main.name
}

data "http" "oidc_metadata" {
  url = "${aws_eks_cluster.main.identity[0].oidc[0]["issuer"]}/.well-known/openid-configuration"
}

# Fetch the certificate PEM using tls_certificate
data "tls_certificate" "oidc_cert" {
  url = jsondecode(data.http.oidc_metadata.response_body)["issuer"]
}