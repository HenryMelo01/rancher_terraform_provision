resource "aws_instance" "rancherserver" {
  ami                         = "${data.aws_ami.ubuntu.id}"
  instance_type               = "${var.type}"
  key_name                    = "${var.ssh_key_name}"
  security_groups             = ["${aws_security_group.rancher_sg_allowports.id}"]
  user_data                   = "${data.template_cloudinit_config.rancherserver-cloudinit.rendered}"
  subnet_id                   = "${var.aws_subnet_private_b}"

  tags {
    Name = "${var.prefix}-rancherserver"
  }
}

resource "aws_instance" "rancheragent-all" {
  count                       = "${var.count_agent_all_nodes}"
  ami                         = "${data.aws_ami.ubuntu.id}"
  instance_type               = "${var.type}"
  key_name                    = "${var.ssh_key_name}"
  security_groups             = ["${aws_security_group.rancher_sg_allowports.id}"]
  user_data                   = "${data.template_cloudinit_config.rancheragent-all-cloudinit.*.rendered[count.index]}"
  subnet_id                   = "${var.aws_subnet_private_c}"
  depends_on                  = ["aws_instance.rancherserver", "aws_alb_target_group_attachment.join-lb"]

  tags {
    Name = "${var.prefix}-rancheragent-${count.index}-all"
  }
}

resource "aws_instance" "rancheragent-etcd" {
  count                       = "${var.count_agent_etcd_nodes}"
  ami                         = "${data.aws_ami.ubuntu.id}"
  instance_type               = "${var.type}"
  key_name                    = "${var.ssh_key_name}"
  security_groups             = ["${aws_security_group.rancher_sg_allowports.id}"]
  user_data                   = "${data.template_cloudinit_config.rancheragent-etcd-cloudinit.*.rendered[count.index]}"
  subnet_id                   = "${var.aws_subnet_private_c}"
  depends_on                  = ["aws_instance.rancherserver", "aws_alb_target_group_attachment.join-lb"]

  tags {
    Name = "${var.prefix}-rancheragent-${count.index}-etcd"
  }
}

resource "aws_instance" "rancheragent-controlplane" {
  count                       = "${var.count_agent_controlplane_nodes}"
  ami                         = "${data.aws_ami.ubuntu.id}"
  instance_type               = "${var.type}"
  key_name                    = "${var.ssh_key_name}"
  security_groups             = ["${aws_security_group.rancher_sg_allowports.id}"]
  user_data                   = "${data.template_cloudinit_config.rancheragent-controlplane-cloudinit.*.rendered[count.index]}"
  subnet_id                   = "${var.aws_subnet_private_c}"
  depends_on                  = ["aws_instance.rancherserver", "aws_alb_target_group_attachment.join-lb"]

  tags {
    Name = "${var.prefix}-rancheragent-${count.index}-controlplane"
  }
}

resource "aws_instance" "rancheragent-worker" {
  count                       = "${var.count_agent_worker_nodes}"
  ami                         = "${data.aws_ami.ubuntu.id}"
  instance_type               = "${var.type}"
  key_name                    = "${var.ssh_key_name}"
  security_groups             = ["${aws_security_group.rancher_sg_allowports.id}"]
  user_data                   = "${data.template_cloudinit_config.rancheragent-worker-cloudinit.*.rendered[count.index]}"
  subnet_id                   = "${var.aws_subnet_private_c}"
  depends_on                  = ["aws_instance.rancherserver", "aws_alb_target_group_attachment.join-lb"]

  tags {
    Name = "${var.prefix}-rancheragent-${count.index}-worker"
  }
}

output "rancher-url" {
  value = "https://${aws_route53_record.rancher-b2b.fqdn}"
}

output "server" {
  value = "${aws_instance.rancherserver.private_ip}"
}

output "control-pane-ip" {
  value = "${aws_instance.rancheragent-controlplane.*.private_ip}"
}

output "etcd-ip" {
  value = "${aws_instance.rancheragent-etcd.*.private_ip}"
}

output "all" {
  value = "${aws_instance.rancheragent-all.*.private_ip}"
}
output "workers" {
  value = "${aws_instance.rancheragent-worker.*.private_ip}"
}