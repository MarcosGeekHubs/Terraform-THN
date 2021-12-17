############################################################
###########  VARIABLE DE REGION
############################################################
variable "aws_region" {
  description = "AWS region"
  type        = list(string)
  default     = ["eu-west-1", "eu-west-1a", "eu-west-1b", "eu-west-1c"]
}



############################################################
########### VARIABLES DE INSTANCIAS
############################################################

variable "num_inst" {
  description = "Número de instancias. Valores posibles del 1 al 5"
  type        = list(number)
  default     = [1, 2, 3, 4, 5]
}

variable "inst_class" {
  description = "Tipos de hardware disponibles. Se irán añadiendo"
  type        = list(string)
  default     = ["db.t3.medium"]
}

variable "tier" {
  description = "Tipo de tier. Valores validos del 0 al 15"
  type        = list(string)
  default     = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15"]
}

variable "ca_cert" {
  description = "certificados"
  type        = string
  default     = "rds-ca-2019"
}

############################################################
########### VARIABLES GENÉRICAS
############################################################

variable "nodes" {
  description = "Nombre identificativo de los nodos de las instancias"
  type        = string
  default     = "-node0"
}

variable "commercial" {
  description = "values: thn"
  type        = string
  default     = "thn"
}

variable "env" {
  description = "values: stg prd"
  type        = string
  default     = "stg"
}

variable "engine" {
  description = "Motoroes posibles de documentdb"
  type        = string
  default     = "docdb"
}

variable "eng_ver" {
  description = "Versiones disponibles de DocDB"
  type        = list(string)
  default     = ["4.0.0"]
}


############################################################
########### VARIABLES SENSIBLES
############################################################

variable "users" {
  description = "Usuarios maestros"
  type        = list(string)
  default     = ["knok", "admin"]
  sensitive   = false
}

variable "pwd" {
  description = "pwd"
  type        = string
  default     = "0123456789"
  /* sensitive   = true ## --> por defecto la palabra clave "master_password" el proveedor de AWS ya
  la reconoce como sensible y no la muestra por la terminal al ejecutar plan o apply */
}
