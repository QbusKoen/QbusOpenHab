#!/bin/bash

echo "   ____  _                 ___                           _    _          ____  "
echo "  / __ \| |               |__ \                         | |  | |   /\   |  _ \ "
echo " | |  | | |__  _   _ ___     ) |   ___  _ __   ___ _ __ | |__| |  /  \  | |_) |"
echo " | |  | | '_ \| | | / __|   / /   / _ \| '_ \ / _ \ '_ \|  __  | / /\ \ |  _ < "
echo " | |__| | |_) | |_| \__ \  / /_  | (_) | |_) |  __/ | | | |  | |/ ____ \| |_) |"
echo "  \___\_\_.__/ \__,_|___/ |____|  \___/| .__/ \___|_| |_|_|  |_/_/    \_\____/ "
echo "                                       | |                                     "
echo "                                       |_|                                     "
echo ""

read -p 'Enter username of your controller: ' uservar
read -sp 'Enter the password of your controller: ' passvar
echo ''
read -p 'Enter the ip address of your controller: ' ipvar
read -p 'Enter the serial number of your controller: ' snvar

sudo rm /lib/systemd/system/qbusclient.service

echo '[Unit]' | sudo tee -a /lib/systemd/system/qbusclient.service
echo 'Description=Client for Qbus communication' | sudo tee -a /lib/systemd/system/qbusclient.service
echo 'After=multi-user.target' | sudo tee -a /lib/systemd/system/qbusclient.service
echo '' | sudo tee -a /lib/systemd/system/qbusclient.service
echo '[Service]' | sudo tee -a /lib/systemd/system/qbusclient.service
echo 'Type=simple' | sudo tee -a /lib/systemd/system/qbusclient.service
echo 'ExecStart= mono /home/pi/QbusOpenHab/QbusClient/QbusClient.exe '$ipvar' '$uservar' '$passvar' '$snvar'' | sudo tee -a /lib/systemd/system/qbusclient.service
echo 'Restart=always' | sudo tee -a /lib/systemd/system/qbusclient.service
echo '' | sudo tee -a /lib/systemd/system/qbusclient.service
echo '[Install]' | sudo tee -a /lib/systemd/system/qbusclient.service
echo 'WantedBy=multi-user.target' | sudo tee -a /lib/systemd/system/qbusclient.service

sudo systemctl daemon-reload
sudo systemctl enable qbusclient.service
sudo systemctl restart qbusclient.service
