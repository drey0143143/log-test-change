resource "aws_iam_role" "orchestration_role" {
  name = local.orchestration_role_names1

  assume_role_policy = <<EOF
{
  "Version":"2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Action": "sts:AssumeRoleWithWebIdentity",
    "Principal":{
      "Federated": "arn:aws:iam::${var.aws_oidc_account}:oidc-provider/token.actions.githubusercontent.com"
    },
    "Condition":{
      "StringEquals":{
        "token.actions.githubusercontent.com:sub": [
          "repo:ipipeline/${var.github_repo_name}:ref:refs/heads/test-dev",
          "repo:ipipeline/${var.github_repo_name}:pull_request"
        ]
      }
    }
  }
}
EOF
  tags               = var.tags
}


variable "github_repo_name" {
  description = "The name of the repository to use with assume role policy trust condition"
  type        = list
}


