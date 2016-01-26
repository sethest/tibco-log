Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "demo1"
  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
    v.cpus = 2
  end
#  config.vm.network :private_network, ip: "192.168.0.11"
  config.vm.network :public_network, ip: "192.168.0.11"
  config.vm.network "forwarded_port", guest: 9200, host: 9200
#  config.vm.synced_folder "shell", "/home/vagrant/shell" 
#  config.vm.provision "shell", inline: ". /home/vagrant/test.sh"
  config.vm.provision "shell", inline: "echo START PLAY VAGRANT", run:"always"
end
