#!/bin/bash
wget https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tgz
tar -xzvf Python-3.7.3.tgz
cd Python-3.7.3
./configure --enable-optimizations
sudo make
sudo make install
python3 -V
echo "Install completed"
