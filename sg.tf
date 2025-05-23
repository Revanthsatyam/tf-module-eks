resource "aws_security_group" "cluster" {
  name   = "${local.name_prefix}-sg"
  vpc_id = var.vpc_id
  tags   = merge(local.tags, { Name = "${local.name_prefix}-sg" })

  ingress {
    description = "APP"
    from_port   = var.sg_port
    to_port     = var.sg_port
    protocol    = "tcp"
    cidr_blocks = var.sg_ingress_cidr
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

# resource "aws_security_group_rule" "main" {
#   depends_on        = [aws_eks_cluster.main]
#   type              = "ingress"
#   from_port         = 443
#   to_port           = 443
#   protocol          = "tcp"
#   cidr_blocks       = var.sg_ingress_cidr
#   security_group_id = data.aws_eks_cluster.cluster.vpc_config[0]["cluster_security_group_id"]
# }