#!/bin/bash
# Start mining
#nohup geth --rpc --rpcport "8084" --rpccorsdomain "*" --datadir "/home/luxbch/data" --port "30313" --nodiscover --networkid 3576 --nat "none" --password <(echo -n "") account new 2> /dev/null 2>&1 &
nohup geth --rpc --rpcport "8084" --rpccorsdomain "*" --rpcapi "db,eth,net,web3, personal" --datadir "/home/luxbch/data" --port "30303" --nodiscover --networkid 3576 --nat "none" --unlock 0 --password <(echo -n "") --mine --minerthreads=8 2> /dev/null 2>&1 &
