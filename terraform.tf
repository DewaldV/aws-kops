resource "aws_s3_bucket" "tf_state" {
  bucket = "kyiro.net-tfstate"
  acl  = "private"
  force_destroy = "true"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "${aws_kms_key.tf_state_key.arn}"
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

resource "aws_kms_key" "tf_state_key" {
  description             = "Used for objects in kyiro.net-tfstate"
  deletion_window_in_days = 7
}

resource "aws_kms_alias" "tf_state_key" {
  name = "alias/tf/kyiro-net-tfstate"
  target_key_id = "${aws_kms_key.tf_state_key.key_id}"
}

