locals {
  name_prefix = "${var.env}-eks"
  tags        = merge(var.tags, { Name = "tf-module-eks" }, { env = var.env })
}