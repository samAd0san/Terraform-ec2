# CREATING A KEYPAIR
resource "aws_key_pair" "mykey" {
        # Generate keypair in cd .ssh -> ssh-keygen -> enter the keyname
        key_name = "terra-key"
        public_key = file("/home/ubuntu/.ssh/terra-key.pub")
}

# CREATING A DEFAULT VPC
resource "aws_default_vpc" "default_vpc" {

}

# CREATING A SECURITY GROUP
resource "aws_security_group" "allow_ssh" {
        name = "allow_ssh"
        description = "Security group to allow ssh port"

        vpc_id = aws_default_vpc.default_vpc.id
		
		# INBOUND RULES
        ingress {
                description = "TLS from vpc"
                protocol = "TCP"
                from_port = 22
                to_port = 22
                cidr_blocks = ["0.0.0.0/0"]
        }

		# OUTBOUND RULES 
		egress {
                description = "OutBound rules"
                protocol = "-1"
                from_port = 0
                to_port = 0
                cidr_blocks = ["0.0.0.0/0"]
        }

        tags = {
                Name = "allow_ssh"
        }
}


# CREATING AN EC2 INSTANCE (GIVING SPECS)
resource "aws_instance" "my-vpc-instance" {
        key_name = aws_key_pair.mykey.key_name
        ami      = var.ec2-ubuntu
        instance_type = "t2.micro"
        security_groups = [aws_security_group.allow_ssh.name]

        tags = {
                Name = "ec2-terra-connect"
        }
}
