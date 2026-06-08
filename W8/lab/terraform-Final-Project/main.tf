# Root main.tf

# Gọi module VPC đã tạo ở Step 1
module "vpc" {
  source       = "./modules/vpc"
  vpc_cidr     = "10.0.0.0/16"
  public_cidr  = "10.0.1.0/24"
  private_cidr = "10.0.2.0/24"
  region       = "ap-southeast-1"
  env          = "prod"
}

# SG cho Web Server (Mở HTTP và SSH từ Internet)
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow HTTP and SSH"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "web-sg" }
}

# SG cho RDS (Chỉ cho phép traffic MySQL 3306 từ Web Server)
resource "aws_security_group" "db_sg" {
  name        = "db-sg"
  description = "Allow MySQL from Web SG"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id] # Chỉ Web SG mới vào được đây
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "db-sg" }
}

# Tìm AMI Amazon Linux 2023 mới nhất
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

# Triển khai EC2 Instance ở Public Subnet
resource "aws_instance" "web" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  subnet_id              = module.vpc.public_subnet_id  # Đặt vào Public Subnet
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello from Terraform Web Server</h1>" > /var/www/html/index.html
              EOF

  tags = { Name = "WebServer" }
}

# Cần tạo DB Subnet Group bao gồm các private subnets
resource "aws_db_subnet_group" "db_subnet" {
  name       = "main-db-subnet"
  subnet_ids = module.vpc.private_subnet_ids # Danh sách 2 private subnets để thỏa mãn điều kiện của AWS RDS
}

# Triển khai RDS Instance ở Private Subnet
resource "aws_db_instance" "mysql" {
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  db_name                = "appdb"
  username               = "admin"
  password               = "SuperSecret123!" # Thực tế nên dùng AWS Secrets Manager hoặc variable mật
  db_subnet_group_name   = aws_db_subnet_group.db_subnet.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  skip_final_snapshot    = true # Bỏ qua snapshot khi xóa lab (tiết kiệm thời gian & chi phí)
}

# Tạo S3 Bucket lưu trữ static assets
resource "aws_s3_bucket" "static_assets" {
  bucket        = "store-static-assets" # Cần đổi tên này thành độc nhất trên toàn cầu
  force_destroy = true                                # Cho phép xóa bucket sạch sẽ khi chạy terraform destroy
  tags = {
    Name        = "Static Assets"
    Environment = "Prod"
  }
}
