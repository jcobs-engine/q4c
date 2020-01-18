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
echo -e "\033[0m"

tput cup 3 1
echo -en "\033[1;37mVOCABULARY-LIMIT:\033[0m"

verify='0'
a=0
while [ $COLUMNS -ge $a ]; do
    tput cup 4 $a
    echo -en "\033[1;44;37m "
    a=$(( $a + 1 ))
done

tput cup 4 1
echo '0'
tput cup 4 1
tput cnorm
read limit
tput civis

no=$( shuf -o $cards $cards )
tput civis
echo -e "\033[0m"
num=$( cat $cards | wc -l )

if [ "$limit" != "" ] && [ "$limit" != "0" ] ; then
    if [ $limit -lt $num ]; then
	num=$limit
    fi
fi

i=1
r=0
t=0
pz=0
marka=6
marki=0
while [ $i -le $num ]; do
    es='n'
    clear

    if [ $i -ne 1 ]; then
	pzn=0
	while [ $pzn -le $pz ]; do
	    tput cup $LINES $pzn
	    echo -en "\033[0;42m \033[0m"
	    pzn=$(( $pzn + 1 ))
	done
    fi

    com=$( head -n$i $cards | tail -n1 )
    IFS='~' read -r -a array <<< $com

    a=0
    while [ $COLUMNS -ge $a ]; do
	tput cup 0 $a
	echo -en "\033[0;44;37m "
	a=$(( $a + 1 ))
    done
    tput cup 0 1
    echo -e "\033[1;44;37m"${array[1]}"\033[0m"

    str=" $r/$t  $marka "
    strl=${#str}
    
    tput cup 0 $(( $COLUMNS - $strl ))
    echo -e "\033[1;46;32m $r\033[30m/\033[35m$t \033[40;31m $marka  \033[0m"

    real=${array[3]}

    a=0
    while [ $COLUMNS -ge $a ]; do
	tput cup 1 $a
	echo -en "\033[0;47;30m "
	a=$(( $a + 1 ))
    done
    
    tput cup 1 0
    tput cnorm
    read -p " " ans

    if [ "$ans" == "q" ] || [ "$ans" == "Q" ]; then
	exit
    fi
        
    tput civis
    echo -en "\033[0m"

    pz=$(( $i * $COLUMNS / $num ))
    pzn=0
    while [ $pzn -le $pz ]; do
	tput cup $LINES $pzn
	echo -en "\033[0;42m \033[0m"
	pzn=$(( $pzn + 1 ))
    done

    realc=$real
    
    reala='.'${real// /.}'.'
    
    real=${real//','/ }
    real=${real//';'/ }
    real=${real//':'/ }
    real=${real//'/'/ }
    real=${real//'('/ }
    real=${real//')'/ }
    
    ans=${ans//','/ }
    ans=${ans//';'/ }
    ans=${ans//':'/ }
    ans=${ans//'/'/ }
    ans=${ans//'('/ }
    ans=${ans//')'/ }

    
    realc=${realc//','/ }
    realc=${realc//';'/ }
    realc=${realc//':'/ }
    realc=${realc//'/'/ }
    realc=${realc//'('/ }
    realc=${realc//')'/ }
    
    IFS=' ' read -r -a ansc <<< $ans
    IFS=' ' read -r -a realc <<< $realc
    
    for realci in ${realc[@]}; do
	for ansci in ${ansc[@]}; do
	    anscs=$( echo $ansci|tr [:upper:] [:lower:] )
	    realcs=$( echo $realci|tr [:upper:] [:lower:] )
	    if [ "$anscs" == "$realcs" ]; then
		ans=${ans//$ansci/$realci}
	    fi
	done
    done
    

    
    IFS=' ' read -r -a ans <<< $ans
    
    for ansi in ${ans[@]}; do
	anso=$ansi

	if [[ " $real " =~ " $ansi " ]]; then
	    es='y'
	    reala=${reala//.$ansi./'.\033[47m'$anso'\033[0;42;30m.'}
	    reala=${reala//:$ansi./':\033[47m'$anso'\033[0;42;30m.'}
	    reala=${reala//.$ansi:/'.\033[47m'$anso'\033[0;42;30m:'}
	    reala=${reala//:$ansi:/':\033[47m'$anso'\033[0;42;30m:'}
	    reala=${reala//,$ansi./',\033[47m'$anso'\033[0;42;30m.'}
	    reala=${reala//.$ansi,/'.\033[47m'$anso'\033[0;42;30m,'}
	    reala=${reala//,$ansi:/',\033[47m'$anso'\033[0;42;30m:'}
	    reala=${reala//:$ansi,/':\033[47m'$anso'\033[0;42;30m,'}
	    reala=${reala//,$ansi,/',\033[47m'$anso'\033[0;42;30m,'}
	    reala=${reala//,$ansi;/',\033[47m'$anso'\033[0;42;30m;'}
	    reala=${reala//;$ansi,/';\033[47m'$anso'\033[0;42;30m,'}
	    reala=${reala//.$ansi;/'.\033[47m'$anso'\033[0;42;30m;'}
	    reala=${reala//;$ansi./';\033[47m'$anso'\033[0;42;30m.'}
	    reala=${reala//:$ansi;/':\033[47m'$anso'\033[0;42;30m;'}
	    reala=${reala//;$ansi:/';\033[47m'$anso'\033[0;42;30m:'}
	    reala=${reala//;$ansi;/';\033[47m'$anso'\033[0;42;30m;'}
	    reala=${reala//,$ansi'/'/',\033[47m'$anso'\033[0;42;30m/'}
	    reala=${reala//'/'$ansi,/'/\033[47m'$anso'\033[0;42;30m,'}
	    reala=${reala//;$ansi'/'/';\033[47m'$anso'\033[0;42;30m/'}
	    reala=${reala//'/'$ansi;/'/\033[47m'$anso'\033[0;42;30m;'}
	    reala=${reala//.$ansi'/'/'.\033[47m'$anso'\033[0;42;30m/'}
	    reala=${reala//'/'$ansi./'/\033[47m'$anso'\033[0;42;30m.'}
	    reala=${reala//:$ansi'/'/':\033[47m'$anso'\033[0;42;30m/'}
	    reala=${reala//'/'$ansi:/'/\033[47m'$anso'\033[0;42;30m:'}
	    reala=${reala//'/'$ansi'/'/'/\033[47m'$anso'\033[0;42;30m/'}
	    reala=${reala//'('$ansi'.'/'(\033[47m'$anso'\033[0;42;30m.'}
	    reala=${reala//'.'$ansi')'/'.\033[47m'$anso'\033[0;42;30m)'}
	    reala=${reala//'('$ansi','/'(\033[47m'$anso'\033[0;42;30m,'}
	    reala=${reala//','$ansi')'/',\033[47m'$anso'\033[0;42;30m)'}
	    reala=${reala//'('$ansi';'/'(\033[47m'$anso'\033[0;42;30m;'}
	    reala=${reala//';'$ansi')'/';\033[47m'$anso'\033[0;42;30m)'}
	    reala=${reala//'('$ansi'/'/'(\033[47m'$anso'\033[0;42;30m/'}
	    reala=${reala//'/'$ansi')'/'/\033[47m'$anso'\033[0;42;30m)'}
	    reala=${reala//'('$ansi':'/'(\033[47m'$anso'\033[0;42;30m:'}
	    reala=${reala//':'$ansi')'/':\033[47m'$anso'\033[0;42;30m)'}
	    reala=${reala//'('$ansi')'/'(\033[47m'$anso'\033[0;42;30m)'}
	fi
    done

    reala=${reala//./ }
    reala=${reala%?}
    reala=${reala:1}

    result=$reala
    
    col=1
    sl=2
    if [ "$es" == 'y' ] && [ "$ans" != "" ]; then
	r=$(( $r + 1 ))
	col=2
	sl=1
    else
	ans=""
    fi

    t=$(( $t + 1 ))
    
    if [ $t -gt 0 ]; then
	marki=$(( $r * 100 / $t ))
    else
	marki=0
    fi

    if [ $marki -ge 90 ] && [ $marki -le 100 ]; then
	marka=1
    elif [ $marki -ge 70 ] && [ $marki -le 89 ]; then
	marka=2
    elif [ $marki -ge 50 ] && [ $marki -le 69 ]; then
	marka=3
    elif [ $marki -ge 30 ] && [ $marki -le 49 ]; then
	marka=4
    elif [ $marki -ge 10 ] && [ $marki -le 29 ]; then
	marka=5
    elif [ $marki -ge 0 ] && [ $marki -le 9 ]; then
	marka=6
    fi

    str=" $r/$t  $marka "
    strl=${#str}
    
    tput cup 0 $(( $COLUMNS - $strl ))
    echo -e "\033[1;46;32m $r\033[30m/\033[35m$t \033[40;31m $marka  \033[0m"
    

    
    a=0
    while [ $COLUMNS -ge $a ]; do
	tput cup 1 $a
	echo -en "\033[0;4$col;30m "
	a=$(( $a + 1 ))
    done

    tput cup 1 1
    echo -en $result"\033[0m"

    sleep $sl
    
    i=$(( $i + 1 ))
done
tput cup $(( $LINES / 2 )) $(( $COLUMNS / 2 - 12 ))
echo -en "\033[0;1mPRESS ANY KEY TO FINISH\033[0m"
read -sn1 ready
tput cnorm
clear
