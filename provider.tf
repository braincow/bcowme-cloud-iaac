provider "google" {
  # serviceaccount.json created via gcloud / web console
  credentials = "${file("./creds/serviceaccount.json")}"
  project = "linear-freehold-196017"
  region = "europe-north1"
}

provider "gandi" {
  key = "${file("./creds/gandi.key")}"
}

# eof