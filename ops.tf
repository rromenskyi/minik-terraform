resource "kubernetes_stateful_set_v1" "web" {
  metadata {
    name      = "ops"
    namespace = "default" #kubernetes_namespace_v1.demo.metadata[0].name
    labels    = { app = "ops" }
  }

  spec {
    service_name = "default" #kubernetes_service_v1.web_hl.metadata[0].name
    replicas     = 1

    selector { match_labels = { app = "ops" } }

    template {
      metadata { labels = { app = "ops" } }
      spec {
        container {
          name    = "alpine"
          image   = "alpine:3.20"
          command = ["sh", "-c", "tail -f /dev/null"]
          volume_mount {
            name       = "data"
            mount_path = "/data"
          }
        }
        termination_grace_period_seconds = 10
      }
    }

    volume_claim_template {
      metadata { name = "data" }
      spec {
        access_modes = ["ReadWriteOnce"]
        resources { requests = { storage = "1Gi" } }
      }
    }
  }
}