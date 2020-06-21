#   resource "null_resource" "mine" {
#     triggers = {
#         always_run = "${timestamp()}"
#     }    
#   depends_on = ["aws_instance.web"]
#   provisioner   "file" {
#     connection {
#         host        = "${aws_instance.web.public_ip}"
#         type        = "ssh"
#         user        = "ec2-user"
#         private_key = "${file("~/.ssh/id_rsa")}"
#     }
#     source  =  "grafana.repo"
#     destination = "/tmp/grafana.repo"
#   },
#   depends_on = ["aws_instance.web"]
#   provisioner   "remote-exec" {
#     connection {
#         host        = "${aws_instance.web.public_ip}"
#         type        = "ssh"
#         user        = "ec2-user"
#         private_key = "${file("~/.ssh/id_rsa")}"
#     }
#     inline = [
#     # move repo to the correct folder
#      "sudo mv /tmp/grafana.repo /etc/yum.repos.d/grafana.repo",
#      "sudo chown root:root /etc/yum.repos.d/grafana.repo",
#      "yum-config-manager --enable grafana.repo",
#      # install grafana
#      "sudo yum install grafana fontconfig freetype* urw-fonts -y",
#       # install start and enable grafana
#      "sudo systemctl daemon-reload",
#      "sudo systemctl start grafana-server",
#      "sudo systemctl enable grafana-server.service",
#      "sudo systemctl status grafana-server"
#     ]
#   }
# }