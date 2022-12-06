#!/bin/sh


# == INSTALL APPS == # 

#sudo apt-get update

# Firefox
#sudo apt install firefox-esr

# VS Code
#curl -o vscode-setup.deb https://urlurlurl
#chmod +x vscode-setup.deb
#sudo dpkg +i vscode-setup.deb
#rm vscode-setup.deb

# LibreOffice
# TODO



sudo mkdir /etc/skel/Documents
sudo mkdir /etc/skel/Téléchargements
sudo mkdir /etc/skel/Images


# == CREATE USERS == #

cat collabos.csv | while read line
do
	# Parse informations
	firstname=`echo $line | cut -d ";" -f1`
	lastname=`echo $line | cut -d ";" -f2`
	passwd=`echo $line | cut -d ";" -f3`
	group=`echo $line | cut -d ";" -f4`

	# Create group if needed
	if grep -q "$group" /etc/group; then
		echo "Group $group already exists"
	else
		echo "$group"
		groupadd "$group"
		echo "$group"
	fi

	# Create user if needed
	username=$lastname
	if grep -q "$username" /etc/passwd; then
		echo "user $username already exists"
	else
		useradd $username --create-home
		echo -e "$passwd\n$passwd" | passwd $username
		echo "User $username created"
	fi
done


# == CREATE SHARED DIRECTORIES == #

mkdir /home/dev/partageDev
chmod 774 /home/dev/partageDev

mkdir /home/web/partageWeb
chmod 774 /home/dev/partageWeb

mkdir /home/marketing/partageMark
chmod 774 /home/dev/partageMark

mkdir /home/partageChefs
chmod 770 /home/partageChefs

mkdir /home/partageTous
chmod 777 /home/partageTous
