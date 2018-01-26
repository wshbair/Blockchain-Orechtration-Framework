#!/bin/bash
#Open Console window
nohup geth --identity "LuxBch" --rpc --rpcport "8084" --rpccorsdomain "*" --datadir "/home/luxbch/data" --port "30303" --unlock 0 --password <(echo -n "") --rpcapi "db,eth,net,web3, personal" --networkid 3576 --nat "none" 2> /dev/null 2>&1 &
