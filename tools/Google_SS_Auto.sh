#!/bin/bash
sudo apt -y update
sudo apt -y upgrade

echo "********************** Open BBR **********************"
sudo sh -c "echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf"
sudo sh -c "echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf"
sudo sysctl -p
sudo lsmod | grep bbr
echo "******************* Open BBR Done ********************"

sudo apt -y install python3-pip
sudo pip3 install --upgrade pip
sudo pip3 install shadowsocks
sudo touch /etc/shadowsocks.json
sudo sh -c "cat>/etc/shadowsocks.json<<EOF
{
  "\"server"\":"\"0.0.0.0"\",
  "\"server_port"\":"\"18888"\",
  "\"local_address"\":"\"127.0.0.1"\",
  "\"local_port"\":"\"1080"\",
  "\"password"\":"\"123456"\",
  "\"timeout"\":"\"300"\",
  "\"method"\":"\"aes-256-cfb"\"
}
EOF"
sudo /usr/local/bin/ssserver -c /etc/shadowsocks.json -d start
echo "Configuration auto start SS ......"
sudo sh -c "sed '/exit/i \sudo /usr/local/bin/ssserver -c /etc/shadowsocks.json -d start' /etc/rc.local > /etc/rc.local.bak"
sudo mv /etc/rc.local.bak /etc/rc.local
sudo chmod 755 /etc/rc.local
echo "SS auto start configuration completed......"

echo "在 Google cloud 控制台中："
echo "    1. VPC网络-防火墙规则-创建防火墙规则(来源IP地址范围：0.0.0.0/0，协议端口：tcp:18888)"
echo "    2. VPC网络-外部IP地址-设置静态IP"
echo
echo "********************************** Configuration completed ***************************************"
echo "*    Default port: 18888                                                         *"
echo "*    Default password: 123456                                                    *"
echo "*    You can edit /etc/shadowsocks.json to change server_port and password       *"
echo "**********************************************************************************"
