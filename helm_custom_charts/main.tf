resource "helm_release" "custom_charts" {
  for_each         = var.chart_names
  name             = each.value
  chart            = "${var.charts_path}/${each.value}"
  namespace        = var.namespace
  create_namespace = true

  set {
    name  = "ingress.annotations.nginx\\.ingress\\.kubernetes\\.io/whitelist-source-range"
    value = var.whitelist_source_range
  }

  set {
    # Configuration for multiple hosts should be included later
    name  = "ingress.hosts[0]"
    value = "${var.host_prefix}${var.host}"
  }
}

# Deploy DNS records after ingress is configured
#resource "google_dns_managed_zone" "default" {
#name     = "default-zone"
#dns_name = "sub.domain.com."
#}
#
#For each namespace's host_prefix value, if not empty, create a record
#resource "google_dns_record_set" "a" {
#  name         = "host_prefix.${google_dns_managed_zone.default.dns_name}"
#  managed_zone = google_dns_managed_zone.default.name
#  type         = "A"
#  ttl          = 300
#
#  rrdatas = ["${google_compute_address.ingress.address}"]
#}
