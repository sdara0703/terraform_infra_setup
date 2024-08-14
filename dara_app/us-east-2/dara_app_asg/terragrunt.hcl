terraform {
    source = "git::https://github.com/sdara0703/terraform_infra_modules//modules/aws-ec2-asg-module?ref=1.0.0"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  launch_template_name_prefix = "my-app"
  image_id                    = "ami-0c11a84584d4e09dd"
  instance_type               = "t2.micro"
  key_name                    = "sample_instance_keys"
  subnet_id                   = "subnet-0fab23acf8f9339cc"
  subnet_ids                  = []
  security_groups             = []
  asg_name                    = "my-app-asg"
  desired_capacity            = 1
  min_size                    = 1
  max_size                    = 1
  scale_up_adjustment         = 1
  scale_down_adjustment       = -1
  tags = {
    Environment = "production"
    Name        = "my-app-instance"
  }
}