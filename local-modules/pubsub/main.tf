resource "google_pubsub_topic" "example" {
  name    = "example-topic"
}

resource "google_pubsub_subscription" "example" {
  name    = "example-subscription"
#  topic   = "${google_pubsub_topic.example.id}"
}