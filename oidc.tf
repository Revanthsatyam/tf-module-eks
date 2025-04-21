data "external" "thumb" {
  program = ["kubergrunt", "eks", "oidc-thumbprint", "--issuer-url", aws_eks_cluster.main.identity.0.oidc.0["issuer"]]
}

resource "aws_iam_openid_connect_provider" "main" {
  depends_on = [aws_eks_cluster.main]
  url        = aws_eks_cluster.main.identity[0].oidc[0]["issuer"]
  client_id_list = ["sts.amazonaws.com"]
  thumbprint_list = [data.external.thumb.result.thumbprint]
}