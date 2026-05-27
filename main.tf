resource "aws_wafv2_rule_group" "this" {
  count = local.enabled ? 1 : 0

  name        = module.this.id
  description = var.description
  scope       = var.scope
  capacity    = var.capacity

  dynamic "rule" {
    for_each = var.rules
    content {
      name     = rule.value.name
      priority = rule.value.priority

      action {
        dynamic "allow" {
          for_each = rule.value.action == "allow" ? [1] : []
          content {}
        }
        dynamic "block" {
          for_each = rule.value.action == "block" ? [1] : []
          content {}
        }
        dynamic "count" {
          for_each = rule.value.action == "count" ? [1] : []
          content {}
        }
      }

      statement {
        dynamic "ip_set_reference_statement" {
          for_each = lookup(rule.value, "ip_set_arn", null) != null ? [rule.value.ip_set_arn] : []
          content {
            arn = ip_set_reference_statement.value
          }
        }

        dynamic "geo_match_statement" {
          for_each = lookup(rule.value, "country_codes", null) != null ? [rule.value.country_codes] : []
          content {
            country_codes = geo_match_statement.value
          }
        }

        dynamic "size_constraint_statement" {
          for_each = lookup(rule.value, "size_constraint", null) != null ? [rule.value.size_constraint] : []
          content {
            comparison_operator = size_constraint_statement.value.operator
            size                = size_constraint_statement.value.size
            field_to_match {
              body {}
            }
            text_transformation {
              priority = 0
              type     = "NONE"
            }
          }
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = lookup(rule.value, "cloudwatch_metrics_enabled", true)
        metric_name                = rule.value.name
        sampled_requests_enabled   = lookup(rule.value, "sampled_requests_enabled", true)
      }
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = var.cloudwatch_metrics_enabled
    metric_name                = module.this.id
    sampled_requests_enabled   = var.sampled_requests_enabled
  }

  tags = module.this.tags
}
