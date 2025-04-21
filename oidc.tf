# resource "aws_iam_openid_connect_provider" "main" {
#   depends_on = [aws_eks_cluster.main]
#   url        = aws_eks_cluster.main.identity[0].oidc[0]["issuer"]
#   client_id_list = [
#     "sts.amazonaws.com",
#   ]
#
#   thumbprint_list = ["cf23df2207d99a74fbe169e3eba035e633b65d94"]
# }