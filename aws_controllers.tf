# Terraform definition for the lab Controllers
#

resource "aws_instance" "ctrl" {
  count                       = "${var.student_count}"
  ami                         = "${lookup(var.ami_avi_controller, var.aws_region)}"
  availability_zone           = "${lookup(var.aws_az, var.aws_region)}"
  instance_type               = "${var.flavour_avi}"
  key_name                    = "${var.key}"
  vpc_security_group_ids      = ["${aws_security_group.ctrlsg.id}"]
  subnet_id                   = "${aws_subnet.pubnet.id}"
  associate_public_ip_address = true
  iam_instance_profile        = "AviController-Refined-Role"
  source_dest_check           = false
  depends_on = ["aws_internet_gateway.igw"]

  tags {
    Name  = "${var.id}_student${count.index + 1}_ctrl"
    Owner = "${var.owner}"
  }

  root_block_device {
    volume_type           = "standard"
    volume_size           = "${var.vol_size_avi}"
    delete_on_termination = "true"
  }
}

output "JumpHost_PublicIP" {
  value = "${aws_instance.jump.public_ip}"
}

output "JumpHost_PrivateIP" {
  value = "${aws_instance.jump.private_ip}"
}

output "Controller_PublicIP" {
  value = "${aws_instance.ctrl.*.public_ip}"
}

output "Controller_PrivateIP" {
  value = "${aws_instance.ctrl.*.private_ip}"
}
