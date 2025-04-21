resource "aws_eks_identity_provider_config" "main" {
  depends_on   = [aws_eks_cluster.main]
  cluster_name = aws_eks_cluster.main.name

  oidc {
    client_id                     = "sts.amazonaws.com"
    identity_provider_config_name = "${local.name_prefix}-cluster-oidc"
    issuer_url                    = aws_eks_cluster.main.identity[0].oidc[0]["issuer"]
  }
}