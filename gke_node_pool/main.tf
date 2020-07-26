resource "google_container_node_pool" "node_pool" {
  provider = google-beta

  name     = "${var.cluster_name}-node-pool"
  project  = var.project
  location = var.location
  cluster  = var.cluster_name

  initial_node_count = var.initial_node_count

  autoscaling {
    min_node_count = var.min_node_count
    max_node_count = var.max_node_count
  }

  management {
    auto_repair  = "true"
    auto_upgrade = "true"
  }

  node_config {
    image_type   = var.image_type
    machine_type = var.machine_type

    tags = [ var.private,
      "${var.project}-private",
    ]

    service_account = module.gke_service_account.email

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_only",
    ]
  }

  lifecycle {
    ignore_changes = [initial_node_count]
  }

  timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }
}

# Consider splitting service account and GCR off into their own modules. node-pool is the only one
# that needs them for now.
module "gke_service_account" {
  source = "github.com/gruntwork-io/terraform-google-gke.git//modules/gke-service-account?ref=v0.4.3"
  name        = var.cluster_service_account_name
  project     = var.project
  description = var.cluster_service_account_description
}

# Needed to ensure the bucket backing GCR exists. google_storage_bucket_iam_member may fail
# without it.
resource "google_container_registry" "registry" {
  project  = var.project
  location = var.gcr_artifacts_location
}

resource "google_storage_bucket_iam_member" "member" {
  bucket = google_container_registry.registry.id
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${module.gke_service_account.email}"
}
