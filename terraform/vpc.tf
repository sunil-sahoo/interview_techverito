resource "aws_vpc" "test-vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = "true" #gives you an internal domain name
    enable_dns_hostnames = "true" #gives you an internal host name
    instance_tenancy = "default"    
    tags = var.vpc_tag
}

resource "aws_subnet" "test-subnet-public-1" {
    vpc_id = "${aws_vpc.test-vpc.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true" //it makes this a public subnet
    availability_zone = "ap-south-1a"
    tags = var.subnet_tag

}

resource "aws_internet_gateway" "test-igw" {
    vpc_id = "${aws_vpc.test-vpc.id}"
    tags = var.igw_tag
}

#Create Custom Route Table
resource "aws_route_table" "test-public-crt" {
    vpc_id = "${aws_vpc.test-vpc.id}"
    
    route {
        //associated subnet can reach everywhere
        cidr_block = "0.0.0.0/0" 
        //CRT uses this IGW to reach internet
        gateway_id = "${aws_internet_gateway.test-igw.id}" 
    }
    tags = var.route_tag
}

#Associate CRT and Subnet
resource "aws_route_table_association" "test-crta-public-subnet-1"{
    subnet_id = "${aws_subnet.test-subnet-public-1.id}"
    route_table_id = "${aws_route_table.test-public-crt.id}"
}


#Create a security group
resource "aws_security_group" "web" {
    vpc_id = "${aws_vpc.test-vpc.id}"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        // This means, all ip address are allowed to ssh ! 
        // Do not do it in the testuction. 
        // Put your office or home address in it!
        cidr_blocks = ["0.0.0.0/0"]
    }
    //If you do not add this rule, you can not reach the NGIX  
    ingress {
        from_port = 3000
        to_port = 3000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
        ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = var.sg_tag
}

