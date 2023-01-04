#############################
## Application - Variables ##
#############################

# company name 
variable "company" {
  type        = string
  description = "This variable defines thecompany name used to build resources"
}

# application name 
variable "app_name" {
  type        = string
  description = "This variable defines the application name used to build resources"
}

# application or company environment
variable "environment" {
  type        = string
  description = "This variable defines the environment to be built"
}
