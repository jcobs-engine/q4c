#!/bin/bash
tput civis
echo -e "\033[0m"
clear

tput cup 0 1
echo -en "\033[1;37mFILE:\033[0m"

verify='0'
while [ $verify -eq 0 ]; do
    a=0
    while [ $COLUMNS -ge $a ]; do
	tput cup 1 $a
	echo -en "\033[1;44;37m "
	a=$(( $a + 1 ))
    done

    tput cup 1 1
    tput cnorm
    read cards
    tput civis
    cards="mybox/$cards.cards"
    verify=$( dir $cards 2>&1 )
    if [[ "$verify" =~ "such" ]]; then
	verify=0
    else
	verify=1
    fi
        
done
echo -en "\033[0m"
tput civis
while [ 1 ]; do
    clear
    
    num=$( cat $cards | wc -l )
    
    a=0
    while [ $COLUMNS -ge $a ]; do
	tput cup 0 $a
	echo -en "\033[0;43;37m "
	a=$(( $a + 1 ))
    done
    
    tput cup 0 1
    echo -en "\033[1;43;37m"
    tput cnorm
    read ask

    if [ "$ask" == "q" ] || [ "$ask" == "Q" ]; then
	exit
    fi

    tput civis
    echo -en "\033[0m"
    
    tput cup 2 0
    
    ask=$( echo $ask|tr [:upper:] [:lower:] )	
    
    pzo=0
    pz=0
    g=0
    while [ $g -le $COLUMNS ]; do
	eval 'pcol'$g=1	
	g=$(( $g +  1 ))	
    done

    
    b=2
    i=1
    while [ $i -le $num ]; do
	break=0
	com=$( head -n$i $cards | tail -n1 )
	IFS='~' read -r -a first <<< $com
	IFS='~' read -r -a second <<< $com
	
	first=${first[1]}
	second=${second[3]}
	
	firsti=${first//,/ }
	secondi=${second//,/ }
	
	firsti=$( echo $firsti|tr [:upper:] [:lower:] )
	secondi=$( echo $secondi|tr [:upper:] [:lower:] )

	pz=$(( $i * $COLUMNS / $num ))

	IFS=' ' read -r -a aski <<< $ask
	go=0
	for ask in ${aski[@]}; do
	    
	    if [[ "$firsti" =~ "$ask" ]] || [[ "$secondi" =~ "$ask" ]]; then
		
		go=1
		eval 'pcol'$pz='2'
		
	    fi
	done
	
	if [ $go -eq 1 ]; then
	    a=0
	    while [ $COLUMNS -ge $a ]; do
		tput cup 1 $a
		echo -en "\033[0;4m "
		a=$(( $a + 1 ))
	    done
	    
	    a=0
	    while [ $(( $COLUMNS / 2 )) -ge $a ]; do
		tput cup $b $a
		echo -en "\033[4;44;37m "
		a=$(( $a + 1 ))
	    done
	    
	    while [ $COLUMNS -ge $a ]; do
		tput cup $b $a
		echo -en "\033[4;42;37m "
		a=$(( $a + 1 ))
	    done
	    
	    tput cup $b 1
	    echo -en "\033[1;4;44;37m"
	    echo $first | cut -c 1-$(( $COLUMNS / 2 - 2 ))
	    echo -en "\033[0m"
	    tput cup $b $(( $COLUMNS / 2 + 2 ))
	    echo -en "\033[1;4;42;37m"
	    echo $second | cut -c 1-$(( $COLUMNS / 2 - 2 ))
	    echo -en "\033[0m"
	    
	    if [ $b -ge $(( $LINES - 3 )) ]; then
		b=1
		tput cup 0 $(( $COLUMNS - 37 ))
		echo -en "\033[1;37;40m [ENTER] for next page, [R] to break \033[0m"

		read -sn1 nix
		
		tput cup 0 $(( $COLUMNS - 37 ))
		echo -en "\033[1;37;43m                                     \033[0m"

		if [ "$nix" == "r" ] || [ "$nix" == "R" ]; then
		    break=1
		    break;
		fi
		a=1
		while [ $(( $LINES - 2 )) -ge $a ]; do
		    c=0
		    while [ $COLUMNS -ge $c ]; do
			tput cup $a $c
			echo -en "\033[0m "
			c=$(( $c + 1 ))
		    done
		    a=$(( $a + 1 ))
		done

	    fi
	    b=$(( $b + 1 ))
	fi
	
	
	
	pcoly="pcol"$pz
	
	o=$pzo
	if [ $o -eq $pz ]; then
	    o=$(( $o - 1 ))
	fi
	
	while [ $o -lt $pz ]; do
	    if [ $o -lt 0 ]; then
		o=0
	    fi
	    
	    tput cup $LINES $o
	    echo -en "\033[0;4"${!pcoly}"m \033[0m"
	    ps=1
	    o=$(( $o + 1 ))
	done
	
	pzo=$pz
	
	i=$(( $i + 1 ))
    done
    
    if [ $break -ne 1 ]; then
	read -sn1 halo
    fi
    
    a=$COLUMNS
    while [ $a -ge 0 ]; do
	tput cup $LINES $a
	echo -en "\033[0m \033[0m"
	a=$(( $a - 1 ))
    done
    
done

tput cnorm
