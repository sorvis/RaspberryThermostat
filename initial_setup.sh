
WKDIR=`pwd`

# install dependencies
sudo apt-get autoremove -y \
&& sudo apt-get autoclean -y \
&& sudo apt-get update && sudo apt-get -y upgrade \
&& sudo apt-get install -y apt-transport-https mosquitto bc dnsmasq hostapd vim python3-flask python3-requests git dirmngr;

echo "install java"
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0x219BD9C9 \
&& echo 'deb http://repos.azulsystems.com/debian stable main' > /etc/apt/sources.list.d/zulu.list \
&& sudo apt-get update -qq \
&& sudo apt purge -y *java* \
&& sudo apt-get install -y zulu-embedded-8 \
&& java -version;

# install OpenHab
wget -qO - 'https://bintray.com/user/downloadSubjectPublicKey?username=openhab' | sudo apt-key add - \
&& echo 'deb https://dl.bintray.com/openhab/apt-repo2 stable main' | sudo tee /etc/apt/sources.list.d/openhab2.list \
&& sudo apt-get update \
&& sudo apt-get install openhab2 \
&& sudo apt-get autoremove -y \
&& sudo /bin/systemctl daemon-reload \
&& sudo /bin/systemctl enable openhab2.service \
&& sudo adduser openhab i2c \
&& sudo adduser openhab gpio
# needs reboot but next step will do this

# install LCD
cd $WKDIR
sudo rm -rf LCD-show
git clone https://github.com/goodtft/LCD-show.git
chmod -R 755 LCD-show
cd LCD-show/
sudo dpkg -i -B xinput-calibrator_0.7.5-1_armhf.deb
sudo ./LCD35-show # will reboot system need solution to trigger stage 2

# install LCD calibration
#cd ~/LCD-show/
#sudo dpkg -i -B xinput-calibrator_0.7.5-1_armhf.deb


