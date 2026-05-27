# -----------------------------------------------------------------------------
# Module-Specific Variables
# -----------------------------------------------------------------------------

variable "scope" {
  type        = string
  description = "Scope of the rule group. Valid values: REGIONAL, CLOUDFRONT."
  validation {
    condition     = contains(["REGIONAL", "CLOUDFRONT"], var.scope)
    error_message = "Scope must be REGIONAL or CLOUDFRONT."
  }
}

variable "description" {
  type        = string
  description = "Description of the rule group."
  default     = ""
}

variable "capacity" {
  type        = number
  description = "WCU capacity of the rule group."
  validation {
    condition     = var.capacity > 0 && var.capacity <= 5000
    error_message = "Capacity must be between 1 and 5000."
  }
}

variable "rules" {
  type        = any
  description = "List of rule definitions for the rule group."
  default     = []
}

variable "cloudwatch_metrics_enabled" {
  type        = bool
  description = "Whether CloudWatch metrics are enabled."
  default     = true
}

variable "sampled_requests_enabled" {
  type        = bool
  description = "Whether sampled requests are enabled."
  default     = true
}
