#!/bin/bash

# Solicitar el nombre del departamento
echo "Por favor, ingrese el nombre del departamento:"
read departamento

# Crear el grupo con el nombre del departamento
groupadd $departamento
echo "Grupo '$departamento' creado."

# Solicitar cuántos usuarios se crearán
echo "¿Cuántos usuarios desea crear para el departamento '$departamento'?"
read num_usuarios

# Crear los usuarios y asignarles contraseñas
for ((i=1; i<=num_usuarios; i++))
do
    echo "Ingrese el nombre del usuario $i:"
    read usuario

    # Crear el usuario en el sistema y asignarlo al grupo del departamento
    useradd -m -g $departamento -d /home/$usuario $usuario
    echo "Usuario '$usuario' creado."

    # Preguntar si se quiere establecer una contraseña personalizada
    echo "¿Desea establecer una contraseña personalizada para el usuario '$usuario'? (si/no)"
    read respuesta

    if [[ $respuesta == "si" || $respuesta == "SI" || $respuesta == "Sí" || $respuesta == "sí" ]]; then
        echo "Ingrese la contraseña para '$usuario':"
        read -s contrasena
        # Establecer la contraseña proporcionada
        echo "$usuario:$contrasena" | chpasswd
    else
        # Si no se especifica contraseña, se pone por defecto 1234
        echo "$usuario:1234" | chpasswd
        echo "Contraseña por defecto (1234) asignada a '$usuario'."
    fi
done

# Confirmación
echo "Todos los usuarios del departamento '$departamento' han sido creados exitosamente."
