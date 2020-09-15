variable "datadog_api_key" {
  type = string
}

variable "datadog_tags" {
  type = string
  default = null
}

variable "datadog_priority" {
  type = string
  default = "normal"
}

variable "datadog_alert_type" {
  type = string
  default = "info"
}

variable "datadog_text" {
  type = string
}

variable "datadog_title" {
  type = string
}
