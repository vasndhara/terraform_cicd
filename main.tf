  provider "aws" {
    region = "us-east-1"
    
  }

  //create a vpc

resource "aws_vpc" "myvpc"{
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "MyVPC"
    }
}

  //Create a public subnet

resource "aws_subnet" "PublicSubnet"{
    vpc_id = aws_vpc.myvpc.id
    availability_zone = "us-east-1a"
    cidr_block = "10.0.1.0/24"
    tags = {
        Name = "terra_sub-pub"
    }
}

  //create a private subnet

resource "aws_subnet" "PrivSubnet"{
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = true

    tags = {
        Name = "terra_sub-pvt"
    }

}


  //create IGW

resource "aws_internet_gateway" "myIgw"{
    vpc_id = aws_vpc.myvpc.id

    tags = {
        Name = "terra_igw"
    }
}

  //route Tables for public subnet

resource "aws_route_table" "PublicRT"{
    vpc_id = aws_vpc.myvpc.id
    tags = {
        Name = "terra_RT"
    }
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.myIgw.id
    }
}
 

  //route table association public subnet 

resource "aws_route_table_association" "PublicRTAssociation"{
    subnet_id = aws_subnet.PublicSubnet.id
    route_table_id = aws_route_table.PublicRT.id
}

//ec2 instance

resource "aws_instance" "ec2" {
  ami           = "ami-04a81a99f5ec58529"
  instance_type = "t2.micro"
  subnet_id =  aws_subnet.PublicSubnet.id
  associate_public_ip_address = true

  tags = {
    Name = "terra_ec2"
  }
}

