module "pubsub" {
  source     = "../../"
  topic      = "${var.topic_name}"
  project_id = "${var.project_id}"

  pull_subscriptions = [
    {
      name                 = "pull"
      ack_deadline_seconds = 20
    },
  ]

  push_subscriptions = [
    {
      name                 = "push"
      ack_deadline_seconds = 20
      push_endpoint        = "https://${var.project_id}.appspot.com"
      x-goog-version       = "v1beta1"
    },
  ]
}