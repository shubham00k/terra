variable "instance_type" {
    description = "The EC2 instance type"
    type        = string
    default     = "t2.micro"
}

variable "s3_bucket_name" {
    description = "The name of the S3 bucket"
    type        = string
    default     = "shubham00k-terraform-bucket-20250312"
}

variable "key_name" {
    description = "The name of the SSH key pair"
    type        = string
    default     = null  # Set to your key pair name if using SSH
}