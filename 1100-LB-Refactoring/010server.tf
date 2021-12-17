resource "aws_instance" "my_server" {
    for_each = var.severs_system
    ami = local.ami
    instance_type = var.server_type
    user_data = <<-EOF
                    #! /bin/bash
                    sudo apt-get update
                    sudo apt-get install -y apache2
                    sudo systemctl start apache2
                    sudo systemctl enable apache2
                    echo "<h1>Deployed via Terraform server ${each.value.name}</h1>" | sudo tee /var/www/html/index.html
                    EOF
    vpc_security_group_ids = [aws_security_group.web-sg.id]
    subnet_id = data.aws_subnet.public_subnet[each.key].id
    tags = {
        Name = each.value.name
    }

  
}