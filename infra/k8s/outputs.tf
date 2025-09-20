output "namespace" {
  value = var.namespace
}

output "service_name" {
  value = kubernetes_service.demo_api.metadata[0].name
}

output "ingress_name" {
  value = kubernetes_ingress_v1.demo_api.metadata[0].name
}
