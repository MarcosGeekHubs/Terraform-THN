//EJEMPLO 1
provider "aws" {
  profile = "sandbox"
  region = "eu-west-1"
}

//EJEMPLO 3
terraform {

  //Definimos el Backed
  backend "s3" {
    profile = "sandbox"
    bucket = "terraform-infraestructura-como-codigo-marc"
    //Es importante para reutilizar el backend,
    key    = "servidor/EC2/terraform.tfstate"
    region = "eu-west-1"

    //Donde tenemos la tabla 
    dynamodb_table = "terraform-infraestructura-como-codigo-locks-marcos"
    encrypt        = true
  }
}

//EJEMPLO 4

resource "aws_instance" "servidor" {
  ami           = "ami-0aef57767f5404a3c"
  instance_type = "t2.micro"
  tags = {
    Name ="S3-server-Marcos-Modificado2"
  }
}