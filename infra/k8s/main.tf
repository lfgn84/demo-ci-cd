resource "kubernetes_namespace" "demo" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_deployment" "demo_api" {
  metadata {
    name      = "demo-api"
    namespace = var.namespace
    labels = { app = "demo-api" }
  }
  spec {
    replicas = var.replicas
    selector {
      match_labels = { app = "demo-api" }
    }
    template {
      metadata {
        labels = { app = "demo-api" }
      }
      spec {
        container {
          name  = "demo-api"
          image = var.image
          port {
            container_port = 8080
          }
          liveness_probe {
            http_get {
              path = "/health"
              port = 8080
            }
            initial_delay_seconds = 10
            period_seconds        = 10
          }
          readiness_probe {
            http_get {
              path = "/health"
              port = 8080
            }
            initial_delay_seconds = 2
            period_seconds        = 5
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "demo_api" {
  metadata {
    name      = "demo-api"
    namespace = var.namespace
  }
  spec {
    selector = { app = "demo-api" }
    port {
      port        = 8080
      target_port = 8080
    }
    type = "ClusterIP"
  }
}

resource "kubernetes_ingress_v1" "demo_api" {
  metadata {
    name      = "demo-api"
    namespace = var.namespace
    annotations = {
      "nginx.ingress.kubernetes.io/rewrite-target" = "/"
    }
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      http {
        path {
          path     = "/"
          path_type = "Prefix"
          backend {
            service {
              name = kubernetes_service.demo_api.metadata[0].name
              port {
                number = 8080
              }
            }
          }
        }
      }
    }
  }
}
