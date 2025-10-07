resource "aws_ecr_repository" "docker-ci" {
    name = "docker-ci"
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = true
    }

    tags = {
        IAC = true
    }
}