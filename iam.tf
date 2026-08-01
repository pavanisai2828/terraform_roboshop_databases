# custom policy creation
resource "aws_iam_policy" "parameter_store_read" {
  name        = "${local.common_name}-mysql"
  description = "Allows EC2 to read Parameter Store mysql root password value"

  policy = templatefile("${path.module}/iam-policy-json.tftpl",{
    region=local.region
    account_id  = data.aws_caller_identity.current.account_id
    project= var.Project
    Environment= var.Environment
  }
  )
}

resource "aws_iam_role" "mysql_role" {

  name = "${local.common_name}-mysql"
  #trust policy
  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
  tags = merge(
    local.common_tags,
    {
        Name="${local.common_name}-mysql"
    }
  )
}

resource "aws_iam_role_policy_attachment" "parameter_store_read" {
  role       = aws_iam_role.mysql_role.name # attached mysql role
  policy_arn = aws_iam_policy.parameter_store_read.arn
}

resource "aws_iam_instance_profile" "mysql" {
  name = "${local.common_name}-mysql"
  role = aws_iam_role.mysql_role.name #attached mysql_role
}