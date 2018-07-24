# This file contains the AMI Ids of the images used for the various instances
#

# aws ec2 describe-images --owners 139284885014 --filters Name=name,Values='Avi-Controller-17.2.8*' --region eu-west-2 | jq -r '.Images | sort_by(.CreationDate) | last(.[]).ImageId'
variable "ami_avi_controller" {
  type        = "map"
  description = "Avi AMI by region updated 11/04/18 - 17.2.8-9031"

  default = {
    us-west-2 = "ami-044157c009c8b2c19"
    #eu-west-2 = "ami-02c40da7ac2a43b21" #17.2.8
    #eu-west-2 = "ami-09208f52b4a7fab78" #17.2.10
    #eu-west-2 = "ami-054cff7d4cce9453d" #17.2.9
    #eu-west-2 = "ami-0dd1d5a103bb33356" #17.2.11
    eu-west-2 = "ami-009a263926acf0230" #17.2.12
  }
}

# aws ec2 describe-images --owners aws-marketplace --filters Name=product-code,Values=aw0evgkw8e5c1q413zgy5pjce --region eu-west-2 | jq -r '.Images | sort_by(.CreationDate) | last(.[]).ImageId'
# NOTE
# Prebuilt packer image is used in labs
variable "ami_centos" {
  type        = "map"
  description = "CentOS AMI by region updated 05/06/18"

  default = {
    eu-west-2 = "ami-04468f4b62ced6706"
  }
}

# aws ec2 describe-images --owners 679593333241 --filters Name=name,Values='Kali Linux*' --region eu-west-2 | jq -r '.Images | sort_by(.CreationDate) | last(.[]).ImageId'
# NOTE
# Prebuilt packer image is used in labs
variable "ami_kali" {
  type        = "map"
  description = "Kali Linux AMI by region updated 05/06/18"

  default = {
    eu-west-2 = "ami-0252f4d21ee383ea4" #latest Packer build
  }
}
