data "aws_key_pair" "us-east-1-key" {
    key_name = "my-us-east-1-key"
    include_public_key = true
}

