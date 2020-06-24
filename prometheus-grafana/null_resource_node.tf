  resource "null_resource_node" "mine" {
    triggers = {
        always_run = "${timestamp()}"
    }    
  depends_on = ["aws_instance.node1"]
  provisioner   "file" {
    connection {
        host        = "${aws_instance.node.public_ip}"
        type        = "ssh"
        user        = "centos"
        private_key = "${file("~/.ssh/id_rsa")}"
    }
    source  =  "./configuration_files/prometheus_configs/node_exporter.service"
    destination = "/tmp/node_exporter.service"
  },
  depends_on = ["aws_instance.node"]
  provisioner   "remote-exec" {
    connection {
        host        = "${aws_instance.node.public_ip}"
        type        = "ssh"
        user        = "centos"
        private_key = "${file("~/.ssh/id_rsa")}"
    }
    inline = [
      "sudo mv node_exporter-0.18.1.linux-amd64 /etc/prometheus/node_exporter",
      # change ownership to prometheus
      "sudo chown -R prometheus:prometheus /etc/prometheus/node_exporter",
      # move service file to /etc folder and change ownership to root
      "sudo mv /tmp/node_exporter.service /etc/systemd/system/node_exporter.service",
      "sudo chown root:root /etc/systemd/system/node_exporter.service",
      # start and enable services
      "sudo systemctl daemon-reload", 
      "sudo systemctl start node_exporter",
      "sudo systemctl enable node_exporter",
      "sudo systemctl status node_exporter"
    ]
  }
}