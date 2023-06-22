terraform {
  source = "module"
}

inputs = {

aws_region = "us-east-1"
aws_account_id = "925307459448"

cognito_props_map = {
  apigateway-scs = {
  cognito_user   = "test-endpoint"
  email           = "no-reply@hashicorp.com"
  resource_server_identifier           = "apigateway-test"
  resource_server_scope_name = "all"
  app_client_explicit_auth_flows = ["ALLOW_ADMIN_USER_PASSWORD_AUTH", "ALLOW_CUSTOM_AUTH", "ALLOW_USER_PASSWORD_AUTH", "ALLOW_USER_SRP_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]
  app_client_callback_urls        = ["https://96mdtvaqk8.execute-api.us-east-1.amazonaws.com/undefined", "https://96mdtvaqk8.execute-api.us-east-1.amazonaws.com"]
 # app_client_logout_urls = ["https://96mdtvaqk8.execute-api.us-east-1.amazonaws.com/undefined"]
  app_client_allowed_oauth_flows = ["client_credentials"]
  app_client_allowed_oauth_scopes = ["apigateway-scs/all"]
  },
  apigateway-scs1 = {
  cognito_user = "test1-endpoint"
  email           = "supun@hashicorp.com"
  resource_server_identifier           = "https://ab9ss0vky2.execute-api.us-east-1.amazonaws.com/undefined"
  resource_server_scope_name = "all"
  app_client_explicit_auth_flows = ["ALLOW_ADMIN_USER_PASSWORD_AUTH", "ALLOW_CUSTOM_AUTH", "ALLOW_USER_PASSWORD_AUTH", "ALLOW_USER_SRP_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]
  app_client_callback_urls        = ["https://96mdtvaqk8.execute-api.us-east-1.amazonaws.com/undefined"]
  app_client_allowed_oauth_flows = ["implicit"]
  app_client_allowed_oauth_scopes = ["openid"]
 #app_client_allowed_oauth_scopes = ["https://96mdtvaqk8.execute-api.us-east-1.amazonaws.com/undefined/all"]
  }
}

}

