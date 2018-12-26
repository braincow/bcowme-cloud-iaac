resource "google_sql_database_instance" "master-instance" {
  name = "master-instance"
  database_version = "MYSQL_5_7"
  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_database" "fubar" {
  name      = "fubar-db"
  instance  = "${google_sql_database_instance.master-instance.name}"
  charset   = "utf8mb4"
  collation = "utf8mb4_general_ci"
}

resource "google_dns_record_set" "fubardbgcloudbcowme-dnsrs" {
  name = "fubar-db.${google_dns_managed_zone.gcloudbcowme-dnszone.dns_name}"
  type = "A"
  ttl  = 300
  managed_zone = "${google_dns_managed_zone.gcloudbcowme-dnszone.name}"
  rrdatas = [
        "${google_sql_database_instance.master-instance.ip_address.0.ip_address}"
      ]
}

# eof