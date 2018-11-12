data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "template_cloudinit_config" "rancherserver-cloudinit" {
  part {
    content_type = "text/cloud-config"
    content      = "hostname: ${var.prefix}-rancherserver\nmanage_etc_hosts: true"
  }

  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.userdata_server.rendered}"
  }
}

data "template_cloudinit_config" "rancheragent-all-cloudinit" {
  count = "${var.count_agent_all_nodes}"

  part {
    content_type = "text/cloud-config"
    content      = "hostname: ${var.prefix}-rancheragent-${count.index}-all\nmanage_etc_hosts: true"
  }

  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.userdata_agent.rendered}"
  }
}

data "template_cloudinit_config" "rancheragent-etcd-cloudinit" {
  count = "${var.count_agent_etcd_nodes}"

  part {
    content_type = "text/cloud-config"
    content      = "hostname: ${var.prefix}-rancheragent-${count.index}-etcd\nmanage_etc_hosts: true"
  }

  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.userdata_agent.rendered}"
  }
}

data "template_cloudinit_config" "rancheragent-controlplane-cloudinit" {
  count = "${var.count_agent_controlplane_nodes}"

  part {
    content_type = "text/cloud-config"
    content      = "hostname: ${var.prefix}-rancheragent-${count.index}-controlplane\nmanage_etc_hosts: true"
  }

  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.userdata_agent.rendered}"
  }
}

data "template_cloudinit_config" "rancheragent-worker-cloudinit" {
  count = "${var.count_agent_worker_nodes}"

  part {
    content_type = "text/cloud-config"
    content      = "hostname: ${var.prefix}-rancheragent-${count.index}-worker\nmanage_etc_hosts: true"
  }

  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.userdata_agent.rendered}"
  }
}

data "template_file" "userdata_server" {
  template = "${file("files/userdata_server")}"

  vars {
    admin_password        = "${var.admin_password}"
    cluster_name          = "${var.cluster_name}"
    docker_version_server = "${var.docker_version_server}"
    rancher_version       = "${var.rancher_version}"
  }
}

data "template_file" "userdata_agent" {
  template = "${file("files/userdata_agent")}"

  vars {
    admin_password       = "${var.admin_password}"
    cluster_name         = "${var.cluster_name}"
    docker_version_agent = "${var.docker_version_agent}"
    rancher_version      = "${var.rancher_version}"
    server_address       = "${aws_instance.rancherserver.private_ip}"
  }
}

data "aws_security_group" "public_access" {
  name = "public_sg"
  vpc_id = "${var.aws_vpc}"
}

data "aws_route53_zone" "route53_zone" {
  name = "${var.domain}"
}

data "aws_acm_certificate" "ceriticate" {
  domain = "*.${var.domain}"
  statuses = ["ISSUED"]
}