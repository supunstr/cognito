provider "aws" {
  region              = var.aws_region
  allowed_account_ids = [var.aws_account_id]
}

data "aws_cognito_user_pools" "pool" {
  name = "testpool"
}

resource "random_password" "user_password" {
  count = length(var.cognito_props_map)
  length           = 8
  special          = true
}

resource "aws_ssm_parameter" "example" {
  count = length(var.cognito_props_map)
  name        = "/example/dev/cognito_user_password/${element(values(var.cognito_props_map), count.index).cognito_user}"
  description = "Cognito user password"
  type        = "SecureString"
  value       = random_password.user_password[count.index].result
}

resource "aws_cognito_user" "this" {
  count = length(var.cognito_props_map)

  user_pool_id = data.aws_cognito_user_pools.pool.ids[0]
  username     = element(values(var.cognito_props_map), count.index).cognito_user
  password     = random_password.user_password[count.index].result

  attributes = {
    "email"          = element(values(var.cognito_props_map), count.index).email
  #  "name"           = each.key
    "email_verified" = true
  }
}


/*
resource "aws_cognito_user" "this" {
  for_each = var.cognito_props_map
  
  user_pool_id = data.aws_cognito_user_pools.pool.ids[0]
  username     = each.value["cognito_user"]
  #password     = "1qazXWS#"
  #password = random_password.user_password[length(var.cognito_props_map).index].result
  attributes = {
    "email"          = each.value["email"]
    "name"           = each.key
    "email_verified" = true
  }
}
*/

resource "aws_cognito_resource_server" "resource" {
  for_each   = var.cognito_props_map
  identifier = each.value["resource_server_identifier"]
  name       = each.key

  scope {
    scope_name        = each.value["resource_server_scope_name"]
    scope_description = each.value["resource_server_scope_name"]
  }

  user_pool_id = data.aws_cognito_user_pools.pool.ids[0]
}


resource "aws_cognito_user_pool_client" "example" {
  for_each = var.cognito_props_map

  name                          = each.key
  user_pool_id                  = data.aws_cognito_user_pools.pool.ids[0]
  explicit_auth_flows           = each.value["app_client_explicit_auth_flows"]
  supported_identity_providers  = ["COGNITO"]
  allowed_oauth_flows           = each.value["app_client_allowed_oauth_flows"]
  generate_secret               = "true"
  prevent_user_existence_errors = "ENABLED"
  allowed_oauth_scopes          = each.value["app_client_allowed_oauth_scopes"]
  callback_urls                 = each.value["app_client_callback_urls"]
  logout_urls                   = each.value["app_client_logout_urls"]

}
