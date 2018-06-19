resource "aws_iam_user" "kops" {
  name = "kops"
  path = "/kube/"
}

resource "aws_iam_access_key" "kops" {
  user = "${aws_iam_user.kops.name}"
}

resource "aws_iam_group" "kops" {
  name = "kops"
  path = "/kube/"
}

data "aws_iam_policy" "AmazonEC2FullAccess" {
  arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_group_policy_attachment" "kops_ec2" {
  group = "${aws_iam_group.kops.name}"
  policy_arn = "${data.aws_iam_policy.AmazonEC2FullAccess.arn}"
}

data "aws_iam_policy" "AmazonRoute53FullAccess" {
  arn = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
}

resource "aws_iam_group_policy_attachment" "kops_route53" {
  group = "${aws_iam_group.kops.name}"
  policy_arn = "${data.aws_iam_policy.AmazonRoute53FullAccess.arn}"
}

data "aws_iam_policy" "AmazonS3FullAccess" {
  arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_group_policy_attachment" "kops_s3" {
  group = "${aws_iam_group.kops.name}"
  policy_arn = "${data.aws_iam_policy.AmazonS3FullAccess.arn}"
}

data "aws_iam_policy" "IAMFullAccess" {
  arn = "arn:aws:iam::aws:policy/IAMFullAccess"
}

resource "aws_iam_group_policy_attachment" "kops_iam" {
  group = "${aws_iam_group.kops.name}"
  policy_arn = "${data.aws_iam_policy.IAMFullAccess.arn}"
}

data "aws_iam_policy" "AmazonVPCFullAccess" {
  arn = "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
}

resource "aws_iam_group_policy_attachment" "kops_vpc" {
  group = "${aws_iam_group.kops.name}"
  policy_arn = "${data.aws_iam_policy.AmazonVPCFullAccess.arn}"
}

resource "aws_iam_user_group_membership" "kops" {
  user = "${aws_iam_user.kops.name}"

  groups = [
    "${aws_iam_group.kops.name}"
  ]
}

