
resource "aws_security_group" "web" {
  name = "web-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami                    = "ami-0cbd40f694b804622" # Ubuntu 22.04 us-west-1
  instance_type          = "t2.micro"
  key_name               = "terraform-key"
  vpc_security_group_ids = [aws_security_group.web.id]

  user_data = <<-EOF
  #!/bin/bash
  apt update -y

  # Node + ferramentas
  curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
  apt install -y nodejs nginx git

  systemctl start nginx
  systemctl enable nginx

  cd /var/www
  rm -rf site
  git clone https://github.com/SEU_USUARIO/SEU_REPO.git site
  cd site

  npm install
  npm run build

  rm -rf /var/www/html/*
  cp -r dist/* /var/www/html/
EOF

  tags = {
    Name = "ubuntu-web"
  }
}

output "site_url" {
  value = "http://${aws_instance.web.public_ip}"
}
