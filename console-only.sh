clear
filename="nodes.txt"
for host in `cat $filename`; do
   nohup ssh  root@$host  Blockchain-Testbed/Blockchain/ethereum/console.sh 2> /dev/null 2>&1 &
done
