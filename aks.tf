#minikube delete --all --purge
#minikube start --vm=true --driver=hyperkit --download-only


provider "minikube" {
  #kubernetes_version = "v1.30.0"
}


provider "kubernetes" {
  host = minikube_cluster.qemu2.host

  client_certificate     = minikube_cluster.qemu2.client_certificate
  client_key             = minikube_cluster.qemu2.client_key
  cluster_ca_certificate = minikube_cluster.qemu2.cluster_ca_certificate
}


resource "minikube_cluster" "qemu2" {
  vm           = true
  driver       = "docker"
  cluster_name = "tf-local"
  nodes        = 1
  cpus         = 4
  memory       = 4096
  cni          = "bridge"
  network      = "builtin"
  #container_runtime = "containerd"
  container_runtime = "docker"
  base_image        = "gcr.io/k8s-minikube/kicbase:v0.0.48"
  iso_url = [
    "https://storage.googleapis.com/minikube/iso/minikube-v1.37.0-amd64.iso",
    "https://github.com/kubernetes/minikube/releases/download/v1.37.0/minikube-v1.37.0-amd64.iso",
    "https://kubernetes.oss-cn-hangzhou.aliyuncs.com/minikube/iso/minikube-v1.37.0-amd64.iso",
  ]

  addons = [
    "dashboard",
    "default-storageclass",
    "ingress",
    "storage-provisioner"
  ]
  lifecycle {
    ignore_changes = [
      iso_url,
    ]
  }
}
