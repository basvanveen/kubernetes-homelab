echo "[controllers]" > inventory
openstack server list | grep controller | awk '{split($8,array,"=")} {print array[2]}' >> inventory
echo "[etcd]" >> inventory
openstack server list | grep etcd | awk '{split($8,array,"=")} {print array[2]}' >> inventory
echo "[nodes]" >> inventory
openstack server list | grep node | awk '{split($8,array,"=")} {print array[2]}' >> inventory

