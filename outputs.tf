output "rule_group_id" {
  description = "The ID of the WAFv2 Rule Group."
  value       = try(aws_wafv2_rule_group.this[0].id, "")
}

output "rule_group_arn" {
  description = "The ARN of the WAFv2 Rule Group."
  value       = try(aws_wafv2_rule_group.this[0].arn, "")
}

output "rule_group_capacity" {
  description = "The capacity of the rule group."
  value       = try(aws_wafv2_rule_group.this[0].capacity, 0)
}

output "enabled" {
  description = "Whether the module is enabled."
  value       = local.enabled
}
