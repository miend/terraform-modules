### Required Variables ###

variable "chart_names" {
  description = "A set of names of the Helm charts to be deployed."
  type = set(string)
}

variable "charts_path" {
  description = "The path where Terraform should look for the helm charts."
  type = string
}

### Default Variables ###

variable "namespace" {
  description = "The Kubernetes namespace where Helm charts are deployed."
  type        = string
  default     = "default"
}

variable "whitelist_source_range" {
  description = "The range of addresses allowed to access the services to be deployed, in the form of comma-separated valid CIDR blocks. Defaults to all addresses."
  type        = string
  default     = "0.0.0.0/0"

# Should validate whitelist_source_range CIDR blocks
#  validation {
#    condition     = can(regex("CIDR-checking regex", value))
#    error_message = "The namespace access policy must be valid CIDR blocks separated by commas."
#  }
}

variable "host_prefix" {
  description = "The prefix (e.g. 'staging.') to be prepended to the host name for ingress configurations of deployed services. Defaults to none."
  type        = string
  default     = ""
}

# This should be expanded later to allow a number of hosts in the same ingress
variable "host" {
  type    = string
  default = "example.com"
}
