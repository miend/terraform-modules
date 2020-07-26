### Required Variables ###

variable "project" {
  description = "The project ID where all resources will be launched."
  type        = string
}

variable "region" {
  description = "The region for the network. If the cluster is regional, this must be the same region. Otherwise, it should be the region of the zone."
  type        = string
}

### Required Inputs From Other Modules ###

variable "cluster_name" {
  description = "Output of gke_cluster.cluster_name from gke_cluster module"
  type = string
}
