resource "google_compute_address" "ingress" {
  name    = "${var.cluster_name}-ingress-static-ip"
  project = var.project
  region  = var.region
}

resource  "helm_release" "nginx-ingress" {
  name       = "nginx-ingress"
  repository = "https://kubernetes-charts.storage.googleapis.com"
  # This must be version locked before release
  chart      = "nginx-ingress" 

  set {
    name  = "controller.service.loadBalancerIP" 
    value = google_compute_address.ingress.address
  }

  set {
    name  = "controller.service.externalTrafficPolicy"
    value = "Local"
  }
}

# There are no TLS certs configured, and those would definitely be needed for production.
# I would include steps to have Helm install cert-manager, then provision certs similar to:
# https://medium.com/google-cloud/https-with-cert-manager-on-gke-49a70985d99b
