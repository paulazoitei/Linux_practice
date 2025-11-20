#!/bin/bash


start=`date +%s.%N`


shopt -s globstar
counter=0

for d in ./work/**/; do

    count=$(cd "$d" && grep -oi 'engineer' * 2>/dev/null | wc -w  );
    ((counter+=count))
done

end=`date +%s.%N`
echo $counter

runtime=$( echo "$end - $start"| bc -l)
echo $runtime
