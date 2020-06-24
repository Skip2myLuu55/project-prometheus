  resource "null_resource_node" "mine" {
    triggers = {
        always_run = "${timestamp()}"
    }    
  depends_on = ["aws_instance.node1"]
  provisioner   "remote-exec" {
    connection {
        host        = "${aws_instance.web.public_ip}"
        type        = "ssh"
        user        = "centos"
        private_key = "${file("~/.ssh/id_rsa")}"
    }
    inline = [
    # Installs node exporter
     "sudo wget -P /tmp https://github.com/prometheus/node_exporter/releases/download/v0.18.1/node_exporter-0.18.1.linux-amd64.tar.gz",
     "tar xvfz node_exporter-0.18.1.linux-amd64.tar.gz", 
     "sudo mv node_exporter-0.18.1.linux-amd64 /etc/prometheus/node_exporter" 
    ]
  }
}