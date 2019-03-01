provider "aws" {
    profile = "default"
    region = "eu-west-1"
}

resource "aws_iam_role" "ec2_s3_access_role" {
  name               = "s3-role"
  assume_role_policy = "${file("assumerolepolicy.json")}"
}



resource "aws_iam_policy" "policy" {
  name        = "test-policy"
  description = "A test policy"
  policy      = "${file("policys3bucket.json")}"
}


resource "aws_iam_policy_attachment" "test-attach" {
  name       = "test-attachment"
  roles      = ["${aws_iam_role.ec2_s3_access_role.name}"]
  policy_arn = "${aws_iam_policy.policy.arn}"
}

resource "aws_iam_instance_profile" "test_profile" {
  name  = "test_profile"
  role = "${aws_iam_role.ec2_s3_access_role.name}"
}

# resource "aws_instance" "my-test-instance" {
#   ami             = "${lookup(var.AmiLinux, var.region)}"
#   instance_type   = "t2.micro"
#   iam_instance_profile = "${aws_iam_instance_profile.test_profile.name}"

#   tags {
#     Name = "test-instance"
#   }
# }