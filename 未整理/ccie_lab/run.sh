#!/bin/sh

startvm(){
    id=$1
    img=./r.img
    opt=" "
    if [[ $(expr match "$id" '^n') -gt 0 ]]
    then
        id=${id:1}
        cid=$(printf "%.2d" $id)
        rm -f "nvram_000$cid"
    fi

    [[ ($id -gt 40) && ($id -lt 50) ]] && img=./sw.img
    [ $id -eq 41 ] && opt="-e 5"
    [ $id -eq 42 ] && opt="-e 5"
    [ $id -eq 43 ] && opt="-e 5"
    [ $id -eq 44 ] && opt="-e 5"

    opt=$opt" -c conf/$id $id"
    #./wrapper-linux -m $img -p $((2000+id)) -- $opt
    ./wrapper-linux -m $img -p $((2000+id)) -- $opt > /dev/null 2>&1 &

    echo "router id="$id" is runing..."
}

while [[ $1 ]] ;do
    echo "Starting router id="$1"..."
    startvm $1
    shift
done
