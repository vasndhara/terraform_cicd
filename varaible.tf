variable "ami_id" { 
 description = "The AMI ID for the EC2 instance"
 type = string
 default = "ami-04a81a99f5ec58529"
} 
variable "instance_type" { 
 description = "The instance type"
 type = string
 default = "t2.micro"
} 
variable "public_subnet_id" { 
 default = aws_subnet.PublicSubnet.id
}
