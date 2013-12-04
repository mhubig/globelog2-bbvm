# -*- mode: ruby -*-
# vi: set ft=ruby :

BOX_NAME     = "docker"
SSH_PRIVKEY  = ENV['SSH_PRIVKEY']  || "~/.ssh/id_docker"
KEYPAIR_NAME = ENV['KEYPAIR_NAME'] || "docker"

AWS_ACCESS_KEY = ENV['AWS_ACCESS_KEY_ID']     || "your aws access key"
AWS_SECRET_KEY = ENV['AWS_SECRET_ACCESS_KEY'] || "your aws secret key"

DO_API_KEY   = ENV['DIGITALOCEAN_API_KEY']   || "your digital ocean api key"
DO_CLIENT_ID = ENV['DIGITALOCEAN_CLIENT_ID'] || "your digital ocean client id"

Vagrant.configure("2") do |config|

    config.vm.define :"#{BOX_NAME}" do |t|
    end

    config.vm.box = BOX_NAME
    config.ssh.forward_agent = true
    config.ssh.username = "vagrant"
    config.ssh.private_key_path = SSH_PRIVKEY

    config.vm.provider :virtualbox do |virtualbox, override|
        override.vm.box_url = BOX_NAME + "_virtualbox.box"
        override.vm.synced_folder ".", "/vagrant", nfs: true, disabled: true
        virtualbox.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        virtualbox.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    end

    config.vm.provider :vmware_fusion do |vmware, override|
        override.vm.box_url = BOX_NAME + "_vmware.box"
        override.vm.synced_folder ".", "/vagrant", nfs: true, disabled: true
        vmware.vmx["displayName"] = "docker"
    end

    config.vm.provider :aws do |aws, override|
        override.vm.box_url = BOX_NAME + "_aws.box"
        override.vm.synced_folder ".", "/vagrant", disabled: true
        aws.keypair_name = KEYPAIR_NAME
        aws.access_key_id = AWS_ACCESS_KEY
        aws.secret_access_key = AWS_SECRET_KEY
        aws.instance_type = "c1.xlarge" # It's 8 CPU's
    end

    config.vm.provider :digital_ocean do |digitalocean, override|
        override.vm.box_url = BOX_NAME + "_digitalocean.box"
        override.vm.synced_folder ".", "/vagrant", disabled: true
        digitalocean.ssh_key_name = KEYPAIR_NAME
        digitalocean.client_id = DO_CLIENT_ID
        digitalocean.api_key = DO_API_KEY
        digitalocean.setup = false
        digitalocean.size = '16GB' # It's 8 CPU's
    end

end
