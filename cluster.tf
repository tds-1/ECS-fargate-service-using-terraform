resource "aws_ecs_cluster" "test-ecs-cluster" {
    name = "${var.ecs_cluster}"
    capacity_providers = ["FARGATE", "FARGATE_SPOT"]
}