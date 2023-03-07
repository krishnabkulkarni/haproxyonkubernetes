resource "aws_security_group" "master-firewall" {
  name = "master-node-grp"
  description = "EC2 security group for control plane node"
  vpc_id = aws_vpc.prodvpc.id
}

resource "aws_security_group" "worker-firewall" {
  name = "worker-node-group"
  description = "EC2 security group for worker nodes"
  vpc_id = aws_vpc.prodvpc.id
}

resource "aws_security_group_rule" "outbound-master-rule" {
  type = "egress"
  cidr_blocks = [ "0.0.0.0/0" ]
  description = "Full access to outbount traffic"
  from_port = 0
  to_port = 0
  protocol = "-1"
  security_group_id = aws_security_group.master-firewall.id
}

resource "aws_security_group_rule" "outbound-worker-rule" {
  type = "egress"
  cidr_blocks = [ "0.0.0.0/0" ]
  description = "Full access to outbount traffic"
  from_port = 0
  to_port = 0
  protocol = "-1"
  security_group_id = aws_security_group.worker-firewall.id
}

resource "aws_security_group_rule" "ssh" {
  type = "ingress"
  cidr_blocks = [ "0.0.0.0/0" ]
  description = "SSH Ingress from Internet"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  security_group_id = aws_security_group.master-firewall.id
}

resource "aws_security_group_rule" "https" {
  type = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
  description = "HTTPS Ingress from Internet"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  security_group_id = aws_security_group.master-firewall.id
}

resource "aws_security_group_rule" "http" {
  type = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
  description = "HTTP Ingress from Internet"
  from_port = 80
  to_port = 80
  protocol = "tcp" 
  security_group_id = aws_security_group.worker-firewall.id
}

resource "aws_security_group_rule" "kube-api" {
  type = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
  description = "Ports for KubeAPI"
  from_port = 6443
  to_port = 6443
  protocol = "tcp" 
  security_group_id = aws_security_group.master-firewall.id
}

resource "aws_security_group_rule" "master-port" {
  type = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
  description = "Ports for KubeAPI"
  from_port = 8080
  to_port = 8080
  protocol = "tcp" 
  security_group_id = aws_security_group.master-firewall.id
}

resource "aws_security_group_rule" "etcd" {
  type = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
  description = "Ports fro ETCD"
  from_port = 2379
  to_port = 2380
  protocol = "tcp" 
  security_group_id = aws_security_group.master-firewall.id
}

resource "aws_security_group_rule" "master" {
  type = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
  description = "Ports for Kubelet to API"
  from_port = 10250
  to_port = 10250
  protocol = "tcp" 
  security_group_id = aws_security_group.master-firewall.id
}

resource "aws_security_group_rule" "scheduler" {
  type = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
  description = "Ports for Schedular"
  from_port = 10259
  to_port = 10259
  protocol = "tcp" 
  security_group_id = aws_security_group.master-firewall.id
}

resource "aws_security_group_rule" "kube-controller" {
  type = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
  description = "Ports for kube-controller-manager"
  from_port = 10257
  to_port = 10257
  protocol = "tcp" 
  security_group_id = aws_security_group.master-firewall.id
}

resource "aws_security_group_rule" "kubelet-api" {
  type = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
  description = "Ports for worker node kubelet"
  from_port = 10250
  to_port = 10250
  protocol = "tcp" 
  security_group_id = aws_security_group.worker-firewall.id
}

resource "aws_security_group_rule" "node-port-svc" {
  type = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
  description = "Ports for worker node - NodePort services"
  from_port = 30000
  to_port = 32767
  protocol = "tcp" 
  security_group_id = aws_security_group.worker-firewall.id
}

resource "aws_security_group_rule" "ssh-worker" {
  type = "ingress"
  cidr_blocks = [ "0.0.0.0/0" ]
  description = "SSH Ingress from Internet"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  security_group_id = aws_security_group.worker-firewall.id
}