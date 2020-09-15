resource "null_resource" "datadog" {
	triggers = {
		timestamp = timestamp()
	}
	provisioner "local-exec" {
		command = <<EOT
curl -X POST https://api.datadoghq.com/api/v1/events?api_key=${var.datadog_api_key} -H "Content-Type: application/json" -d @- << EOF 
{
"alert_type": "${var.datadog_alert_type}",
"priority": "${var.datadog_priority}",
"source_type_name": "terraform",
"tags": "${var.datadog_tags}",
"text": "${var.datadog_text}",
"title": "${var.datadog_title}"
}
EOF
EOT
	}
}
