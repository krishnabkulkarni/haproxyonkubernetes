resource "aws_instance" "mvm" {
   depends_on = [
     aws_ebs_volume.master-vm-ebs,
     aws_security_group.master-firewall,
     aws_subnet.prodsub2
   ]
   ami = var.ec2_image
   instance_type = var.ec2_type
   key_name = data.aws_key_pair.us-east-1-key.key_name
   availability_zone = var.master_az
   vpc_security_group_ids = [aws_security_group.master-firewall.id]
   subnet_id = aws_subnet.prodsub2.id

   tags = {
      Name = "mastervm"
      env = "prod"
   }
}

resource "aws_instance" "wvm" {
   depends_on = [
     aws_ebs_volume.worker-ebs1,
     aws_ebs_volume.worker-ebs2,
     aws_security_group.worker-firewall,
     aws_subnet.prodsub1
   ]
   ami = var.ec2_image
   instance_type = var.ec2_type
   key_name = data.aws_key_pair.us-east-1-key.key_name
   availability_zone = var.worker_az
   vpc_security_group_ids = [aws_security_group.worker-firewall.id]
   subnet_id = aws_subnet.prodsub1.id
   count = 2

   tags = {
      Name = "workervm${count.index}"
      env = "prod"
   }
}

resource "aws_volume_attachment" "master-ebs-attach" {
  device_name = "/dev/sdb"
  volume_id = aws_ebs_volume.master-vm-ebs.id
  instance_id = aws_instance.mvm.id
}

resource "aws_volume_attachment" "worker1-ebs-attach" {
   device_name = "/dev/sdb"
   volume_id = aws_ebs_volume.worker-ebs1.id
   instance_id = aws_instance.wvm[0].id
}

resource "aws_volume_attachment" "worker2-ebs-attach" {
   device_name = "/dev/sdb"
   volume_id =  aws_ebs_volume.worker-ebs2.id
   instance_id = aws_instance.wvm[1].id
}

