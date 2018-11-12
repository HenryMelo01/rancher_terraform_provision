# Amazon AWS Key Pair Name
ssh_key_name = ""
# Region where resources should be created
region = ""
# Resources will be prefixed with this to avoid clashing names
prefix = ""
# Admin password to access Rancher
admin_password = ""
# rancher/rancher image tag to use
rancher_version = ""
# Count of agent nodes with role all
count_agent_all_nodes = "1"
# Count of agent nodes with role etcd
count_agent_etcd_nodes = "0"
# Count of agent nodes with role controlplane
count_agent_controlplane_nodes = "0"
# Count of agent nodes with role worker
count_agent_worker_nodes = "2"
# Docker version of host running `rancher/rancher`
docker_version_server = "18.06"
# Docker version of host being added to a cluster (running `rancher/rancher-agent`)
docker_version_agent = "18.06"
# AWS Instance Type
type = "t3.medium"
# Rancher cluster name
cluster_name = ""
#AWS VPC ID
aws_vpc = ""
#AWS Subnet ID
aws_subnet_private_c  = ""
#AWS Subnet ID
aws_subnet_private_b  = ""
#Domain
domain = ""
