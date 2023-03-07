variable ec2_type {
    type = string
    default = "t2.medium"
}

variable "master_az" {
    type = string
    default = "us-east-1a"
}

variable "worker_az" {
    type = string
    default = "us-east-1b"
}

variable "ec2_image" {
    type = string
    default = "ami-0c07df890a618c98a"
}