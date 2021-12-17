#!/bin/bash

zenity --list \
	--checklist \
	--width 200 \
	--height 100 \
	--column "SELECT" \
	--column "PROCESSO" \
	FALSE ps \

zenity --question --text="Deseja exibir o gerenciador de processos?" \
	--ok-label="Sim" \
	--cancel-label="Não"
if [ $? == 0 ]; then
	zenity --list \
		--title="Gerenciamento de Processos" \
		--column="Processos" \
		--width 700 \
		--height 500 \
		$(/usr/bin/ps)
			
else
  zenity --info --text="Programa encerrado!" \
		--width 300 \
		--height 50
fi

