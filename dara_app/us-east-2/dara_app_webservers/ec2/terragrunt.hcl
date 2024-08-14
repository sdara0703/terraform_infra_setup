terraform {
    source = "git::https://github.com/sdara0703/terraform_infra_modules//modules/aws-ec2-instance-module?ref=1.0.0"
}


include "root" {
  path = find_in_parent_folders()
}

inputs = {
  ami_id         = "ami-0c11a84584d4e09dd" # Replace with your AMI ID
  instance_type  = "t2.micro"     # Replace with your desired instance type

  tags  = {
    owner       = "sdara0703"
    description = "This EC2 is for demo only"
  }
 # script_output = run_cmd("./myscript.sh")
}




# after_hook "run_shell_script_after_apply" {
#   commands = ["apply"]
#   execute  = ["./myscript.sh"]
# }