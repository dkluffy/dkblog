echo "Bash version ${BASH_VERSION}..."
for i in {0..10..2}
  do
     echo "Welcome $i times"
done

START=1
END=5
for i in $(eval echo "{$START..$END}")
do
        echo "$i"
done

for i in $(seq 1 2 20)
do
   echo "Welcome $i times"
done


for (( c=1; c<=5; c++ ))
do
   echo "Welcome $c times"
done



START=1
END=5
## save $START, just in case if we need it later ##
i=$START
while [[ $i -le $END ]]
do
    echo "$i"
    ((i = i + 1))
done


## define an array ##
arrayname=( Dell HP Oracle )
 
## get item count using ${arrayname[@]} ##
for m in "${arrayname[@]}"
do
  echo "${m}"
  # do something on $m #
done


for i in 1 2 3 4 5
do
   echo "Welcome $i times"
done
