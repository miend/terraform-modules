module "gke_cluster" {
  source = "github.com/gruntwork-io/terraform-google-gke.git//modules/gke-cluster?ref=v0.4.3"

  name = var.cluster_name

  project  = var.project
  location = var.location
  network  = var.network

  # Public subnetwork instances can communicate over the internet with a Cloud NAT
  subnetwork = var.public_subnetwork

  master_ipv4_cidr_block = var.master_ipv4_cidr_block

  # Makes the cluster private. Nodes have no external IP and rely on NAT configured
  # by gruntwork's vpc-network module
  enable_private_nodes = "true"

  disable_public_endpoint = var.disable_public_endpoint

  # The networks that can access the master. This should either be restricted or unset
  # (disabled public endpoint), but it's fine for testing.
  master_authorized_networks_config = [
    {
      cidr_blocks = [
        {
          cidr_block   = var.k8s_master_authorized_networks["cidr_block"]
          display_name = var.k8s_master_authorized_networks["display_name"]
        },
      ]
    },
  ]

  cluster_secondary_range_name = var.public_subnetwork_secondary_range_name

  enable_vertical_pod_autoscaling = var.enable_vertical_pod_autoscaling
}

resource "null_resource" "cluster_authentication" {
  # Currently the convenient way to get cluster credentials. This should be revisited.
  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials --region ${var.region} ${var.cluster_name}"
  }
}
