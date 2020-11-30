variable "environment" {
  description     = "The environment"
}

variable "application" {
    description   = "The application name"
}

variable "vpc_id" {
    description = "the vpc id"
}

variable "public_subnet" {
  type            = list(string)
  description     = "the public subnet"
}

variable  "internal" {
    type          = bool
    default       = false
}