terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "1.13.2"
    }
  }
}

resource "kubernetes_pod" "nginx" {
  metadata {
    name = "nginx-example"
    labels = {
      App = "nginx"
    }
  }

  spec {
    container {
      image = "nginx:1.7.8"
      name  = "example"

      port {
        container_port = 80
      }
    }
  }
}

module "datadog" {
  source = "git@github:affoliveira/tf-dd-event-module.git?ref=v0.6"
  depends_on 		= [kubernetes_pod.nginx]
  datadog_api_key 	= var.datadog_api_key
  datadog_tags 		= var.datadog_tags
  datadog_title   	= var.datadog_title
  #datadog_text    	= join(" " , [var.datadog_text, kubernetes_pod.nginx.name])
}
