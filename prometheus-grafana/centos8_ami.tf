#################################
#Find Centos 8 AMI in any region:
#################################

# data "aws_ami" "centos8" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["CentOS 8.2.2004 x86_64*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   owners = ["125523088429"] # Canonical
# }


# output "CENTOS8_AMI_ID" {
#     value = "${data.aws_ami.centos8.id}"
# }
