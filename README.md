# tf-dd-event-module

[![Lint Status](https://github.com/affoliveira/tf-dd-event-module/Lint/badge.svg)](https://github.com/affoliveira/tf-dd-event-module/actions)
[![LICENSE](https://img.shields.io/github/license/tf-dd-event-module)](https://github.com/affoliveira/tf-dd-event-module/blob/master/LICENSE)

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
  source = "./tf-dd-event-module"
  depends_on 		= [local_file.foo]
  datadog_api_key 	= var.datadog_api_key
  datadog_tags 		= var.datadog_tags
  datadog_title   	= var.datadog_title
  datadog_text    	= join(" " , [var.datadog_text, local_file.foo.content])
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
| datadog_api_key | API key used to submit the events to Datadog. | `string` | `` | yes |
| datadog_alert_type | Alert type for the submited event. | `string` | `info` | no |
| datadog_priority | Priority of the event submited . | `string` | `normal` | no |
| datadog_text | Text message of the event submited . | `string` | `Terraform job completed` | no |
| datadog_title | Title of the event submited . | `string` | `Terraform execution` | no |

## Outputs

No outputs provided
