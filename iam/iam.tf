resource "aws_iam_user" "test_user"{
  name = "terraform-test-user"
}

resource "aws_iam_group" "test_group"{
  name = "terraform-test-group2"
}

resource "aws_iam_group_membership" "devops"{
  name = aws_iam_group.test_group.name
  
  users = [
    aws_iam_user.test_user.name
  ]

  group = aws_iam_group.test_group.name
}

resource "aws_iam_user" "gildong_hong" {
  name = "gildong.hong"
}

resource "aws_iam_user_policy" "test-iam-policy" {
  name  = "super-admin"
  user  = aws_iam_user.test_user.name

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "*"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}
