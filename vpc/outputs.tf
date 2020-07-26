output "network" {
  value = module.vpc_network.network
}

output "public_subnetwork" {
  value = module.vpc_network.public_subnetwork
}

output "public_subnetwork_secondary_range_name" {
  value = module.vpc_network.public_subnetwork_secondary_range_name
}

output "private" {
  value = module.vpc_network.private
}
