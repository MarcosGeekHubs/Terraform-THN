terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = var.aws_region[0]
}

####################################################################################################
# Parámetros de clúster ############################################################################
####################################################################################################

# thn-stg-docdb-nostromo
# import --> terraform import aws_rds_cluster_parameter_group.thn-stg-mongodb thn-stg-mongodb

resource "aws_rds_cluster_parameter_group" "thn-stg-mongodb" {
  description = "Parámetro de clúster para docdb4.0"
  family      = "docdb4.0"
  name        = "${var.commercial}-${var.env}-mongodb"
  name_prefix = null
  parameter {
    apply_method = "immediate"
    name         = "ttl_monitor"
    value        = "disabled"
  }
  parameter {
    apply_method = "pending-reboot"
    name         = "tls"
    value        = "disabled"
  }
  tags     = {}
  tags_all = {}
}

###############
# thn-dyn-docdb-nostromo-cluster
# import --> terraform import aws_rds_cluster_parameter_group.thn-dyn-mongodb thn-dyn-mongodb

resource "aws_rds_cluster_parameter_group" "thn-dyn-mongodb" {
  description = "Parámetros de clúster docdb4.0 para DYN"
  family      = "docdb4.0"
  name        = "${var.commercial}-dyn-mongodb"
  name_prefix = null
  parameter {
    apply_method = "immediate"
    name         = "ttl_monitor"
    value        = "disabled"
  }
  parameter {
    apply_method = "pending-reboot"
    name         = "tls"
    value        = "disabled"
  }
  tags     = {}
  tags_all = {}
}

####################################################################################################
# Grupos de seguridad ##############################################################################
####################################################################################################

# thn-stg-documentdb
# import --> terraform import aws_security_group.docdb-segurity-group thn-stg-documentdb

