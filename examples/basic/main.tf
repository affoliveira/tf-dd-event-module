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
  source = "git@github:affoliveira/tf-dd-event-module.git?ref=v0.4"
  depends_on 		= [local_file.foo]
  datadog_api_key 	= var.datadog_api_key
  datadog_tags 		= var.datadog_tags
  datadog_title   	= var.datadog_title
  datadog_text    	= join(" " , [var.datadog_text, local_file.foo.content])
}
