# Terraform Mapas
Vamos a modificar el ami del servidor para crear un mapa
- type = map(string)

## Ejercicio
Creamos el mapa en el fichero de variables.tf y modificamos las zonas de los servidores

# Terraform Condiciones
- Validation
    - condition = forma booleana true o folse
    - error message = Descipción
- Podemos probar el error con
    - terraform apply -var="server_port=70000"
