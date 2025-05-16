terraform {
    backend "s3" {
        bucket = "ecr-bucket-for-gln"
        key = "ecr"
        region = "ap-south-1"
    }
}


resource "aws_ecr_repository" "my_ecr" {
    name = "my_ecr"
    image_tag_mutability = "MUTABLE"
    image_scanning_configuration {
      scan_on_push = true
    }

}

resource "aws_ecr_repository_policy" "my_ecr_policy" {
  repository = aws_ecr_repository.my_ecr.name

  policy = jsonencode({
    Version = "2008-10-17"
    Statement = [
      {
        Sid = "AllowPull"
        Effect = "Allow"
        Principal = "*"
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:DescribeRepositories",
          "ecr:GetRepositoryPolicy",
          "ecr:ListImages",
          "ecr:DeleteRepository",
          "ecr:BatchDeleteImage",
          "ecr:SetRepositoryPolicy",
          "ecr:DeleteRepositoryPolicy"
        ]
      }
    ]
  })
}
