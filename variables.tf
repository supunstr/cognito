variable "aws_region" {
  #  type    = "string"
}

variable "aws_account_id" {
  #  type    = "string"
}

variable "cognito_props_map" {
  type = map(object({
    cognito_user                    = string
    email                           = string
    resource_server_identifier      = string
    resource_server_scope_name      = string
    app_client_explicit_auth_flows  = list(string)
    app_client_callback_urls        = list(string)
    app_client_logout_urls          = optional(list(string))
    app_client_allowed_oauth_flows  = list(string)
    app_client_allowed_oauth_scopes = list(string)
  }))
}
