resource "aws_ebs_volume" "master-vm-ebs" {
    size = 10
    availability_zone = var.master_az
   ## availability_zone = data.aws_availability_zones.vpc-azs.names[1]
}

resource "aws_ebs_volume" "worker-ebs1" {
    size = 20
    availability_zone = var.worker_az
   ## availability_zone = data.aws_availability_zones.vpc-azs.names[0]
}

resource "aws_ebs_volume" "worker-ebs2" {
    size = 20
    availability_zone = var.worker_az
   ## availability_zone = data.aws_availability_zones.vpc-azs.names[0]
}