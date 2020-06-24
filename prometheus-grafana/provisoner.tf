resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}


resource "aws_instance" "node1" {
  ami           = "${data.aws_ami.centos7.id}"
  key_name      = "${aws_key_pair.deployer.key_name}"
  subnet_id = "${aws_subnet.public1.id}"
  vpc_security_group_ids  = ["${aws_security_group.pro_graf_security.id}"]
  instance_type = "t3.micro"
  provisioner   "remote-exec" {
    connection {
        host        = "${self.public_ip}"
        type        = "ssh"
        user        = "centos"
        private_key = "${file("~/.ssh/id_rsa")}"
    }
    inline = [
      "sudo yum update -y"
    ]
  }
}

# resource "aws_instance" "node2" {
#   ami           = "${data.aws_ami.centos7.id}"
#   key_name      = "${aws_key_pair.deployer.key_name}"
#   security_groups  = ["${aws_security_group.pro_graf_security.name}"]
#   instance_type = "t2.micro"
#   provisioner   "remote-exec" {
#     connection {
#         host        = "${self.public_ip}"
#         type        = "ssh"
#         user        = "centos"
#         private_key = "${file("~/.ssh/id_rsa")}"
#     }
#     inline = [
#       "sudo yum update -y"
#     ]
#   }
# }

# resource "aws_instance" "node3" {
#   ami           = "${data.aws_ami.centos7.id}"
#   key_name      = "${aws_key_pair.deployer.key_name}"
#   security_groups  = ["${aws_security_group.pro_graf_security.name}"]
#   instance_type = "t2.micro"
#   provisioner   "remote-exec" {
#     connection {
#         host        = "${self.public_ip}"
#         type        = "ssh"
#         user        = "centos"
#         private_key = "${file("~/.ssh/id_rsa")}"
#     }
#     inline = [
#       "sudo yum update -y"
#     ]
#   }
# }

# resource "aws_instance" "node4" {
#   ami           = "${data.aws_ami.centos8.id}"
#   key_name      = "${aws_key_pair.deployer.key_name}"
#   security_groups  = ["${aws_security_group.pro_graf_security.name}"]
#   instance_type = "t2.micro"
#   provisioner   "remote-exec" {
#     connection {
#         host        = "${self.public_ip}"
#         type        = "ssh"
#         user        = "centos"
#         private_key = "${file("~/.ssh/id_rsa")}"
#     }
#     inline = [
#       "sudo yum update -y"
#     ]
#   }
# }