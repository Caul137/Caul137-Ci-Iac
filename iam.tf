
resource "aws_iam_openid_connect_provider" "oid-git" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = ["cf23df2207d99a74fbe169e3eba035e633b65d94"]

   tags = {
    IAC = true
  }
}

resource "aws_iam_role" "app-runner-role" {
  name = "app-runner-role"

  assume_role_policy = jsonencode({
    Version: "2012-10-17"
    Statement: [{
      Effect: "Allow",
      Principal: {
        Service: "build.apprunner.amazonaws.com"
      },
      Action: "sts:AssumeRole"
    }
   ]
  })
  # managed_policy_arns = [
  #   "arn:aws:iam:aws:policy/AmazonEC2ContainerRegistryReadOnly"
  # ]
}


resource "aws_iam_role" "tf-role"{
  name = "tf-role"

  assume_role_policy = jsonencode({
    Statement = [{
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "token.actions.githubsercontent.com:aud" = "sts.amazon.com"
            "token.actions.githubsercontent.com:sub" = "repo:Caul137/Ci-Iac:ref:refs/heads/main"
          }
        }
        Effect = "Allow"
        Principal = {
          Federated = "arn:aws:iam::4034292808:oidc-provider/token.actions.githubsercontent.com"
        }
    }]
    Version = "2012-10-17"
  })
  tags = {
    IAC = "true"
  }
}




resource "aws_iam_role" "test_role" {
  name = "ecr_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    IAC = "true"
  }
}