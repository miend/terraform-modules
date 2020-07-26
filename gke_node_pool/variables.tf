### Required Variables ###

variable "project" {
  description = "The project ID where all resources will be launched."
  type        = string
}

variable "location" {
  description = "The location (region or zone) of the GKE cluster."
  type        = string
}

variable "region" {
  description = "The region for the network. If the cluster is regional, this must be the same region. Otherwise, it should be the region of the zone."
  type        = string
}

### Required Inputs From Other Modules ###

variable "private" {
  description = "Output of vpc_network.private from vpc module"
  type = string
}

variable "cluster_name" {
  description = "Output of gke_cluster.cluster_name from gke_cluster module"
  type = string
}

### Default Variables ###

variable "initial_node_count" {
  description = "The number of nodes the node pool should start with."
  type        = number
  default     = 10
}

variable "min_node_count" {
  description = "The minimum number of nodes in a pool, for auto-scaling purposes."
  type        = number
  default     = 10
}

variable "max_node_count" {
  description = "The maximum number of nodes in a pool, for auto-scaling purposes."
  type        = number
  default     = 30
}

variable "image_type" {
  description = "The image type a node pool should use. Defaults to Container-Optimized Linux."
  type        = string
  default     = "COS"
}

variable "machine_type" {
  description = "The type of instance that a node pool should use."
  type        = string
  default     = "n1-standard-1"
}

variable "cluster_service_account_name" {
  description = "The name of the custom service account used for the GKE cluster. This parameter is limited to a maximum of 28 characters."
  type        = string
  default     = "terraform-gke-sa"
}

variable "cluster_service_account_description" {
  description = "A description of the custom service account used for the GKE cluster."
  type        = string
  default     = "GKE Cluster Service Account managed by Terraform"
}

variable "gcr_artifacts_location" {
  description = "The location to be supplied for GCR's configuration. Options can be viewed with `gcloud beta artifacts locations list`"
  type        = string
  default     = "us"
}
