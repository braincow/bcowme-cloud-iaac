resource "google_sql_database_instance" "fubar-instance" {
  name = "fubar-instance"
  database_version = "MYSQL_5_7"
  region = "europe-north1"
  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_database" "fubar" {
  name = "fubar-db"
  instance = "${google_sql_database_instance.fubar-instance.name}"
  charset = "utf8mb4"
  collation = "utf8mb4_general_ci"
}

resource "google_sql_user" "fubar-user" {
  name = "bcow"
  host = "%"
  instance = "${google_sql_database_instance.fubar-instance.name}"
  password = "${file("./creds/fubar-db-user.password")}"
}

resource "google_dns_record_set" "fubardbgcloudbcowme-dnsrs" {
  name = "fubar-db.${google_dns_managed_zone.gcloudbcowme-dnszone.dns_name}"
  type = "A"
  ttl  = 300
  managed_zone = "${google_dns_managed_zone.gcloudbcowme-dnszone.name}"
  rrdatas = [
        "${google_sql_database_instance.fubar-instance.ip_address.0.ip_address}"
      ]
}

# eof