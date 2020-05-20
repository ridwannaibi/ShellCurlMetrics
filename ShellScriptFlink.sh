curl -G 'http://localhost:8086/query?pretty=true' --data-urlencode "db=telegraf" --data-urlencode "q=show measurements"  -H "Accept: application/csv" > txt.csv

awk -F "\"*,\"*" '{print $3}' txt.csv > new.txt
directArrayBatch=(0 1 2 3 4 5  7 8 11 12 13)
directArrayStream=(0 1 2 3 4 5  7 8 11 12 13)

eCollection=( $(cut -d ',' -f2 new.txt ) )
for j in $(seq 1 5)
do

start=$(date --utc +"%FT%T.%2NZ")

 sleep  5

end=$(date --utc +"%FT%T.%2NZ")

startCall='"'$start'"'

endCall='"'$end'"'

echo "$startCall"

echo "$endCall"
var=1

    for i in "${eCollection[@]}"
    do

      var=$((var+1))

      if [[ $var -gt 1 ]] ; then
  #delete file

      curl -G 'http://localhost:8086/query?db=telegraf' --data-urlencode 'q=SELECT * FROM '$i' WHERE "time" >= $timebegin AND "time" <= $timeend' \
      --data-urlencode 'params={"timebegin":'$startCall', "timeend": '$endCall'}'  --data-urlencode "chunk_size=20000"

      fi
    done
done