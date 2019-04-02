
resource "google_storage_bucket" "bucket" {
  name = "cloudfunction-deploy-test1"
}
 
data "archive_file" "http_trigger" {
  type        = "zip"
  output_path = "${path.module}/files/http_trigger.zip"
  source {
    content  = "${file("${path.module}/files/http_trigger.js")}"
    filename = "index.js"
  }
}
 
resource "google_storage_bucket_object" "archive" {
  name   = "http_trigger.zip"
  bucket = "${google_storage_bucket.bucket.name}"
  source = "${path.module}/files/http_trigger.zip"
  depends_on = ["data.archive_file.http_trigger"]
}