resource "google_sql_database_instance" "master-instance" {
  name = "master-instance"

  settings {
    tier = "D0"
  }
}

resource "google_sql_database" "fubar" {
  name      = "fubar-db"
  instance  = "${google_sql_database_instance.master-instance.name}"
  charset   = "utf8mb4"
  collation = "utf8mb4_general_ci"
}

# eof