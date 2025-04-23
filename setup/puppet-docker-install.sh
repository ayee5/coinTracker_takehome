wget https://apt.puppet.com/puppet7-release-bullseye.deb
sudo dpkg -i puppet7-release-bullseye.deb
sudo apt update
sudo apt install puppet-agent -y
sudo ln -s /opt/puppetlabs/bin/puppet /usr/local/bin/puppet
sudo /opt/puppetlabs/bin/puppet module install puppetlabs-docker

#install docker
sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

sudo systemctl enable docker
sudo systemctl start docker

#configure gcp artifact docker repo
sudo gcloud auth configure-docker us-central1-docker.pkg.dev --quiet
