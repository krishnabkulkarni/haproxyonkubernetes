output "worker_vm_ip1" {
  value = aws_instance.wvm[0].public_ip
}

output "worker_vm_ip2" {
  value = aws_instance.wvm[1].public_ip
}

output "master_vm_ip" {
  value = aws_instance.mvm.public_ip
}

output "worker_vm_prv_ip1" {
  value = aws_instance.wvm[0].private_ip
}

output "worker_vm_prv_ip2" {
  value = aws_instance.wvm[1].private_ip
}

output "master_vm_prv_ip" {
  value = aws_instance.mvm.private_ip
}
