variable "AWS_REGION" {    
    default = "ap-south-1"
}

variable "amis" {
  type = map
  default = {
    "ap-south-1" = "ami-0f5ee92e2d63afc18"
    "us-west-2" = "ami-4b32be2b"
  }
}

variable "EC2_USER" {    
    default = "ubuntu"
}

variable "PUBLIC_KEY_PATH" {    
    default = "/home"
}

variable "PRIVATE_KEY_PATH" {    
    default = "/home/ubuntu"
}

variable "SCRIPT_PATH" {    
    default = "/home/ubuntu"
}

variable "instance_type" {    
    default = "t2.micro"
}


variable "vpc_tag" {
  type = map(string)
  default = {
    Name = "web"
  }
}

variable "subnet_tag" {
  type = map(string)
  default = {
    Name = "test-subnet-public-1"
  }
}

variable "igw_tag" {
  type = map(string)
  default = {
    Name = "test-igw"
  }
}

variable "route_tag" {
  type = map(string)
  default = {
    Name = "test-public-crt"
  }
}

variable "sg_tag" {
  type = map(string)
  default = {
    Name = "web"
  }
}

variable "ec2_tag" {
  type = map(string)
  default = {
    Name = "web"
  }
}

variable "instance_profile_name" {
  type    = string
  default = "ec2-profile"
}

variable "role_name" {
  type    = string
  default = "ec2-role"
}