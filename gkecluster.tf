# https://www.terraform.io/docs/providers/google/r/container_cluster.html
resource "google_container_cluster" "gke-cluster-3" {
  name = "gke-cluster-3"
  network = "default"
  zone = "europe-north1-b"
  initial_node_count = 1

  # gke version, both need to exist and be the same
  #node_version = "1.11.3-gke.18"
  #min_master_version = "1.11.3-gke.18"
  node_config {
    machine_type = "g1-small"
  }
}
# eof