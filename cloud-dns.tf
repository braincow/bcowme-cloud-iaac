# https://www.terraform.io/docs/providers/google/r/dns_managed_zone.html
# (remember to manually update gandi zone for downstream NS SOA)
resource "google_dns_managed_zone" "gcloudbcowme-dnszone" {
  name = "gcloudbcowme-dns"
  dns_name = "gcloud.bcow.me."
}

# https://www.terraform.io/docs/providers/google/r/dns_record_set.html
resource "google_dns_record_set" "localhostgcloudbcowme-dnsrs" {
  name = "localhost.${google_dns_managed_zone.gcloudbcowme-dnszone.dns_name}"
  type = "A"
  ttl  = 300
  managed_zone = "${google_dns_managed_zone.gcloudbcowme-dnszone.name}"
  rrdatas = [
      "127.0.0.1"
      ]
}

# eof