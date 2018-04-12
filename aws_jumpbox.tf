# Terraform definition for the lab jumpbox
#

data "template_file" "jumpbox_userdata" {
  template = "${file("${path.module}/userdata/jumpbox.userdata")}"

  vars {
    hostname       = "${var.id}_jump"
    base_ip        = "${var.base_ip}"
    ctrl_ip        = "${join(":", aws_instance.ctrl.*.private_ip)}"
    ctrl_ip_public = "${join(":", aws_instance.ctrl.*.public_ip)}"
    server_count   = "${var.student_count}"

    vpc_id   = "${aws_vpc.waf_vpc.id}"
    region   = "${var.aws_region}"
    az       = "${lookup(var.aws_az, var.aws_region)}"
    mgmt_net = "${aws_subnet.mgmtnet.tags.Name}"
    pkey     = "${var.pkey}"
  }
}

resource "aws_instance" "jump" {
  ami                         = "${lookup(var.ami_centos, var.aws_region)}"
  availability_zone           = "${lookup(var.aws_az, var.aws_region)}"
  instance_type               = "${var.flavour_centos}"
  key_name                    = "${var.key}"
  vpc_security_group_ids      = ["${element(aws_security_group.jumpsg.*.id, count.index)}"]
  subnet_id                   = "${aws_subnet.pubnet.id}"
  associate_public_ip_address = true
  source_dest_check           = false
  user_data                   = "${data.template_file.jumpbox_userdata.rendered}"
  depends_on                  = ["aws_internet_gateway.igw"]

  tags {
    Name  = "${var.id}_jumpbox"
    Owner = "${var.owner}"
  }

  root_block_device {
    volume_type           = "standard"
    volume_size           = "${var.vol_size_centos}"
    delete_on_termination = "true"
  }
}
