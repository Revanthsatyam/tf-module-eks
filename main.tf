resource "aws_eks_cluster" "main" {
  name = "${local.name_prefix}-cluster"

  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
  }

  role_arn = aws_iam_role.cluster.arn
  version  = var.eks_version

  vpc_config {
    subnet_ids              = var.subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = false
    security_group_ids      = [aws_security_group.cluster.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
  ]

  tags = merge(local.tags, { Name = local.name_prefix })
}

resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${local.name_prefix}-worker-node-group"
  node_role_arn   = aws_iam_role.worker.arn
  subnet_ids      = var.subnet_ids
  capacity_type   = "SPOT"
  instance_types = ["t3.2xlarge"]

  scaling_config {
    desired_size = 3
    max_size     = 10
    min_size     = 3
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
  ]

  tags = merge(
    local.tags,
    {
      Name = local.name_prefix
      "kubernetes.io/cluster/${aws_eks_cluster.main.name}" = "${local.name_prefix}-worker-node"
    }
  )
}