#!/bin/bash
while [ 1 ]; do
    tput civis

    start=''
    echo -en "\033[0m"
    clear

    a=0
    while [ $(( $COLUMNS - 44 )) -ge $a ]; do
	tput cup 3 $a
	echo -en "\033[42m "
	a=$(( $a + 1 ))
    done

    a=0
    while [ $(( $COLUMNS - 44 )) -ge $a ]; do
	tput cup 4 $a
	echo -en "\033[43m "
	a=$(( $a + 1 ))
    done

    a=0
    while [ $(( $COLUMNS - 44 )) -ge $a ]; do
	tput cup 6 $a
	echo -en "\033[41m "
	a=$(( $a + 1 ))
    done

    a=0
    while [ $(( $COLUMNS - 44 )) -ge $a ]; do
	tput cup 8 $a
	echo -en "\033[44m "
	a=$(( $a + 1 ))
    done
    
    a=0
    while [ $(( $COLUMNS - 44 )) -ge $a ]; do
	tput cup 9 $a
	echo -en "\033[46m "
	a=$(( $a + 1 ))
    done
    
    tput cup 3 1
    echo -en "\033[0;42m[0]:\033[1m Lernen"
    tput cup 4 1
    echo -en "\033[0;43m[1]:\033[1m Nachschlagen"
    tput cup 6 1
    echo -en "\033[0;41m[2]:\033[1m Erstellen"
    tput cup 8 1
    echo -en "\033[0;44m[3]:\033[1m Importieren"	
    tput cup 9 1
    echo -en "\033[0;46m[4]:\033[1m Exportieren"

    a=0
    while [ $COLUMNS -ge $a ]; do
	tput cup 0 $a
	echo -en "\033[47m "
	a=$(( $a + 1 ))
    done

    a=0
    while [ $COLUMNS -ge $a ]; do
	tput cup 12 $a
	echo -en "\033[47m "
	a=$(( $a + 1 ))
    done

    tput cup 0 1
    echo -en "\033[0;1;47;2;30mQuizlet for Console"
    
    tput cup 12 1
    echo -en "\033[0;47;2;3;30m©2020 by JcobsEngine.\033[0m"

        b=0
    while [ $b -le 11 ]; do
	a=$(( $COLUMNS - 43 ))
	while [ $COLUMNS -ge $a ]; do
	    tput cup $b $a
	    echo -en "\033[47m "
	    a=$(( $a + 1 ))
	done
	b=$(( $b + 1 ))
    done
    

    
    tput cup 1 $(( $COLUMNS - 43 ))
    echo -en "\033[0;1;47;30m+-----------------------------------------+"
    tput cup 2 $(( $COLUMNS - 43 ))
    echo -en "\033[0;1;47;30m|\033[34m                                         \033[30m|"
    tput cup 3 $(( $COLUMNS - 43 ))
    echo -en "\033[0;1;47;30m|\033[34m    .oooooo.          .o      .oooooo.   \033[30m|"
    tput cup 4 $(( $COLUMNS - 43 ))
    echo -en "\033[0;1;47;30m|\033[34m   d8P'  'Y8b       .d88     d8P'  'Y8b  \033[30m|"
    tput cup 5 $(( $COLUMNS - 43 ))
    echo -en "\033[0;1;47;30m|\033[34m  888      888    .d'888    888          \033[30m|"
    tput cup 6 $(( $COLUMNS - 43 ))
    echo -en "\033[0;1;47;30m|\033[34m  888      888  .d'  888    888          \033[30m|"
    tput cup 7 $(( $COLUMNS - 43 ))
    echo -en "\033[0;1;47;30m|\033[34m  888      888  88ooo888oo  888          \033[30m|"
    tput cup 8 $(( $COLUMNS - 43 ))
    echo -en "\033[0;1;47;30m|\033[34m  '88b    d88b       888    '88b    ooo  \033[30m|"
    tput cup 9 $(( $COLUMNS - 43 ))
    echo -en "\033[0;1;47;30m|\033[34m   'Y8bood8P'Ybd'   o888o    'Y8bood8P'  \033[30m|"
    tput cup 10 $(( $COLUMNS - 43 ))
    echo -en "\033[0;1;47;30m|\033[34m                                         \033[30m|"
    tput cup 11 $(( $COLUMNS - 43 ))
    echo -en "\033[0;1;47;30m+-----------------------------------------+"

    echo -en "\033[0m"

    while [ "$start" == "" ]; do
	read -sn1 start
    done
    

    if [ "$start" == "0" ]; then
	bash learn.sh
    fi

    if [ "$start" == "1" ]; then
	bash show.sh
    fi
    
    if [ "$start" == "2" ]; then
	bash create.sh
    fi
    
    if [ "$start" == "3" ]; then
	bash import.sh
    fi
    
    if [ "$start" == "4" ]; then
	bash export.sh
    fi

    
done
