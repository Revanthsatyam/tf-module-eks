locals {
  name_prefix = "${var.env}-eks"
  tags        = merge(var.tags, { Name = "tf-module-eks" }, { env = var.env })
}

locals {
  thumbprint = element(data.tls_certificate.oidc_cert.certificates, length(data.tls_certificate.oidc_cert.certificates) - 1).sha1_fingerprint
}