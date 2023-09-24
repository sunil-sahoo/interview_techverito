resource "aws_instance" "web1" {
    ami = var.amis[var.AWS_REGION]
    instance_type = var.instance_type
    iam_instance_profile = var.instance_profile_name
    
    # VPC
    subnet_id = "${aws_subnet.test-subnet-public-1.id}"
    # Security Group
    vpc_security_group_ids = ["${aws_security_group.web.id}"]
    # the Public SSH key
    key_name = "${aws_key_pair.interview-key-pair.id}"
    user_data = "${file("${var.SCRIPT_PATH}")}"

    connection {
        user = "${var.EC2_USER}"
        private_key = "${file("${var.PRIVATE_KEY_PATH}")}"
    }
    tags = var.ec2_tag

}
// Sends your public key to the instance
resource "aws_key_pair" "interview-key-pair" {
    key_name = "interview-key-pair"
    public_key = "${file(var.PUBLIC_KEY_PATH)}"
}
