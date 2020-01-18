#!/bin/bash
cards=''

tput civis
echo -e "\033[0m"
clear

tput cup 0 1
echo -en "\033[1;37mNAME:\033[0m"

a=0
while [ $COLUMNS -ge $a ]; do
    tput cup 1 $a
    echo -en "\033[1;44;37m "
    a=$(( $a + 1 ))
done

while [ "$cards" == "" ]; do
    tput cup 1 1
    tput cnorm
    read cards
    tput civis
done
name="mybox/$cards.cards"
rm $name 2>&1

echo -en "\033[0m"

while [ 1 ]; do
    clear

    tput cup $LINES $(( $COLUMNS - 21 ))
    echo -en "\033[0m[R]: Karte verwerfen"
    
    tput cup 0 1
    echo -en "\033[0mFRAGE:\033[0m"

    a=0
    while [ $COLUMNS -ge $a ]; do
	tput cup 1 $a
	echo -en "\033[0;44;37m \033[0m"
	a=$(( $a + 1 ))
    done
    
    tput cup 3 1
    echo -en "\033[0mANTWORT:\033[0m"
    
    a=0
    while [ $COLUMNS -ge $a ]; do
	tput cup 4 $a
	echo -en "\033[0;42;37m \033[0m"
	a=$(( $a + 1 ))
    done

    ask=''
    ans=''
    
    echo -en "\033[0;44;37;1m"
    while [ "$ask" == "" ]; do
	tput cup 1 1
	tput cnorm
	read ask
	if [ "$ask" == "q" ] || [ "$ans" == "Q" ]; then
	    exit
	fi
	tput civis
    done

    if [ "$ask" != "r" ] && [ "$ask" != "R" ]; then
        echo -en "\033[0;42;37;1m"
        while [ "$ans" == "" ]; do
	    tput cup 4 1
	    tput cnorm
	    read ans
	    if [ "$ans" == "q" ] || [ "$ans" == "Q" ]; then
		exit
	    fi
	    tput civis
	done
    fi

   
    sleep 0.1

    if [ "$ask" == "r" ] || [ "$ask" == "R" ] || [ "$ans" == "r" ] || [ "$ans" == "R" ]; then
	echo -en "\033[41m"
    else
       	( echo '[[~'$ask'~]]|[[~'$ans'~]]' >> $name ) 2>&1
	echo -en "\033[42m"
    fi
    
    clear
    sleep 0.5
    echo -en "\033[0m"
done
clear
tput cnorm
