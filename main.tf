variable "app_id" {
#  type    = "string"
  default = ""
}

provider "aws" {
  region = "us-east-1"
}

data "aws_cognito_user_pools" "pool" {
  name = "testpool"
}

resource "aws_cognito_user" "example" {
  user_pool_id = data.aws_cognito_user_pools.pool.ids[0]
  username     = "example1"
  password = "1qaz@WSX"

   attributes = {
     "email"          = "no-reply@hashicorp.com"
     "email_verified" = true
   }
}

resource "aws_cognito_resource_server" "resource" {
  identifier = "apigateway-scs"
  name       = "apigateway-scs"

  scope {
    scope_name        = "all"
    scope_description = "all"
  }

  user_pool_id = data.aws_cognito_user_pools.pool.ids[0]
}

resource "aws_cognito_user_pool_client" "example" {
  name         = "example-user-pool-client"
  user_pool_id = data.aws_cognito_user_pools.pool.ids[0]
  explicit_auth_flows = ["ALLOW_ADMIN_USER_PASSWORD_AUTH","ALLOW_CUSTOM_AUTH","ALLOW_USER_PASSWORD_AUTH","ALLOW_USER_SRP_AUTH","ALLOW_REFRESH_TOKEN_AUTH"]
  supported_identity_providers = ["COGNITO"]
  allowed_oauth_flows = ["client_credentials"]
  generate_secret = "true"
  prevent_user_existence_errors = "ENABLED"
  allowed_oauth_scopes = [aws_cognito_resource_server.resource.scope_identifiers[0]]
  callback_urls = ["https://4ltus1mx29.execute-api.us-east-1.amazonaws.com/undefined"]
  logout_urls = [var.app_id == "" ? null : var.app_id]
}

