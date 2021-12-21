
terraform {
  backend "s3" {
    profile = "sandbox"
    bucket = "terraform-infraestructura-como-codigo-marc"
    key    = "Worspace/EC2/terraform.tfstate"
    region = "eu-west-1"

    //Donde tenemos la tabla 
    dynamodb_table = "terraform-infraestructura-como-codigo-locks-marcos"
    encrypt        = true
  }
}