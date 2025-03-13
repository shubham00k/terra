output "instance_public_ip" {
    description = "The public IP of the EC2 instance"
    value       = aws_instance.my-instance.public_ip
}

output "s3_bucket_name" {
    description = "The name of the S3 bucket"
    value       = aws_s3_bucket.my-bucket.bucket
}