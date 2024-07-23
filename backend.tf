terraform {
  backend "s3" {
    bucket         = "jenkins-s31"
    key            = "state"
    region         = "us-east-1"
  }
}
