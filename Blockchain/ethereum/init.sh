#!/bin/bash
#Set Genensis File
nohup geth --rpc --rpcport "8084" --rpccorsdomain "*" --datadir "/home/luxbch/data" --port "30303" --nodiscover --networkid 3576 --nat "none" init "Blockchain-Testbed/Blockchain/ethereum/CommonGenesis.json" 2> /dev/null 2>&1 &
nohup geth --rpc --rpcport "8084" --rpccorsdomain "*" --datadir "/home/luxbch/data" --port "30303" --nodiscover --networkid 3576 --nat "none" --password <(echo -n "") account new 2> /dev/null 2>&1 &

