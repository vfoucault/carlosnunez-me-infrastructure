variable "aws_region" {
  description = "The region onto which this cluster will be deployed."
}

variable "controller_instance_size" {
  description = "The size of your Kubernetes controller."
  default = {
    us-east-1 = "t2.micro"
    us-east-2 = "t2.micro"
    us-west-1 = "t2.micro"
  }
}
