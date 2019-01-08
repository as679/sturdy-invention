#!/usr/bin/env bash
let count=`grep student_count terraform.tfvars | awk '{print $3}'`
idx=0
for i in `seq $count`; do
  echo -n "Student$i: "
  terraform state show aws_instance.ctrl[$idx] | grep 'public_ip ' | awk '{print $3}'
  ((idx++))
done
let count=`grep server_count terraform.tfvars | awk '{print $3}'`
idx=0
for i in `seq $count`; do
  echo -n "Server$i: "
  terraform state show aws_instance.server[$idx] | grep 'private_ip ' | awk '{print $3}'
  ((idx++))
done
let count=`grep -a2 dns_server_count vars_class.tf | grep default | awk '{print $3}'`
idx=0
for i in `seq $count`; do
  echo -n "DNS Server$i Private IP: "
  terraform state show aws_instance.dns_server[$idx] | grep 'private_ip ' | awk '{print $3}'
  echo -n "DNS Server$i Public IP: "
  terraform state show aws_instance.dns_server[$idx] | grep 'public_ip ' | awk '{print $3}'
  ((idx++))
done
echo -n "Jumpbox: "
terraform state show aws_instance.jump | grep 'public_ip ' | awk '{print $3}'
echo -n "Jumpbox [private]: "
terraform state show aws_instance.jump | grep 'private_ip ' | awk '{print $3}'
