data "aws_eks_cluster" "cluster" {
  name = aws_eks_cluster.main.name
}