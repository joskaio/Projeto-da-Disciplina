#!/bin/bash

V=1

while [ $V -eq 1 ]; do

ps --no-headers -U $USER -o pid,pid,user,pmem,pcpu,comm | sed -r 's/^[]+//;s/[]{2,}/ /g' > arq.txt
	wait;
ger=$(zenity --list \
	--title="Gerenciamento de Processos" \
	--column="PID" \
	--column="Usuário" \
 	--column="USER" \
	--column="MEM" \
	--column="CPU" \
	--column="Processo" $(cat arq.txt) 2>/dev/null \
	--cancel-label="Fechar" \
	--extra-button="Matar processo" \
	--extra-button="Pesquisando um processo" \
	--extra-button="Processos por usuário" \
	--width=600 \
	--height=530)		    
	if [ "$ger" == "Pesquisando um processo" ]; then
		pes=$(zenity --forms --title="Exibindo um processo" \
			--text="Qual processo você deseja exibir?"  \
			--add-entry="Processo:")
		if [ -n "$(ps aux | grep $pes | grep -v grep)" ]; then
			zenity --list --title="$pes" --column="$(ps aux | grep $pes | grep -v grep)" --width=600 --height=530
	#	else
	#		zenity --info --title="ERRO" --text="Processo inexistente!"
	#BUG: Mesmo se o usuário apertar em "Cancelar", o programa irá exibir a tela de "Processo inexistente!"
		fi

	elif [ "$ger" == "Processos por usuário" ]; then
		nome=$(zenity --forms --title="Processos do usuário" \
			--text="Qual processo você deseja exibir?" \
			--add-entry="Usuário:")
		if [ "$nome" ]; then
			grep -q "$nome" /etc/passwd && zenity --list --column="$(ps -U "$nome")" --width=600 --height=530
		fi
	elif [ "$ger" == "Matar processo" ]; then
		PID=$(zenity --forms --text="Qual processo você deseja encerrar?" \
			--add-entry="PID:")
		if [ "$?" -eq 0 -a -n "$PID" ]; then
			ps aux | grep -Eq "^$USER [ ]+$PID" && { zenity --info --text="${PID} encerrado!"; kill "${PID}"; } || zenity --info --text="Este processo não existe!"
		fi	
	
	elif [ $? == 1 ]; then
		break 	
	fi
done	
