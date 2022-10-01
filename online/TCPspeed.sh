#!/bin/bash

TCPspeed () {
if [[ `grep -c "^#ADM" /etc/sysctl.conf` -eq 0 ]]; then
#INSTALA
msg -ama "$(fun_trans "TCP Speed No Activado, Desea Activar Ahora")?"
msg -bar
while [[ ${resposta} != @(s|S|n|N|y|Y) ]]; do
read -p " [S/N]: " -e -i s resposta
tput cuu1 && tput dl1
done
[[ "$resposta" = @(s|S|y|Y) ]] && {
echo "#ADM" >> /etc/sysctl.conf
echo "net.ipv4.tcp_window_scaling = 1
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_rmem = 4096 87380 16777216
net.ipv4.tcp_wmem = 4096 16384 16777216
net.ipv4.tcp_low_latency = 1
net.ipv4.tcp_slow_start_after_idle = 0" >> /etc/sysctl.conf
sysctl -p /etc/sysctl.conf > /dev/null 2>&1
msg -ama "$(fun_trans "TCP Activo Con Exito")!"
} || msg -ama "$(fun_trans "Cancelado")!"
 else
#REMOVE
msg -ama "$(fun_trans "TCP Speed ya esta activado, desea detener ahora")?"
msg -bar
while [[ ${resposta} != @(s|S|n|N|y|Y) ]]; do
read -p " [S/N]: " -e -i s resposta
tput cuu1 && tput dl1
done
[[ "$resposta" = @(s|S|y|Y) ]] && {
grep -v "^#ADM
net.ipv4.tcp_window_scaling = 1
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_rmem = 4096 87380 16777216
net.ipv4.tcp_wmem = 4096 16384 16777216
net.ipv4.tcp_low_latency = 1
net.ipv4.tcp_slow_start_after_idle = 0" /etc/sysctl.conf > /tmp/syscl && mv -f /tmp/syscl /etc/sysctl.conf
sysctl -p /etc/sysctl.conf > /dev/null 2>&1
msg -ama "$(fun_trans "TCP Parado Con Exito")!"
} || msg -ama "$(fun_trans "Cancelado")!"
fi
}
TCPspeed