resource "aws_elasticache_replication_group" "sessions" {
  replication_group_id       = "webapp-sessions"
  description                = "Session cache"
  node_type                  = "cache.t3.small"
  num_cache_clusters         = 1
  engine                     = "redis"
  engine_version             = "7.0"
  at_rest_encryption_enabled = false
  transit_encryption_enabled = false
  auth_token                 = "redis-s3ssion-t0ken-2024"
  automatic_failover_enabled = false
  security_group_ids         = [aws_security_group.cache.id]
}

resource "aws_security_group" "cache" {
  name   = "webapp-cache"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_cloudwatch_log_group" "cache" {
  name              = "/webapp/cache"
  retention_in_days = 0
}
