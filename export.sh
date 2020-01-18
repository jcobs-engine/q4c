<?php
tput civis

while [ 1 ]; do
    echo -en "\033[0m"
    clear

    input=''
    outname=''
    
    
    tput cup 0 1
    echo -en "\033[3mExportiere deine Vokabeln für \033[1;4;34mhttps://www.wikicardia.de\033[0;3m"
    
    tput cup 2 1
    echo -en "\033[0mInput-Datei:\033[0m"
    

    tput cup 5 1
    echo -en "\033[0mName:"
    
    a=0
    while [ $COLUMNS -ge $a ]; do
	tput cup 6 $a
	echo -en "\033[1;41;37m "
	a=$(( $a + 1 ))
    done

    verify='0'
    while [ $verify -eq 0 ]; do
	a=0
	while [ $COLUMNS -ge $a ]; do
	    tput cup 3 $a
	    echo -en "\033[1;44;37m "
	    a=$(( $a + 1 ))
	done

	tput cup 3 1
	tput cnorm
	echo -en "\033[1;44;37m"
	read input
	if [ "$input" == "q" ] || [ "$input" == "Q" ]; then
	    exit
	fi
	tput civis
	input="mybox/$input.cards"
	verify=$( dir $input 2>&1 )
	if [[ "$verify" =~ "such" ]]; then
	    verify=0
	else
	    verify=1
	fi
    done
    
    tput cup 6 1
    tput cnorm
    echo -en "\033[1;41;37m"
    read output
    if [ "$output" == "q" ] || [ "$output" == "Q" ]; then
	exit
    fi
    tput civis

    output='mybox/wikicardia_'$output'.txt'
    
    input=$( cat $input )
    input=${input//'~]]|[[~'/'[a]'}
    input=${input//'[[~'/'[f]'}
    input=${input//'~]]'/'\n'}

    echo -e $input > $output
    
    echo -en "\033[0;42m"
    clear
    sleep 0.5
done
