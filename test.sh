n=4
result=
for i in $(seq 0 $(($n > 0? $n-1: 0))); do
  result+="rank-$i"
  result+=" "
done
echo $result