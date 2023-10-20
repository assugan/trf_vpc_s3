
variable "region" {
  type = string
  default = "eu-central-1"
}

# cidr vpc
variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
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
variable "instances_count" {
  type = number
  default = 2
}

# for security group
variable "allow_ports" {
  description = "open ports"
  default = ["80","443","8080", "22"]
}

# availability zones
variable "availability_zone" {
  default = ["eu-central-1a", "eu-central-1b"]
}

# subnets cidr
variable "public_subnet_cidrs" {
  type        = list
  description = "Public Subnet CIDR values"
  default     = ["10.0.1.0/24", "10.0.2.0/24" ]
}

variable "private_subnet_cidrs" {
  type        = list
  description = "Private Subnet CIDR values"
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "destination_cidr" {
  default = "0.0.0.0/0"
}

variable "ingress_cidr_pub" {
  default = "0.0.0.0/0"
}


variable "bucket_name" {
  type = string
  description = "aws s3 bucket"
  default = "assugan-vpc-bucket"
  
}

variable "common_tags" {
  description = "tags for all resources"
  type = map
  default = {
    Owner = "DevOps"
    Environment = "Development"

  }
}





/*
# subnet count
variable "subnet_count" {
  type = number
  default = 2
}
*/




 

