output "enabled" {
  description = "Whether the module is enabled."
  value       = local.enabled
}

output "id" {
  description = "The ID of the rule group."
  value       = try(aws_wafv2_rule_group.default[0].id, "")
}

output "arn" {
  description = "The ARN of the rule group."
  value       = try(aws_wafv2_rule_group.default[0].arn, "")
}

output "capacity" {
  description = "The WCU capacity of the rule group."
  value       = try(aws_wafv2_rule_group.default[0].capacity, 0)
}
