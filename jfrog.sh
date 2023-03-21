wget -q -O - https://bintray.com/user/downloadSubjectPublicKey?username=jfrog | sudo apt-key add -
echo "deb https://jfrog.bintray.com/artifactory-pro-debs bionic main" | sudo tee -a /etc/apt/sources.list.d/jfrog-artifactory-pro.list
sudo apt update
sudo apt install -y jfrog-artifactory-pro
sudo systemctl start artifactory