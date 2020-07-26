dependency "vpc" {
  config_path = "../vpc"
}

inputs {
  network                                = dependency.vpc.outputs.network
  public_subnetwork                      = dependency.vpc.outputs.public_subnetwork
  public_subnetwork_secondary_range_name = depdendency.vpc.outputs.public_subnetwork_secondary_range_name
}
