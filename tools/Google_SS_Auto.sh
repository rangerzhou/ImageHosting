#!/bin/bash
sudo apt -y update
sudo apt -y upgrade

echo "********************** Open BBR **********************"
sudo sh -c "echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf"
sudo sh -c "echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf"
sudo sysctl -p
sudo lsmod | grep bbr
echo "******************* Open BBR Done ********************"

sudo apt -y install python-pip
sudo pip install --upgrade pip
sudo pip install shadowsocks
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
echo "修改 server_port 和 password 请修改文件：/etc/shadowsocks.json"
sudo /usr/local/bin/ssserver -c /etc/shadowsocks.json -d start
echo "添加下面这行到 /etc/rc.local 以自动重启 SS ......"
echo "sudo /usr/local/bin/ssserver -c /etc/shadowsocks.json -d start"

echo "在 Google cloud 控制台中："
echo "    1. VPC网络-防火墙规则-创建防火墙规则(来源IP地址范围：0.0.0.0/0，协议端口：tcp:18888)"
echo "    2. VPC网络-外部IP地址-设置静态IP"
echo "********************************** 配置完成 **********************************"
