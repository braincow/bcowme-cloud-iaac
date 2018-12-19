# https://github.com/tiramiseb/terraform-provider-gandi/
resource "gandi_zone" "bcow_me" {
    name = "bcow.me Terraform managed zone"
}

resource "gandi_zonerecord" "gcloud-ns" {
    zone = "${gandi_zone.bcow_me.id}"
    name = "gcloud"
    type = "NS"
    ttl = 300
    values = [ "${google_dns_managed_zone.gcloudbcowme-dnszone.name_servers}" ]
}

resource "gandi_domainattachment" "bcow_me" {
    domain = "bcow.me"
    zone = "${gandi_zone.bcow_me.id}"
}

# eof