terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials_file)
  project     = var.project
  region      = "us-central1"
}

resource "google_storage_bucket" "portfolio_bucket" {
  name                        = "hemanth-portfolio-bucket"  
  location                    = "US"
  force_destroy               = true
  uniform_bucket_level_access = true
  storage_class               = "STANDARD"

  website {
    main_page_suffix = "index.html"
    not_found_page   = "index.html"
  }
}

resource "google_storage_bucket_iam_binding" "public_access" {
  bucket = google_storage_bucket.portfolio_bucket.name
  role   = "roles/storage.objectViewer"
  members = [
    "allUsers",
  ]
}

resource "google_storage_bucket_object" "index" {
  name         = "index.html"
  bucket       = google_storage_bucket.portfolio_bucket.name
  source       = "../portfolio/index.html"
  content_type = "text/html"
}

resource "google_storage_bucket_object" "style" {
  name         = "style.css"
  bucket       = google_storage_bucket.portfolio_bucket.name
  source       = "../portfolio/style.css"
  content_type = "text/css"
}

resource "google_storage_bucket_object" "script" {
  name         = "script.js"
  bucket       = google_storage_bucket.portfolio_bucket.name
  source       = "../portfolio/script.js"
  content_type = "application/javascript"
}

resource "google_storage_bucket_object" "profile" {
  name         = "profile.jpg"
  bucket       = google_storage_bucket.portfolio_bucket.name
  source       = "../portfolio/profile.jpg"
  content_type = "image/jpeg"
}

output "website_url" {
  value = "http://${google_storage_bucket.portfolio_bucket.name}.storage.googleapis.com"
}
