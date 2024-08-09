terraform {
    source = "git::https://github.com/sdara0703/terraform_infra_modules//modules/aws-ec2-instance-module?ref=1.0.2"
}


inputs = {
  ami_id         = "ami-0c11a84584d4e09dd" # Replace with your AMI ID
  instance_type  = "t2.micro"     # Replace with your desired instance type
}