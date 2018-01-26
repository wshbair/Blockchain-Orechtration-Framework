filename="nodes.txt"

for host in `cat $filename`; do
    scp -oStrictHostKeyChecking=no "static-nodes.json" root@$host:/home/luxbch/data #2> /dev/null 2>&1 &
    ssh  root@$host  pkill geth
    ssh  root@$host  Blockchain-Testbed/Blockchain/ethereum/console.sh 2> /dev/null 2>&1 &
    #echo done node $host
done
