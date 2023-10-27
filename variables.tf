
variable "region" {
  description = "Region of vpc"
  type        = string
  default     = "eu-central-1"
}

# cidr vpc
variable "vpc_cidr" {
  description = "CIDR of vpc"
  type        = string
  default     = "10.0.0.0/16"
}

# instances
variable "public_instance" {
  description = "Public instance"
  type        = string
  default     = "ami-0e80cdc14ed2f397b"
}

variable "private_instance" {
  description = "Private instance"
  type        = string
  default     = "ami-0e80cdc14ed2f397b"
}

variable "instance_type" {
  type        = string
  description = "t2.micro instances"
  default     = "t2.micro"
}

variable "instances_count" {
  description = "Count for instances"
  type        = number
  default     = 2
}

# for security group
variable "allow_ports" {
  description = "Open ports"
  default     = ["80", "443", "22"]
}

# availability zones
variable "availability_zone" {
  description = "Availability zones"
  default     = ["eu-central-1a", "eu-central-1b"]
}

# subnets cidr
variable "public_subnet_cidrs" {
  type        = list(any)
  description = "Public Subnet CIDR values"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(any)
  description = "Private Subnet CIDR values"
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "destination_cidr" {
  description = "Destination CIDR"
  default     = "0.0.0.0/0"
}

variable "ingress_cidr_pub" {
  description = "CIDR for ingress"
  default     = "0.0.0.0/0"
}

variable "bucket_name" {
  type        = string
  description = "aws s3 bucket"
  default     = "assugan-vpc-bucket"
}

variable "default_tags" {
  default = {

    Environment = "Development"
    Owner       = "DevOps"
    Project     = "Test"

  }
  description = "Default tags for all resources"
  type        = map(any)
}
