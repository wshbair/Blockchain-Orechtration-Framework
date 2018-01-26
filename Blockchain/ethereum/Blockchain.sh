#function join { local IFS="$1"; shift; echo "$*"; }
#array=()
#for host in `cat REMOTEHOST`; do
 #echo $host
 #remotenodes=`ssh washbair@$host 'cat nodes.txt'`
 #echo $remotenodes
  #for node in $remotenodes; do
  # echo $node$'\r'>>nodes.txt
   #done
# x=`ssh washbair@$host 'cat static-nodes.json'`
 #array+=($x)
 #done
 #z=` join , ${array[@]}`

# localstnode=`cat static-nodes.json`
# echo '['$localstnode$','$z$']'>static-nodes.json

filename="nodes.txt"

for host in `cat $filename`; do
    scp -oStrictHostKeyChecking=no "static-nodes.json" root@$host:/home/luxbch/data #2> /dev/null 2>&1 &
    ssh  root@$host  pkill geth
    ssh  root@$host  Blockchain-Testbed/Blockchain/ethereum/console.sh 2> /dev/null 2>&1 &
    #echo done node $host
done
