output "eks_cluster" {
  value = data.aws_eks_cluster.cluster.vpc_config[0]
}