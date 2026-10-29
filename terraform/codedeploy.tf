resource "aws_codedeploy_app" "app" {
  name             = "node-express-cicd-app"
  compute_platform = "Server"
}

resource "aws_codedeploy_deployment_group" "app" {
  app_name               = aws_codedeploy_app.app.name
  deployment_group_name  = "node-express-cicd-dg"
  service_role_arn       = aws_iam_role.codedeploy.arn
  deployment_config_name = "CodeDeployDefault.OneAtATime"

  ec2_tag_filter {
    key   = "Role"
    type  = "KEY_AND_VALUE"
    value = "CodeDeployTarget"
  }

  deployment_style {
    deployment_type   = "IN_PLACE"
    deployment_option = "WITHOUT_TRAFFIC_CONTROL"
  }

  depends_on = [
    aws_iam_role_policy_attachment.codedeploy_service
  ]
}