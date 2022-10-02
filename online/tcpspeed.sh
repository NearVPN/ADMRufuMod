function_5 () {
msg -bar 
echo -e "${cor[4]} Este Script fue proyectado"
echo -e "${cor[4]} Para Mejorar La Latencia"
echo -e "${cor[4]} y velocidad del servidor!"
msg -bar 
echo -e "${cor[5]} analizar"
sleep 1s
if [[ `grep -c "^#ADM" /etc/sysctl.conf` -eq 0 ]]; then
#INSTALA
echo -e "${cor[5]} Este es un script experimental"
echo -e "${cor[5]} ¡Utilice por su propia cuenta y riesgo!"
echo -e "${cor[5]} Este script cambiará algunas"
echo -e "${cor[5]} configuraciones de red (BBR)"
echo -e "${cor[5]} del sistema para reducir"
echo -e "${cor[5]} la latencia y mejorar la velocidad"
msg -bar #echo -e "${cor[1]} ●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●● ${cor[0]}"
read -p " Continuar con la instalación? [s/n]: " -e -i s resp_osta
echo -e "\033[1;37m"
if [[ "$resp_osta" = 's' ]]; then
unset resp_osta
echo "#ADM" >> /etc/sysctl.conf
echo "net.ipv4.tcp_window_scaling = 1
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_rmem = 4096 87380 16777216
net.ipv4.tcp_wmem = 4096 16384 16777216
net.ipv4.tcp_low_latency = 1
net.ipv4.tcp_slow_start_after_idle = 0
net.core.default_qdisc=fq
net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p /etc/sysctl.conf > /dev/null 2>&1
echo -e "${cor[5]} Configuración de red TCP"
echo -e "${cor[5]} se han agregado con éxito"
msg -bar #echo -e "${cor[1]} ●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●● ${cor[0]}"
return
 else
msg -bar 
return
fi
 else
#REMOVE
echo -e "${cor[5]} Configuración de red TCP"
echo -e "${cor[5]} ya se han agregado en el sistema!"
msg -bar
read -p " Desea quitar la configuración TCP? [s/n]: " -e -i n res_posta
if [[ "$res_posta" = 's' ]]; then
unset res_posta
grep -v "^#ADM
net.ipv4.tcp_window_scaling = 1
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_rmem = 4096 87380 16777216
net.ipv4.tcp_wmem = 4096 16384 16777216
net.ipv4.tcp_low_latency = 1
net.ipv4.tcp_slow_start_after_idle = 0
net.core.default_qdisc=fq
net.ipv4.tcp_congestion_control=bbr" /etc/sysctl.conf > /tmp/syscl && mv -f /tmp/syscl /etc/sysctl.conf
sysctl -p /etc/sysctl.conf > /dev/null 2>&1
echo -e "${cor[5]} Configuración de red TCP"
echo -e "${cor[5]} se han eliminado con éxito"
msg -bar
return
 else
msg -bar 
return
 fi
fi
}
