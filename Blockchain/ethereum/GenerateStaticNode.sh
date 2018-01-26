#!/bin/bash
# run on the root node to generate static-nodes.json file
ip_addr=`ifconfig eth0 2>/dev/null|awk '/inet addr:/ {print $2}'|sed 's/addr://'`
if [ -z "$ip_addr" ]
 then
  ip_addr=`ifconfig eth1 2>/dev/null|awk '/inet addr:/ {print $2}'|sed 's/addr://'`
fi

geth --datadir=/home/luxbch/data --rpc --rpcaddr 0.0.0.0 --rpcport "8084" --rpccorsdomain "*" --gasprice 0 --networkid 3576 js <(echo 'console.log(admin.nodeInfo.enode);') 2>/dev/null |grep enode | perl -pe "s/\[\:\:\]/$ip_addr/g" | perl -pe "s/^/\"/; s/\s*$/\"/;"

