terraform {
  required_providers {
    minikube = {
      source  = "scott-the-programmer/minikube"
      version = ">=0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~>2.0"
    }
  }
}
