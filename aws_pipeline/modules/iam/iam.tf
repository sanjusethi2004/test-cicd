data "aws_iam_policy_document" "assume_role" {
   statement {
     actions = ["sts:AssumeRole"]
     principals {
       identifiers = ["ec2.amazonaws.com"]
       type = "Service"
     }
     effect =  "Allow"
     sid = ""
     }
}

data "aws_iam_policy_document" "s3_access_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:*",
      "ec2:*",
      "iam:*",
      "rds:*",
      "elasticloadbalancing:*",
      "autoscaling:*"
    ]
    resources = [
      "*",
    ]
  }
}

resource "aws_iam_role_policy" "s3_access_policy" {
  name = "s3_access_policy"
  role = "${aws_iam_role.access_role.name}"
  policy = "${data.aws_iam_policy_document.s3_access_policy.json}"
}

resource "aws_iam_role" "access_role" {
  name = "${var.iam_name}"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role.json}"
  }

resource "aws_iam_instance_profile" "access_profile" {
  name = "${var.iam_profile_name}"
  role = "${aws_iam_role.access_role.name}"
}