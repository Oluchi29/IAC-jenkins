

variable "public_subnet1_cidr_block" {
  description = "CIDR Block for Public Subnet 1"
  default     = "10.0.1.0/24"
}

variable "public_subnet2_cidr_block" {
  description = "CIDR Block for PublicSubnet 2"
  default     = "10.0.2.0/24"
}

variable "ami" {
  description = "ami ubuntu"
  default     = "ami-0e86e20dae9224db8"
}


variable "instance_type" {
  description = "ami ubuntu_instance_type"
  default     = "t2.micro"
}

variable "region" {
  description = "aws provider"
  default     = "us-east-1"
}

