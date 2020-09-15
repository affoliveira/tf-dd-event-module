# tf-dd-event-module

A terraform module to create events in Datadog

## Usage example

A basic example using the local_file resource [examples/basic](https://github.com/affoliveira/tf-dd-event-module/tree/master/examples/basic).

```hcl
terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "1.4.0"
    }
  }
}

resource "local_file" "foo" {
  content  = "test"
  filename = "${path.module}/foo.bar"
}



module "datadog" {
  source = "git@github:affoliveira/tf-dd-event-module.git?ref=v0.6"
  depends_on 		= [local_file.foo]
  datadog_api_key 	= var.datadog_api_key
  datadog_tags 		= var.datadog_tags
  datadog_title   	= var.datadog_title
  datadog_text    	= join(" " , [var.datadog_text, local_file.foo.content])
}
```
Example using the kubernetes provider to deploy a pod [examples/k8s](https://github.com/affoliveira/tf-dd-event-module/tree/master/examples/k8s).

```hcl
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
  datadog_text    	= join(" " , [var.datadog_text, kubernetes_pod.nginx.metadata[0].self_link])
}
```

## Other documentation

* [Datadog Events API](https://docs.datadoghq.com/api/v1/events/): Datadog events API reference.
* [Datadog Events](https://docs.datadoghq.com/events/): Datadog Events


## Contributing

Report issues/questions/feature requests on in the [issues](https://github.com/affoliveira/tf-dd-event-module/issues/new) section.


## Authors

Created and Maintained by [Andre Oliveira](https://github.com/affoliveira).

## License

MIT Licensed. See [LICENSE](https://github.com/affoliveira/tf-dd-event-module/tree/master/LICENSE) for full details.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |
| local | >= 1.4 |
| null | >= 2.1 |


## Providers

| Name | Version |
|------|---------|
| local | >= 1.4 |
| null | >= 2.1 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| datadog\_api\_key | API key used to submit the events to Datadog. | `string` |  | yes |
| datadog\_alert\_type | Alert type for the submited event. | `string` | `info` | no |
| datadog\_priority | Priority of the event submited . | `string` | `normal` | no |
| datadog\_text | Text message of the event submited . | `string` | `Terraform job completed` | no |
| datadog\_title | Title of the event submited . | `string` | `Terraform execution` | no |

## Outputs

No outputs provided
