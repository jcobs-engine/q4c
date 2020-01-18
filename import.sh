<?php
tput civis

while [ 1 ]; do
    echo -en "\033[0m"
    clear

    number=''
    outname=''
    
    
    tput cup 0 1
    echo -en "\033[3mGehe auf die Seite \033[1;4;34mhttps://www.levi-jacobs.de/q4c/\033[0;3m"
    tput cup 1 1
    echo -en "Fülle die Felder aus und sende das Formular ab.\033[0m"

    tput cup 3 1
    echo -en "\033[0mImport-Nummer:\033[0m"
    
    a=0
    while [ $COLUMNS -ge $a ]; do
	tput cup 4 $a
	echo -en "\033[1;44;37m "
	a=$(( $a + 1 ))
    done

    tput cup 6 1
    echo -en "\033[0mName:"
    
    a=0
    while [ $COLUMNS -ge $a ]; do
	tput cup 7 $a
	echo -en "\033[1;41;37m "
	a=$(( $a + 1 ))
    done

    while [ "$number" == "" ]; do
	echo -en "\033[1;44;37m"
	tput cup 4 1
	tput cnorm
	read number
	if [ "$number" == "q" ] || [ "$number" == "Q" ]; then
	    exit
	fi
	tput civis
    done
        
    while [ "$outname" == "" ]; do
	echo -en "\033[1;41;37m"
	tput cup 7 1
	tput cnorm
	read outname
	if [ "$outname" == "q" ] || [ "$outname" == "Q" ]; then
	    exit
	fi
	tput civis
    done

    outname='mybox/'$outname'.cards';

    contenta=$( curl "https://www.levi-jacobs.de/q4c/imports/$number"  2>/dev/null )

    if [ "$contenta" != "" ] && [[ ! "$contenta" =~ "!DOCTYPE" ]]; then
	echo -en "\033[0;42m"
	echo "$contenta" > $outname
    else
	echo -en "\033[0;41m"
    fi
    clear
    sleep 0.5
        
done
