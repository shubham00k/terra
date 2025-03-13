provider "aws" {
    region = "us-east-1"
}

# Fetch the default VPC
data "aws_vpc" "default" {
    default = true
}

# Fetch a subnet from the default VPC
data "aws_subnet" "default" {
    vpc_id = data.aws_vpc.default.id
    availability_zone = "us-east-1a"  # Adjust based on your region
}

# Create a security group to allow SSH access
resource "aws_security_group" "allow_ssh" {
    name        = "allow_ssh"
    description = "Allow SSH inbound traffic"
    vpc_id      = data.aws_vpc.default.id

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere (restrict in production)
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "Terraform-SG"
    }
}

# EC2 Instance
resource "aws_instance" "my-instance" {
    ami                    = "ami-04b4f1a9cf54c11d0"  # Amazon Linux 2 in us-east-1 (update for Ubuntu if needed)
    instance_type          = var.instance_type
    subnet_id              = data.aws_subnet.default.id
    vpc_security_group_ids = [aws_security_group.allow_ssh.id]
    key_name               = var.key_name  # Optional: Specify an existing key pair name

    tags = {
        Name = "Terraform-Instance"
    }
}

# S3 Bucket
resource "aws_s3_bucket" "my-bucket" {
    bucket = var.s3_bucket_name
    tags = {
        Name = "Terraform-Bucket"
    }
}