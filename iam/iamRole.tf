# iam role을 생성한다. 
resource "aws_iam_role" "iam_role" {
  name               = "seung-test-iam-role"
  path               = "/"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# iam role에 적용할 정책을 생성한다. 
resource "aws_iam_role_policy" "policy_s3" {
  name   = "seung-test-s3-policy"
  role   = aws_iam_role.iam_role.id
  policy = <<EOF
{
  "Statement": [
    {
      "Sid": "AllowAppArtifactsReadAccess",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "*"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "profile" {
  name = "seung-test-profile"
  role = aws_iam_role.iam_role.name
}
