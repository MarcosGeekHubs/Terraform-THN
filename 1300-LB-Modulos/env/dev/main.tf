# -------------------------
# Define el provider de AWS
# -------------------------
provider "aws" {
  profile = "sandbox"
  region = local.region
}

locals {
  region          = "eu-west-1"
  ami             = var.ubuntu_ami[local.region]
  puerto_lb       = 80
  puerto_servidor = 8080
}

# ------------------------------------
# Data source que obtiene el id del AZ
# ------------------------------------
data "aws_subnet" "public_subnet" {
  for_each = var.servidores

  availability_zone = "${local.region}${each.value.az}"
}

module "servidores_ec2" {
  source = "../../modulos/instancias-ec2"

  tipo_instancia = "t2.nano"

  servidores = {//Mapa
    // for con dos iteradores, 
    //id_Ser = ser-1,ser-2
    //datos = es el objetos
    for id_ser, datos in var.servidores :
    //Creamos una entrada en el Mapa
    //Objeto
    id_ser => { nombre = datos.nombre, subnet_id = data.aws_subnet.public_subnet[id_ser].id }
  }

  puerto_servidor = local.puerto_servidor
  ami_id          = var.ubuntu_ami[local.region]
}

module "load_balancer" {
  source = "../../modulos/loadbalancer"
//Todas las que nos devuelvan los datasource
  subnet_ids      = [for subnet in data.aws_subnet.public_subnet : subnet.id]
    //Son las que hemos creado en el modulo, estos son los outputs
  //Hemos creado una dependencia entre módulos, necesitamos primer servidores_ec2
  //Palabra reservada módule-nombre y el output HEMOS CREADO UNA PENDENDCIA ENTRE MÓDULOS
  // Dependencia natural, porque pirmero necesitamos los
  instancia_ids   = module.servidores_ec2.instancia_ids
  puerto_lb       = local.puerto_lb
  puerto_servidor = local.puerto_servidor
}

