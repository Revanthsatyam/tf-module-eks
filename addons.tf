resource "aws_eks_addon" "coredns" {
  cluster_name                = aws_eks_cluster.main.name
  addon_name                  = "coredns"
  addon_version               = "v1.11.3-eksbuild.1"
  resolve_conflicts_on_update = "PRESERVE"
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name                = aws_eks_cluster.main.name
  addon_name                  = "kube-proxy"
  addon_version               = "v1.31.2-eksbuild.3"
  resolve_conflicts_on_update = "PRESERVE"
}

resource "aws_eks_addon" "amazon_vpc_cni" {
  cluster_name                = aws_eks_cluster.main.name
  addon_name                  = "vpc-cni"
  addon_version               = "v1.19.0-eksbuild.1"
  resolve_conflicts_on_update = "PRESERVE"
}

resource "aws_eks_addon" "metrics_server" {
  cluster_name                = aws_eks_cluster.main.name
  addon_name                  = "metrics-server"
  addon_version               = "v0.7.2-eksbuild.3"
  resolve_conflicts_on_update = "PRESERVE"
}

# resource "aws_eks_addon" "amazon_ebs_csi_driver" {
#   cluster_name                = aws_eks_cluster.main.name
#   addon_name                  = "ebs-csi-driver"
#   addon_version               = "v1.41.0-eksbuild.1"
#   resolve_conflicts_on_update = "PRESERVE"
# }