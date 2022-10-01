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
menuTCPspeed(){
    [[ $(crontab -l|grep '@reboot'|grep 'service'|grep 'stunnel4') ]] && actfix='\e[1m\e[32m[ON]' || actfix='\e[1m\e[31m[OFF]'
	on="\033[1;32m[ON]" && off="\033[1;31m[OFF]"
    [[ `grep -c "^#ADM" /etc/sysctl.conf` -eq 0 ]] && tcp=$off || tcp=$on
    title "INSTALADOR TCPspeed By @Near365"
    echo -e "$(msg -verd " [1]") $(msg -verm2 ">") $(msg -verd "INSTALAR") $(msg -ama "-") $(msg -verm2 "DESINSTALAR")"
    n=1
    if [[ `grep -c "^#ADM" /etc/sysctl.conf` -eq 0 ]]; then
        msg -bar3
        echo -e "$(msg -verd " [7]") $(msg -verm2 ">") $(msg -azu "INICIAR/DETENER TCPspeed")"
        n=2
    fi
    back
    opcion=$(selection_fun $n)
    case $opcion in
        1)TCPspeed;;
        2)TCPspeed;;
        0)return 1;;
    esac
}

while [[  $? -eq 0 ]]; do
  menuTCPspeed
done