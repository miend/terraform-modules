dependency "gke_cluster" {
  config_path = "../gke_cluster"
}

inputs {
  cluster_name = "gke_cluster.name"
}
