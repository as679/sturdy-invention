# This file contains the AMI Ids of the images used for the various instances
#

# aws ec2 describe-images --owners 139284885014 --filters Name=name,Values='Avi-Controller-17.2.8*' --region eu-west-2 | jq -r '.Images | sort_by(.CreationDate) | last(.[]).ImageId'
variable "ami_avi_controller" {
  type        = "map"
  description = "Avi AMI by region updated 07/01/19"

  default = {
    eu-west-1 = "ami-08e9261d1137c972c" #17.2.14
    us-west-2 = "ami-0b90c7bdd7a7b777f" #17.2.14
  }
}

# aws ec2 describe-images --owners aws-marketplace --filters Name=product-code,Values=aw0evgkw8e5c1q413zgy5pjce --region eu-west-2 | jq -r '.Images | sort_by(.CreationDate) | last(.[]).ImageId'

# NOTE
# Prebuilt packer image is used in labs
variable "ami_centos" {
  type        = "map"
  description = "CentOS AMI by region updated 10/10/18"

  default = {
    eu-west-1 = "ami-05eb3891651ec6912"
    us-west-2 = "ami-01cd2786f990efdf5"
  }
}
