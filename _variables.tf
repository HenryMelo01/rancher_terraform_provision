variable "profile" {
  default     = "staging"
  description = "Amazon profile"
}

variable "prefix" {
  default     = "yourname"
  description = "Cluster Prefix - All resources created by Terraform have this prefix prepended to them"
}

variable "rancher_version" {
  default     = "latest"
  description = "Rancher Server Version"
}

variable "count_agent_all_nodes" {
  default     = "1"
  description = "Number of Agent All Designation Nodes"
}

variable "count_agent_etcd_nodes" {
  default     = "0"
  description = "Number of ETCD Nodes"
}

variable "count_agent_controlplane_nodes" {
  default     = "0"
  description = "Number of K8s Control Plane Nodes"
}

variable "count_agent_worker_nodes" {
  default     = "0"
  description = "Number of Worker Nodes"
}

variable "admin_password" {
  default     = "admin"
  description = "Password to set for the admin account in Rancher"
}

variable "cluster_name" {
  default     = "quickstart"
  description = "Kubernetes Cluster Name"
}

variable "region" {
  default     = "us-west-2"
  description = "Amazon AWS Region for deployment"
}

variable "type" {
  default     = "t2.medium"
  description = "Amazon AWS Instance Type"
}

variable "docker_version_server" {
  default     = "17.03"
  description = "Docker Version to run on Rancher Server"
}

variable "docker_version_agent" {
  default     = "17.03"
  description = "Docker Version to run on Kubernetes Nodes"
}

variable "ssh_key_name" {
  default     = ""
  description = "Amazon AWS Key Pair Name"
}

variable "aws_vpc" {
  default     = "vpc-xxx"
  description = "AWS vpc"
}

variable "aws_subnet_private_b" {
  default     = "subnet-xxx"
  description = "AWS subnet"
}

variable "aws_subnet_private_c" {
  default     = "subnet-xxx"
  description = "AWS subnet"
}

variable "domain" {
  default = "xxx"
  description = "domain to certificate and hosted zone"
}