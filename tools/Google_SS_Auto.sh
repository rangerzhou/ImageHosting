#!/bin/bash
#sudo apt update
#sudo apt upgrade
echo "********************** Open BBR **********************"
echo "sudo -i"
echo "echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf"
echo "echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf"
echo "sysctl -p"

sudo sh -c "echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf"
sudo sh -c "echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf"
sudo sysctl -p
sudo lsmod | grep bbr
echo "******************* Open BBR Done ********************"

#sudo pip install --upgrade pip
#sudo pip install shadowsocks
sudo touch /etc/shadowsocks.json
sudo sh -c "cat>/etc/shadowsocks.json<<EOF
{
  "server":"0.0.0.0",
  "server_port":12888,
  "local_address":"127.0.0.1",
  "local_port":1080,
  "password":"123456",
  "timeout":300,
  "method":"aes-256-cfb"
}
EOF"
sudo /usr/local/bin/ssserver -c /etc/shadowsocks.json -d start
echo "Add this line to /etc/rc.local for auto start:"
echo "sudo /usr/local/bin/ssserver -c /etc/shadowsocks.json -d start"

echo "VPC网络-防火墙规则-创建防火墙规则(来源IP地址范围：0.0.0.0/0，协议端口：tcp:12018)"
echo "VPC网络-外部IP地址-设置静态IP"
