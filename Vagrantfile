# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty64"

  config.vm.provision :shell, path: "bootstrap.sh"

  config.vm.network "forwarded_port", guest: 3000, host: 3000

  config.vm.provider "virtualbox" do |vb|
     vb.memory = "1024"
  end

  config.vm.provision "chef_solo" do |chef|
    chef.cookbooks_path = ["cookbooks", "site-cookbooks"]

    chef.add_recipe "apt"
    chef.add_recipe "openssl"
    chef.add_recipe "postgresql"
    chef.add_recipe "ruby_build"
    chef.add_recipe "rbenv::user"
    chef.add_recipe "rbenv::vagrant"
    chef.add_recipe "postgresql::server"
    chef.add_recipe "postgresql::client"

    # Configs
    chef.json = {
      rbenv: {
        user_installs: [{
          user: 'vagrant',
          rubies: ["2.1.3"],
          global: "2.1.3",
          gems: {
            "2.1.3" => [
              {name: "bundler"}
            ]
          }
        }]
      },
      postgresql: {
        password: {
          postgres: "md58e10f8cab915148a7e9264013ec65d74" # y0l0test
        }
      }
    }

  end

  config.vm.provision "shell", path: "start_ruby.sh", privileged: false
end
