# This file contains the AMI Ids of the images used for the various instances
#

# aws ec2 describe-images --owners 139284885014 --filters Name=name,Values='Avi-Controller-17.2.8*' --region eu-west-2 | jq -r '.Images | sort_by(.CreationDate) | last(.[]).ImageId'
variable "ami_avi_controller" {
  type        = "map"
  description = "Avi AMI by region updated 11/04/18 - 17.2.8-9031"

  default = {
    us-west-2 = "ami-044157c009c8b2c19"
    eu-west-2 = "ami-02c40da7ac2a43b21"
  }
}

# aws ec2 describe-images --owners aws-marketplace --filters Name=product-code,Values=aw0evgkw8e5c1q413zgy5pjce --region eu-west-2 | jq -r '.Images | sort_by(.CreationDate) | last(.[]).ImageId'
variable "ami_centos" {
  type        = "map"
  description = "CentOS AMI by region updated 11/04/18"

  default = {
    us-west-2 = "ami-0ebdd976"
    eu-west-2 = "ami-4f02e328"
  }
}
