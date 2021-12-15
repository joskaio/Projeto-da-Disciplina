#!/bin/bash

usr=$(ps -U $USER)
t=$(top -bn1 > arq.txt)

zenity --question --text="Deseja exibir o gerenciador de processos?" 
if [ $? == 0 ]; then
      zenity --list \
	    --title="Gerenciamento de Processos" \
	    --column="Processos" \
	    "$(cat arq.txt)";
	    zenity --info --title="Gerenciamento por usuário" \
else
  zenity --info --text="Programa encerrado!"
fi
