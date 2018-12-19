# https://www.terraform.io/docs/providers/google/r/compute_address.html
resource "google_compute_address" "guessnet-static-address" {
  name = "guessnet-static-address"
  region = "europe-north1"
}

# https://www.terraform.io/docs/providers/google/r/dns_record_set.html
resource "google_dns_record_set" "guessgcloudbcowme-dnsrs" {
  name = "guess.${google_dns_managed_zone.gcloudbcowme-dnszone.dns_name}"
  type = "A"
  ttl  = 300
  managed_zone = "${google_dns_managed_zone.gcloudbcowme-dnszone.name}"
  rrdatas = [
      "${google_compute_address.guessnet-static-address.address}"
      ]
}
# eof