resource "aws_security_group" "docdb-segurity-group" {
  description = "${var.commercial}-${var.env}-documentdb"
  egress = [
    {
      cidr_blocks = [
        "0.0.0.0/0"
      ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
  ingress = [
    {
      cidr_blocks = [
        "10.3.0.0/16",
        "10.2.0.0/16",
        "100.64.0.0/16"
      ]
      description      = ""
      from_port        = 27017
      ipv6_cidr_blocks = null
      prefix_list_ids  = null
      protocol         = "TCP"
      security_groups  = null
      self             = false
      to_port          = 27017
    },
    {
      cidr_blocks = [
        "10.74.0.0/16"
      ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = null
      prefix_list_ids  = null
      protocol         = "TCP"
      security_groups  = null
      self             = false
      to_port          = 65535
    },
    {
      cidr_blocks = [
        "172.30.0.0/16"
      ]
      description      = ""
      from_port        = 22
      ipv6_cidr_blocks = null
      prefix_list_ids  = null
      protocol         = "TCP"
      security_groups  = null
      self             = false
      to_port          = 22
    },
    {
      cidr_blocks = [
        "172.30.0.0/16"
      ]
      description      = ""
      from_port        = 6379
      ipv6_cidr_blocks = null
      prefix_list_ids  = null
      protocol         = "TCP"
      security_groups  = null
      self             = false
      to_port          = 6379
    },
    {
      cidr_blocks = [
        "172.30.0.0/16"
      ]
      description      = ""
      from_port        = 80
      ipv6_cidr_blocks = null
      prefix_list_ids  = null
      protocol         = "TCP"
      security_groups  = null
      self             = false
      to_port          = 80
    }
  ]
  name = "${var.commercial}-${var.env}-documentdb"
  //revoke_rules_on_delete = false
  tags = {
    Name = "${var.commercial}-${var.env}-documentdb"
  }
  vpc_id = "vpc-04f7bed7e96b68d0a"
}

####################################################################################################
# DocumentDB Cluster + Instancias ##################################################################
####################################################################################################

# thn-stg-docdb-nostromo-cluster
# import --> terraform import aws_docdb_cluster.thn-stg-docdb-nostromo-cluster thn-stg-docdb-nostromo-cluster

resource "aws_docdb_cluster" "thn-stg-docdb-nostromo-cluster" {
  count                           = 1 // este COUNT sirve para indicarle la cantidad de miembros hijos (instancias) que tiene este cluster. 1 instancia pero el VALOR REAL DE COUNT es 0
  apply_immediately               = null
  availability_zones              = slice(var.aws_region, 1, 4) # devuelve la lista de la variable, desde la posición elegida y escoge hasta la siguiente posición elegida
  backup_retention_period         = 1
  cluster_identifier              = "${var.commercial}-${var.env}-${var.engine}-nostromo-cluster"
  cluster_members                 = ["${var.commercial}-${var.env}-${var.engine}-nostromo${var.nodes}${count.index + 1}"]
  db_cluster_parameter_group_name = "${var.commercial}-${var.env}-mongodb"
  db_subnet_group_name            = "${var.commercial}-${var.env}-generic-db"
  deletion_protection             = true
  engine                          = var.engine
  engine_version                  = var.eng_ver[0]
  final_snapshot_identifier       = null
  master_password                 = var.pwd
  master_username                 = var.users[0]
  port                            = "27017"
  preferred_backup_window         = "00:00-00:30"
  preferred_maintenance_window    = "wed:03:15-wed:03:45"
  skip_final_snapshot             = true
  storage_encrypted               = false
  vpc_security_group_ids          = ["aws_security_group.docdb-segurity-group.id"] //["sg-010417d211ab8cd46"]
}

# thn-stg-docdb-nostromo-node01
# import --> terraform import aws_docdb_cluster_instance.thn-stg-docdb-nostromo-node01 thn-stg-docdb-nostromo-node01

resource "aws_docdb_cluster_instance" "thn-stg-docdb-nostromo-node01" {
  count                        = 1 // A este cluster solo se le añade una instancia. El valor de COUNT REAL es 0.
  apply_immediately            = null
  auto_minor_version_upgrade   = true
  availability_zone            = var.aws_region[3]
  ca_cert_identifier           = var.ca_cert
  cluster_identifier           = "${var.commercial}-${var.env}-${var.engine}-nostromo-cluster"
  engine                       = var.engine
  identifier                   = "${var.commercial}-${var.env}-${var.engine}-nostromo${var.nodes}${count.index + 1}" // Como el valor REAL de COUNT es 0, le sumamos uno para que el primer nodo sea 01, en lugar de 00 que sería el comportamiento por defecto.
  instance_class               = var.inst_class[0]
  preferred_maintenance_window = "wed:03:15-wed:03:45"
  promotion_tier               = var.tier[1]
}


###############
# thn-dyn-docdb-nostromo-cluster
# import --> terraform import aws_docdb_cluster.thn-dyn-docdb-nostromo-cluster thn-dyn-docdb-nostromo-cluster

resource "aws_docdb_cluster" "thn-dyn-docdb-nostromo-cluster" {
  apply_immediately               = null
  availability_zones              = slice(var.aws_region, 1, 4) # devuelve la lista de la variable, desde la posición elegida y escoge hasta la siguiente posición elegida
  backup_retention_period         = 1
  cluster_identifier              = "${var.commercial}-dyn-${var.engine}-nostromo-cluster"
  cluster_members                 = ["${var.commercial}-dyn-${var.engine}-nostromo-cluster"]
  db_cluster_parameter_group_name = "${var.commercial}-dyn-mongodb"
  db_subnet_group_name            = "${var.commercial}-${var.env}-generic-db"
  deletion_protection             = false
  engine                          = var.engine
  engine_version                  = var.eng_ver[0]
  final_snapshot_identifier       = null
  master_password                 = var.pwd
  master_username                 = var.users[0]
  port                            = "27017"
  preferred_backup_window         = "00:00-00:30"
  preferred_maintenance_window    = "tue:01:37-tue:02:07"
  skip_final_snapshot             = true
  storage_encrypted               = false
  vpc_security_group_ids          = ["aws_security_group.docdb-segurity-group.id"] //["sg-010417d211ab8cd46"]
}

#import --> terraform import aws_docdb_cluster_instance.thn-dyn-docdb-nostromo-cluster thn-dyn-docdb-nostromo-cluster
resource "aws_docdb_cluster_instance" "thn-dyn-docdb-nostromo-cluster" {
  //count                        = 1
  apply_immediately            = null
  auto_minor_version_upgrade   = true
  availability_zone            = var.aws_region[1]
  ca_cert_identifier           = var.ca_cert
  cluster_identifier           = "${var.commercial}-dyn-${var.engine}-nostromo-cluster"
  engine                       = var.engine
  identifier                   = "${var.commercial}-dyn-${var.engine}-nostromo-cluster" //${var.nodes}${count.index + 1}"
  instance_class               = var.inst_class[0]
  preferred_maintenance_window = "sun:02:19-sun:02:49"
  promotion_tier               = var.tier[1]
}
