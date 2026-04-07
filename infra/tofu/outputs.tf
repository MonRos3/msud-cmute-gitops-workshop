output "cluster_id" {
  value = digitalocean_kubernetes_cluster.lab.id
}

output "cluster_endpoint" {
  value = digitalocean_kubernetes_cluster.lab.endpoint
}

output "kubeconfig" {
  value     = digitalocean_kubernetes_cluster.lab.kube_config[0].raw_config
  sensitive = true
}