# University of Luxembourg/SnT
# Wazen Shbair
# shbair.wazen@uni.lu
# wazen.shbair@gmail.com
# January, 2018

Cleaning
echo "Cleaning"
rm nodes.txt static-nodes.json OAR* oar*
echo "Reservation"
ruby G5KNodeReservation.rb $1 $2
filename="nodes.txt"
echo 'Transfering static-nodes to network nodes'
for host in `cat $filename`; do
    ssh  root@$host  killall -KILL geth
    scp -oStrictHostKeyChecking=no "static-nodes.json" root@$host:/home/luxbch/data #2> /dev/null 2>&1 &
done
echo "Blockchain Testbed is ready"
