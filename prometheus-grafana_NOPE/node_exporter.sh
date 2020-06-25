#!/bin/bash
#Documentation: https://www.howtoforge.com/tutorial/how-to-install-prometheus-and-node-exporter-on-centos-8/
#Documentation: https://www.robustperception.io/automatically-monitoring-ec2-instances

##################################################################
#This script performs the following tasks:
#Download and execute the node exporter and push the logs to file
##################################################################
wget -P /tmp https://github.com/prometheus/node_exporter/releases/download/v0.18.1/node_exporter-0.18.1.linux-amd64.tar.gz
tar xvfz /tmp/node_exporter-0.18.1.linux-amd64.tar.gz
sudo mv node_exporter-0.18.1.linux-amd64 /etc/prometheus/node_exporter


sudo bash -c 'cat > /etc/systemd/system/node_exporter.service' <<EOF
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target
[Service]
User=prometheus
ExecStart=/etc/prometheus/node_exporter/node_exporter
[Install]
WantedBy=default.target
EOF


sudo systemctl daemon-reload
sudo systemctl start node_exporter
sudo systemctl enable node_exporter
systemctl status node_exporter
