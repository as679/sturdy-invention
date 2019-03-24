# Terraform definition for the lab dns_servers
#

data "template_file" "dns_server_userdata" {
  count    = "${var.dns_server_count}"
  template = "${file("${path.module}/userdata/dns_server.userdata")}"

  vars {
    hostname = "dns_server${count.index + 1}.lab"
    jump_ip  = "${aws_instance.jump.private_ip}"
    number   = "${count.index + 1}"
  }
}
resource "aws_instance" "dns_server" {
  count                  = "${var.dns_server_count}"
  ami                    = "${lookup(var.ami_centos, var.aws_region)}"
  availability_zone      = "${lookup(var.aws_az, var.aws_region)}"
  instance_type          = "${var.flavour_centos}"
  key_name               = "${var.key}"
  vpc_security_group_ids = ["${aws_security_group.jumpsg.id}"]
  subnet_id              = "${aws_subnet.pubnet.id}"
  associate_public_ip_address = true
  private_ip             = "${format("%s%02d", cidrhost(aws_subnet.pubnet.cidr_block,1), 10 + count.index + 1  )}"
  source_dest_check      = false
  user_data              = "${data.template_file.dns_server_userdata.*.rendered[count.index]}"
  depends_on             = ["aws_instance.jump"]

  tags {
    Name  = "dns_server${count.index + 1}"
    Owner = "${var.owner}"
    Lab_Group = "dns_servers"
    Lab_Name = "dns_server${count.index + 1}.lab"
    Lab_Timezone = "${var.lab_timezone}"
  }

  root_block_device {
    volume_type           = "standard"
    volume_size           = "${var.vol_size_centos}"
    delete_on_termination = "true"
  }
}
