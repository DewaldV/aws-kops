resource "aws_s3_bucket" "kops_state" {
  bucket = "kops.kyiro.net-state"
  acl  = "private"
  force_destroy = "true"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "${aws_kms_key.kops_state_key.arn}"
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

resource "aws_kms_key" "kops_state_key" {
  description             = "Used for objects in kops.kyiro.net-state"
  deletion_window_in_days = 7
}

resource "aws_kms_alias" "kops_state_key" {
  name = "alias/kops/kops-kyiro-net_state"
  target_key_id = "${aws_kms_key.kops_state_key.key_id}"
}

