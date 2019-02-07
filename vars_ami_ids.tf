# This file contains the AMI Ids of the images used for the various instances
#

# aws ec2 describe-images --owners 139284885014 --filters Name=name,Values='Avi-Controller-17.2.8*' --region eu-west-2 | jq -r '.Images | sort_by(.CreationDate) | last(.[]).ImageId'
variable "ami_avi_controller" {
  type        = "map"
  description = "Avi AMI by region updated 11/04/18 - 17.2.8-9031"

  default = {
    us-west-2 = "ami-03a31f305a0d65ae4" #17.2.15
    eu-west-2 = "ami-02af3bef9afab4998" #17.2.12
    eu-west-1 = "ami-08e9261d1137c972c"
  }
}

# aws ec2 describe-images --owners aws-marketplace --filters Name=product-code,Values=aw0evgkw8e5c1q413zgy5pjce --region eu-west-2 | jq -r '.Images | sort_by(.CreationDate) | last(.[]).ImageId'
# NOTE
# Prebuilt packer image is used in labs
variable "ami_centos" {
  type        = "map"
  description = "CentOS AMI by region updated 05/06/18"

  default = {
    us-west-2 = "ami-041306c20ecd1c23c"
    eu-west-2 = "ami-04468f4b62ced6706"
    eu-west-1 = "ami-04b7ddd138f4401de"
  }
}

# aws ec2 describe-images --owners 679593333241 --filters Name=name,Values='Kali Linux*' --region eu-west-2 | jq -r '.Images | sort_by(.CreationDate) | last(.[]).ImageId'
# NOTE
# Prebuilt packer image is used in labs
variable "ami_kali" {
  type        = "map"
  description = "Kali Linux AMI by region updated 05/06/18"

  default = {
    us-west-2 = "ami-0c4d06cabfcbbc91b"
    eu-west-2 = "ami-0252f4d21ee383ea4" #latest Packer build
    eu-west-1 = "ami-0ab1e7fa3bba64ef6"
  }
}
