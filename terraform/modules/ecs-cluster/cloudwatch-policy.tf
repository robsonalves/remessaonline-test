resource "aws_cloudwatch_log_group" "instance" {
  name = join("-", [var.name, var.environment, "cluster"])
}

data "aws_iam_policy_document" "cloudwatch_policy" {
  statement {
    sid = "CloudwatchPutMetricData"

    actions = [
      "cloudwatch:PutMetricData",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    sid = "logging"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams",
    ]

    resources = [
      aws_cloudwatch_log_group.instance.arn,
    ]
  }
}

resource "aws_iam_instance_profile" "instance" {
  name = join("-",[var.name, "instance-profile"])
  role = aws_iam_role.ecs-instance.name
}

resource "aws_iam_role_policy_attachment" "instance_policy" {
  role       = aws_iam_role.ecs-instance.name
  policy_arn = aws_iam_policy.instance_policy.arn
}

resource "aws_iam_policy" "instance_policy" {
  name   = join("-",[var.name,"ecs-instance"]) 
  path   = "/"
  policy = data.aws_iam_policy_document.cloudwatch_policy.json
}
