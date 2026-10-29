data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "app" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_b.id
  vpc_security_group_ids      = [aws_security_group.app.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2.name
  associate_public_ip_address = true

  user_data = templatefile("${path.module}/user_data.sh.tftpl", {
    aws_region = var.aws_region
    secret_arn = aws_secretsmanager_secret.db_password.arn
  })

  metadata_options {
    http_tokens = "required"
  }

  tags = {
    Name = "node-express-cicd-app"
    Role = "CodeDeployTarget"
  }

  depends_on = [
    aws_iam_role_policy_attachment.ec2_codedeploy,
    aws_iam_role_policy.ec2_secret_read
  ]
}