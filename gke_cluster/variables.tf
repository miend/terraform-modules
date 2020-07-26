### Required Variables ###

variable "project" {
  description = "The project ID where all resources will be launched."
  type        = string
}

variable "location" {
  description = "The location (region or zone) of the GKE cluster."
  type        = string
}

### Required Inputs From Other Modules ###

variable "network" {
  description = "Output of vpc_network.network from vpc module."
  type        = string
}

variable "public_subnetwork" {
  description = "Output of vpc_network.public_subnetwork from vpc module."
  type        = string
}

variable "public_subnetwork_secondary_range_name" {
  description = "Output of vpc_network.public_subnetwork_secondary_range_name from vpc module."
  type        = string
}

### Default Variables ###

variable "cluster_name" {
  description = "The name of the Kubernetes cluster."
  type        = string
  default     = "default"
}

variable "master_ipv4_cidr_block" {
  description = "The IP range in CIDR notation (size must be /28) to use for the hosted master network. This range will be used for assigning internal IP addresses to the master or set of masters, as well as the ILB VIP. This range must not overlap with any other ranges in use within the cluster's network."
  type        = string
  default     = "10.5.0.0/28"
}

variable "disable_public_endpoint" {
  description =  "Whether or not to expose the Kubernetes master API endpoint publicly. Set to 'true' for more security with e.g. Cloud VPN"
  default     = "false"
}

variable "k8s_master_authorized_networks" {
  description = "The CIDR block and display name of the networks authorized to access the Kubernetes master API."
  default     = { 
    cidr_block = "0.0.0.0/0" 
    display_name = "default-open"
  }
}

variable "enable_vertical_pod_autoscaling" {
  description = "Enable vertical pod autoscaling"
  type        = string
  default     = true
}
