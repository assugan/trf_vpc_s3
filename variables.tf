
variable "region" {
  default = "eu_central-1"
}

# instances
variable "public_instance" {
  type = string
  default = "ami-0e80cdc14ed2f397b"
}
variable "private_instance" {
  type = string
  default = "ami-0e80cdc14ed2f397b"
}
variable "instance_type" {
  type = string
  description = "t2.micro instances"
  default = "t2.micro"
}
variable "public_instance_count" {
  type = number
  default = 3
}
variable "private_instance_count" {
  type = number
  default = 2
}

/*
# availability zones
variable "availabilityZone" {
  default = ["eu-central-1a", "eu-central-1b"]
}
*/

# cidr vpc
variable "vpcCIDRblock" {
  default = "10.0.0.0/16"
}

# subnets cidr
variable "publicSubnetCIDR" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = ["10.0.1.0/24", "10.0.2.0/24" ]
}

variable "privateSubnetCIDR" {
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}
/*
# subnet count
variable "subnet_count" {
  type = number
  default = 2
}
*/

variable "destinationCIDRblock" {
  default = "0.0.0.0/0"
}

variable "ingressCIDRblockPub" {
  default = "0.0.0.0/0"
}


variable "bucket_name" {
  type = string
  description = "aws s3 bucket"
  default = "assugan_vpc_bucket"
  
}




 

