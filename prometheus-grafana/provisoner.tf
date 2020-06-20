resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}
resource "aws_instance" "web" {
  ami           = "${data.aws_ami.amazon.id}"
  key_name      = "${aws_key_pair.deployer.key_name}"
  security_groups  = ["${aws_security_group.pro_graf_security.name}"]
  instance_type = "t3.micro"
  provisioner   "remote-exec" {
    connection {
        host        = "${self.public_ip}"
        type        = "ssh"
        user        = "ec2-user"
        private_key = "${file("~/.ssh/id_rsa")}"
    }
    inline = [
      "sudo yum update -y"
    ]
  }
}
