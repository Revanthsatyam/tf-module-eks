data "aws_eks_cluster" "cluster" {
  name = aws_eks_cluster.main.name
}

data "external" "thumb" {
  program = ["kubergrunt", "eks", "oidc-thumbprint", "--issuer-url", aws_eks_cluster.main.identity.0.oidc.0["issuer"]]
}