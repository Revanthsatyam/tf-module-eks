data "http" "oidc_metadata" {
  url = "${aws_eks_cluster.main.identity[0].oidc[0]["issuer"]}/.well-known/openid-configuration"
}

data "tls_certificate" "oidc_cert" {
  url = jsondecode(data.http.oidc_metadata.body)["issuer"] # URL for certificate
}

resource "aws_iam_openid_connect_provider" "main" {
  depends_on      = [aws_eks_cluster.main]
  url             = aws_eks_cluster.main.identity[0].oidc[0]["issuer"]
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.oidc_cert.certificates[0].thumbprint]
}