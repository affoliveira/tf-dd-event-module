resource "null_resource" "datadog" {
	provisioner "local-exec" {
		command = <<EOT
curl -X POST https://api.datadoghq.com/api/v1/events?api_key=${var.datadog_api_key} 
-H "Content-Type: application/json" 
-d @- << EOF 
{
"alert_type": "info",
"priority": "normal",
"source_type_name": "terraform",
"text": "${var.datadog_text}",
"title": "${var.datadog_title}"
}
EOF
EOT
	}
}

