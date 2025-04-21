data "http" "oidc_metadata" {
  url = "${aws_eks_cluster.main.identity[0].oidc[0]["issuer"]}/.well-known/openid-configuration"
}

# Fetch the certificate PEM using tls_certificate
data "tls_certificate" "oidc_cert" {
  url = jsondecode(data.http.oidc_metadata.response_body)["issuer"]
}

# Generate the thumbprint from the certificate
locals {
  thumbprint = chomp(
    base64encode(
      sha1(
        data.tls_certificate.oidc_cert.certificates[0].certificate_pem
      )
    )
  )
}

resource "aws_iam_openid_connect_provider" "main" {
  depends_on      = [aws_eks_cluster.main]
  url             = aws_eks_cluster.main.identity[0].oidc[0]["issuer"]
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [local.thumbprint]
}