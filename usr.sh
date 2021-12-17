#!/bin/bash

arqusr=$(ps -U $USER)
user=$(echo $USER)

zenity --forms --title="Processos por usuário" \
        --add-entry="Você deseja ver os processos de qual usuário?"
        if [ $usr == $user ]; then
                cat $arqusr
        else 
              zenity --info --text="Usuário inexistente!"
fi

usr=$(cut -f 1)
