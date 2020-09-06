resource "aws_ecs_service" "test-ecs-service" {
  	name            = "test-ecs-service"
  	cluster         = "${aws_ecs_cluster.test-ecs-cluster.id}"
    task_definition = "${aws_ecs_task_definition.wordpress.id}"
	launch_type = "FARGATE"
    scheduling_strategy = "REPLICA" // 'FARGATE' does not support 'DAEMON' strategy
    desired_count = 2
    deployment_minimum_healthy_percent = 100
    deployment_maximum_percent = 200

    lifecycle {
        ignore_changes = ["desired_count"]
    }
    network_configuration {
        assign_public_ip = true
        subnets = ["${aws_subnet.test_public_sn_01.id}"]
        security_groups = ["${aws_security_group.test_public_sg.id}"]
    }
}