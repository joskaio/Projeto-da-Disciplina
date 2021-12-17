#!/bin/bash

t=$(ps aux > arq.txt)

zenity --question --text="Deseja exibir o gerenciador de processos?" \
	--ok-label="Sim"
	--cancel-label="Não"
if [ $? == 0 ]; then
      zenity --list \
	    --title="Gerenciamento de Processos" \
	    --column="Processos" \
	    "$(cat arq.txt)";
	    zenity --info --title="Gerenciamento por usuário" \
else
  zenity --info --text="Programa encerrado!"
fi
