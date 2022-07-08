variable "environment" {
  description = "An environment qualifier for the resources this module creates, to support a Terraform SDLC."
  type        = string
}

variable "group_config" {
  description = "List of group resources the connector can modify. Each group resource is an object that contains a path and a name property. Both the path and name can contain wildcards."
  type = list(object(
    { path = string, name = string }
  ))
  default = [
    { path = "/sym/", name = "*" }
  ]
  validation {
    condition     = length([for config in var.group_config : 1 if can(regex("^/(.+/)?$", config["path"]))]) == length(var.group_config)
    error_message = "Path prefix must begin and end with a trailing slash."
  }
}

variable "runtime_role_arns" {
  description = "ARNs of the runtime connector roles that are trusted to assume the SSO role."
  type        = list(string)
}

variable "tags" {
  description = "Additional tags to apply to resources"
  type        = map(string)
  default     = {}
}

