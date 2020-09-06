data "aws_ecs_task_definition" "wordpress" {
  task_definition = "${aws_ecs_task_definition.wordpress.family}"
}

data "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
}

resource "aws_ecs_task_definition" "wordpress" {
    family                = "test-env"
    execution_role_arn       = "${data.aws_iam_role.ecs_task_execution_role.arn}"
    network_mode = "awsvpc" // FARGATE only supports this networking mode
    requires_compatibilities = ["FARGATE"]
    cpu = 256
    memory = 512
    container_definitions = <<DEFINITION
    
[
  {
    "name": "wordpress",
    "image": "185699690145.dkr.ecr.ap-south-1.amazonaws.com/test-env",
    "cpu": 10,
    "memory": 512,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ]
  }
]
DEFINITION
}