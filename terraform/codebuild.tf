resource "aws_cloudwatch_log_group" "codebuild" {
  name              = "/aws/codebuild/node-express-cicd"
  retention_in_days = 7
}

resource "aws_codebuild_project" "app" {
  name          = "node-express-cicd-build"
  description   = "Build the Node.js CI/CD demo bundle"
  service_role  = aws_iam_role.codebuild.arn
  build_timeout = 15

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yml"
  }

  logs_config {
    cloudwatch_logs {
      group_name = aws_cloudwatch_log_group.codebuild.name
    }
  }
}