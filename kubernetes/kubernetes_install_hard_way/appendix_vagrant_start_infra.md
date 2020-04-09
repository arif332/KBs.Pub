## Appendix: Vagrant Infrastructure Provision Log





```bash
arif@ariflindesk1:/ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant$ rm -rf .vagrant/
arif@ariflindesk1:/ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant$ vagrant status
Current machine states:

master-1                  not created (virtualbox)
master-2                  not created (virtualbox)
master-3                  not created (virtualbox)
loadbalancer              not created (virtualbox)
worker-1                  not created (virtualbox)
worker-2                  not created (virtualbox)
worker-3                  not created (virtualbox)
worker-4                  not created (virtualbox)

This environment represents multiple VMs. The VMs are all listed
above with their current state. For more information about a specific
VM, run `vagrant status NAME`.
arif@ariflindesk1:/ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant$ vagrant up
Bringing machine 'master-1' up with 'virtualbox' provider...
Bringing machine 'master-2' up with 'virtualbox' provider...
Bringing machine 'master-3' up with 'virtualbox' provider...
Bringing machine 'loadbalancer' up with 'virtualbox' provider...
Bringing machine 'worker-1' up with 'virtualbox' provider...
Bringing machine 'worker-2' up with 'virtualbox' provider...
Bringing machine 'worker-3' up with 'virtualbox' provider...
Bringing machine 'worker-4' up with 'virtualbox' provider...
==> master-1: Box 'ubuntu/bionic64' could not be found. Attempting to find and install...
    master-1: Box Provider: virtualbox
    master-1: Box Version: >= 0
==> master-1: Loading metadata for box 'ubuntu/bionic64'
    master-1: URL: https://vagrantcloud.com/ubuntu/bionic64
==> master-1: Adding box 'ubuntu/bionic64' (v20200402.0.0) for provider: virtualbox
    master-1: Downloading: https://vagrantcloud.com/ubuntu/boxes/bionic64/versions/20200402.0.0/providers/virtualbox.box
    master-1: Download redirected to host: cloud-images.ubuntu.com
==> master-1: Successfully added box 'ubuntu/bionic64' (v20200402.0.0) for 'virtualbox'!
==> master-1: Importing base box 'ubuntu/bionic64'...
==> master-1: Matching MAC address for NAT networking...
==> master-1: Setting the name of the VM: kubernetes-ha-master-1
Vagrant is currently configured to create VirtualBox synced folders with
the `SharedFoldersEnableSymlinksCreate` option enabled. If the Vagrant
guest is not trusted, you may want to disable this option. For more
information on this option, please refer to the VirtualBox manual:

  https://www.virtualbox.org/manual/ch04.html#sharedfolders

This option can be disabled globally with an environment variable:

  VAGRANT_DISABLE_VBOXSYMLINKCREATE=1

or on a per folder basis within the Vagrantfile:

  config.vm.synced_folder '/host/path', '/guest/path', SharedFoldersEnableSymlinksCreate: false
==> master-1: Clearing any previously set network interfaces...
==> master-1: Preparing network interfaces based on configuration...
    master-1: Adapter 1: nat
    master-1: Adapter 2: hostonly
==> master-1: Forwarding ports...
    master-1: 22 (guest) => 2711 (host) (adapter 1)
    master-1: 22 (guest) => 2222 (host) (adapter 1)
==> master-1: Running 'pre-boot' VM customizations...
==> master-1: Booting VM...
==> master-1: Waiting for machine to boot. This may take a few minutes...
    master-1: SSH address: 127.0.0.1:2222
    master-1: SSH username: vagrant
    master-1: SSH auth method: private key
    master-1: 
    master-1: Vagrant insecure key detected. Vagrant will automatically replace
    master-1: this with a newly generated keypair for better security.
    master-1: 
    master-1: Inserting generated public key within guest...
    master-1: Removing insecure key from the guest if it's present...
    master-1: Key inserted! Disconnecting and reconnecting using new SSH key...
==> master-1: Machine booted and ready!
==> master-1: Checking for guest additions in VM...
    master-1: The guest additions on this VM do not match the installed version of
    master-1: VirtualBox! In most cases this is fine, but in rare cases it can
    master-1: prevent things such as shared folders from working properly. If you see
    master-1: shared folder errors, please make sure the guest additions within the
    master-1: virtual machine match the version of VirtualBox you have installed on
    master-1: your host and reload your VM.
    master-1: 
    master-1: Guest Additions Version: 5.2.34
    master-1: VirtualBox Version: 6.1
==> master-1: Setting hostname...
==> master-1: Configuring and enabling network interfaces...
==> master-1: Mounting shared folders...
    master-1: /vagrant => /ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant
==> master-1: Running provisioner: setup-hosts (shell)...
    master-1: Running: /tmp/vagrant-shell20200406-8383-1meyzbs.sh
==> master-1: Running provisioner: setup-dns (shell)...
    master-1: Running: /tmp/vagrant-shell20200406-8383-1xc79og.sh
==> master-2: Box 'ubuntu/bionic64' could not be found. Attempting to find and install...
    master-2: Box Provider: virtualbox
    master-2: Box Version: >= 0
==> master-2: Loading metadata for box 'ubuntu/bionic64'
    master-2: URL: https://vagrantcloud.com/ubuntu/bionic64
==> master-2: Adding box 'ubuntu/bionic64' (v20200402.0.0) for provider: virtualbox
==> master-2: Importing base box 'ubuntu/bionic64'...
==> master-2: Matching MAC address for NAT networking...
==> master-2: Setting the name of the VM: kubernetes-ha-master-2
==> master-2: Fixed port collision for 22 => 2222. Now on port 2200.
==> master-2: Clearing any previously set network interfaces...
==> master-2: Preparing network interfaces based on configuration...
    master-2: Adapter 1: nat
    master-2: Adapter 2: hostonly
==> master-2: Forwarding ports...
    master-2: 22 (guest) => 2712 (host) (adapter 1)
    master-2: 22 (guest) => 2200 (host) (adapter 1)
==> master-2: Running 'pre-boot' VM customizations...
==> master-2: Booting VM...
==> master-2: Waiting for machine to boot. This may take a few minutes...
    master-2: SSH address: 127.0.0.1:2200
    master-2: SSH username: vagrant
    master-2: SSH auth method: private key
    master-2: 
    master-2: Vagrant insecure key detected. Vagrant will automatically replace
    master-2: this with a newly generated keypair for better security.
    master-2: 
    master-2: Inserting generated public key within guest...
    master-2: Removing insecure key from the guest if it's present...
    master-2: Key inserted! Disconnecting and reconnecting using new SSH key...
==> master-2: Machine booted and ready!
==> master-2: Checking for guest additions in VM...
    master-2: The guest additions on this VM do not match the installed version of
    master-2: VirtualBox! In most cases this is fine, but in rare cases it can
    master-2: prevent things such as shared folders from working properly. If you see
    master-2: shared folder errors, please make sure the guest additions within the
    master-2: virtual machine match the version of VirtualBox you have installed on
    master-2: your host and reload your VM.
    master-2: 
    master-2: Guest Additions Version: 5.2.34
    master-2: VirtualBox Version: 6.1
==> master-2: Setting hostname...
==> master-2: Configuring and enabling network interfaces...
==> master-2: Mounting shared folders...
    master-2: /vagrant => /ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant
==> master-2: Running provisioner: setup-hosts (shell)...
    master-2: Running: /tmp/vagrant-shell20200406-8383-8dwgi5.sh
==> master-2: Running provisioner: setup-dns (shell)...
    master-2: Running: /tmp/vagrant-shell20200406-8383-7luyc6.sh
==> master-3: Box 'ubuntu/bionic64' could not be found. Attempting to find and install...
    master-3: Box Provider: virtualbox
    master-3: Box Version: >= 0
==> master-3: Loading metadata for box 'ubuntu/bionic64'
    master-3: URL: https://vagrantcloud.com/ubuntu/bionic64
==> master-3: Adding box 'ubuntu/bionic64' (v20200402.0.0) for provider: virtualbox
==> master-3: Importing base box 'ubuntu/bionic64'...
==> master-3: Matching MAC address for NAT networking...
==> master-3: Setting the name of the VM: kubernetes-ha-master-3
==> master-3: Fixed port collision for 22 => 2222. Now on port 2201.
==> master-3: Clearing any previously set network interfaces...
==> master-3: Preparing network interfaces based on configuration...
    master-3: Adapter 1: nat
    master-3: Adapter 2: hostonly
==> master-3: Forwarding ports...
    master-3: 22 (guest) => 2713 (host) (adapter 1)
    master-3: 22 (guest) => 2201 (host) (adapter 1)
==> master-3: Running 'pre-boot' VM customizations...
==> master-3: Booting VM...
==> master-3: Waiting for machine to boot. This may take a few minutes...
    master-3: SSH address: 127.0.0.1:2201
    master-3: SSH username: vagrant
    master-3: SSH auth method: private key
    master-3: 
    master-3: Vagrant insecure key detected. Vagrant will automatically replace
    master-3: this with a newly generated keypair for better security.
    master-3: 
    master-3: Inserting generated public key within guest...
    master-3: Removing insecure key from the guest if it's present...
    master-3: Key inserted! Disconnecting and reconnecting using new SSH key...
==> master-3: Machine booted and ready!
==> master-3: Checking for guest additions in VM...
    master-3: The guest additions on this VM do not match the installed version of
    master-3: VirtualBox! In most cases this is fine, but in rare cases it can
    master-3: prevent things such as shared folders from working properly. If you see
    master-3: shared folder errors, please make sure the guest additions within the
    master-3: virtual machine match the version of VirtualBox you have installed on
    master-3: your host and reload your VM.
    master-3: 
    master-3: Guest Additions Version: 5.2.34
    master-3: VirtualBox Version: 6.1
==> master-3: Setting hostname...
==> master-3: Configuring and enabling network interfaces...
==> master-3: Mounting shared folders...
    master-3: /vagrant => /ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant
==> master-3: Running provisioner: setup-hosts (shell)...
    master-3: Running: /tmp/vagrant-shell20200406-8383-fx114p.sh
==> master-3: Running provisioner: setup-dns (shell)...
    master-3: Running: /tmp/vagrant-shell20200406-8383-adeslk.sh
==> loadbalancer: Box 'ubuntu/bionic64' could not be found. Attempting to find and install...
    loadbalancer: Box Provider: virtualbox
    loadbalancer: Box Version: >= 0
==> loadbalancer: Loading metadata for box 'ubuntu/bionic64'
    loadbalancer: URL: https://vagrantcloud.com/ubuntu/bionic64
==> loadbalancer: Adding box 'ubuntu/bionic64' (v20200402.0.0) for provider: virtualbox
==> loadbalancer: Importing base box 'ubuntu/bionic64'...
==> loadbalancer: Matching MAC address for NAT networking...
==> loadbalancer: Setting the name of the VM: kubernetes-ha-lb
==> loadbalancer: Fixed port collision for 22 => 2222. Now on port 2202.
==> loadbalancer: Clearing any previously set network interfaces...
==> loadbalancer: Preparing network interfaces based on configuration...
    loadbalancer: Adapter 1: nat
    loadbalancer: Adapter 2: hostonly
==> loadbalancer: Forwarding ports...
    loadbalancer: 22 (guest) => 2730 (host) (adapter 1)
    loadbalancer: 22 (guest) => 2202 (host) (adapter 1)
==> loadbalancer: Running 'pre-boot' VM customizations...
==> loadbalancer: Booting VM...
==> loadbalancer: Waiting for machine to boot. This may take a few minutes...
    loadbalancer: SSH address: 127.0.0.1:2202
    loadbalancer: SSH username: vagrant
    loadbalancer: SSH auth method: private key
    loadbalancer: 
    loadbalancer: Vagrant insecure key detected. Vagrant will automatically replace
    loadbalancer: this with a newly generated keypair for better security.
    loadbalancer: 
    loadbalancer: Inserting generated public key within guest...
    loadbalancer: Removing insecure key from the guest if it's present...
    loadbalancer: Key inserted! Disconnecting and reconnecting using new SSH key...
==> loadbalancer: Machine booted and ready!
==> loadbalancer: Checking for guest additions in VM...
    loadbalancer: The guest additions on this VM do not match the installed version of
    loadbalancer: VirtualBox! In most cases this is fine, but in rare cases it can
    loadbalancer: prevent things such as shared folders from working properly. If you see
    loadbalancer: shared folder errors, please make sure the guest additions within the
    loadbalancer: virtual machine match the version of VirtualBox you have installed on
    loadbalancer: your host and reload your VM.
    loadbalancer: 
    loadbalancer: Guest Additions Version: 5.2.34
    loadbalancer: VirtualBox Version: 6.1
==> loadbalancer: Setting hostname...
==> loadbalancer: Configuring and enabling network interfaces...
==> loadbalancer: Mounting shared folders...
    loadbalancer: /vagrant => /ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant
==> loadbalancer: Running provisioner: setup-hosts (shell)...
    loadbalancer: Running: /tmp/vagrant-shell20200406-8383-1eqmld1.sh
==> loadbalancer: Running provisioner: setup-dns (shell)...
    loadbalancer: Running: /tmp/vagrant-shell20200406-8383-1vfeg4x.sh
==> worker-1: Box 'ubuntu/bionic64' could not be found. Attempting to find and install...
    worker-1: Box Provider: virtualbox
    worker-1: Box Version: >= 0
==> worker-1: Loading metadata for box 'ubuntu/bionic64'
    worker-1: URL: https://vagrantcloud.com/ubuntu/bionic64
==> worker-1: Adding box 'ubuntu/bionic64' (v20200402.0.0) for provider: virtualbox
==> worker-1: Importing base box 'ubuntu/bionic64'...
==> worker-1: Matching MAC address for NAT networking...
==> worker-1: Setting the name of the VM: kubernetes-ha-worker-1
==> worker-1: Fixed port collision for 22 => 2222. Now on port 2203.
==> worker-1: Clearing any previously set network interfaces...
==> worker-1: Preparing network interfaces based on configuration...
    worker-1: Adapter 1: nat
    worker-1: Adapter 2: hostonly
==> worker-1: Forwarding ports...
    worker-1: 22 (guest) => 2721 (host) (adapter 1)
    worker-1: 22 (guest) => 2203 (host) (adapter 1)
==> worker-1: Running 'pre-boot' VM customizations...
==> worker-1: Booting VM...
==> worker-1: Waiting for machine to boot. This may take a few minutes...
    worker-1: SSH address: 127.0.0.1:2203
    worker-1: SSH username: vagrant
    worker-1: SSH auth method: private key
    worker-1: 
    worker-1: Vagrant insecure key detected. Vagrant will automatically replace
    worker-1: this with a newly generated keypair for better security.
    worker-1: 
    worker-1: Inserting generated public key within guest...
    worker-1: Removing insecure key from the guest if it's present...
    worker-1: Key inserted! Disconnecting and reconnecting using new SSH key...
==> worker-1: Machine booted and ready!
==> worker-1: Checking for guest additions in VM...
    worker-1: The guest additions on this VM do not match the installed version of
    worker-1: VirtualBox! In most cases this is fine, but in rare cases it can
    worker-1: prevent things such as shared folders from working properly. If you see
    worker-1: shared folder errors, please make sure the guest additions within the
    worker-1: virtual machine match the version of VirtualBox you have installed on
    worker-1: your host and reload your VM.
    worker-1: 
    worker-1: Guest Additions Version: 5.2.34
    worker-1: VirtualBox Version: 6.1
==> worker-1: Setting hostname...
==> worker-1: Configuring and enabling network interfaces...
==> worker-1: Mounting shared folders...
    worker-1: /vagrant => /ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant
==> worker-1: Running provisioner: setup-hosts (shell)...
    worker-1: Running: /tmp/vagrant-shell20200406-8383-13rzppp.sh
==> worker-1: Running provisioner: setup-dns (shell)...
    worker-1: Running: /tmp/vagrant-shell20200406-8383-hmgbi4.sh
==> worker-1: Running provisioner: install-docker (shell)...
    worker-1: Running: /tmp/vagrant-shell20200406-8383-18u8o2u.sh
    worker-1: # Executing docker install script, commit: 442e66405c304fa92af8aadaa1d9b31bf4b0ad94
    worker-1: + 
    worker-1: sh
    worker-1:  -c
    worker-1:  apt-get update -qq >/dev/null
    worker-1: + sh -c DEBIAN_FRONTEND=noninteractive apt-get install -y -qq apt-transport-https ca-certificates curl >/dev/null
    worker-1: + sh -c curl -fsSL "https://download.docker.com/linux/ubuntu/gpg" | apt-key add -qq - >/dev/null
    worker-1: Warning: apt-key output should not be parsed (stdout is not a terminal)
    worker-1: + sh -c echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" > /etc/apt/sources.list.d/docker.list
    worker-1: + sh -c apt-get update -qq >/dev/null
    worker-1: + 
    worker-1: [
    worker-1:  -n
    worker-1:  
    worker-1:  ]
    worker-1: + 
    worker-1: sh
    worker-1:  -c
    worker-1:  apt-get install -y -qq --no-install-recommends docker-ce >/dev/null
    worker-1: dpkg-preconfigure: unable to re-open stdin: No such file or directory
    worker-1: + 
    worker-1: sh
    worker-1:  -c
    worker-1:  docker version
    worker-1: Client: Docker Engine - Community
    worker-1:  Version:
    worker-1:         
    worker-1:    
    worker-1: 19.03.8
    worker-1:  API version:
    worker-1:        
    worker-1: 1.40
    worker-1:  Go version:
    worker-1:         
    worker-1: go1.12.17
    worker-1:  Git commit:
    worker-1:         
    worker-1: afacb8b7f0
    worker-1:  Built:
    worker-1:         
    worker-1:      
    worker-1: Wed Mar 11 01:25:46 2020
    worker-1:  OS/Arch:
    worker-1:         
    worker-1:    
    worker-1: linux/amd64
    worker-1:  Experimental:
    worker-1:       
    worker-1: false
    worker-1: Server: Docker Engine - Community
    worker-1:  Engine:
    worker-1:   Version:
    worker-1:         
    worker-1:   
    worker-1: 19.03.8
    worker-1:   API version:
    worker-1:       
    worker-1: 1.40 (minimum version 1.12)
    worker-1:   Go version:       go1.12.17
    worker-1:   Git commit:       afacb8b7f0
    worker-1:   Built:            Wed Mar 11 01:24:19 2020
    worker-1:   OS/Arch:          linux/amd64
    worker-1:   Experimental:     false
    worker-1:  containerd:
    worker-1:   Version:          1.2.13
    worker-1:   GitCommit:        7ad184331fa3e55e52b890ea95e65ba581ae3429
    worker-1:  runc:
    worker-1:   Version:
    worker-1:           1.0.0-rc10
    worker-1:   GitCommit:        dc9208a3303feef5b3839f4323d9beb36df0a9dd
    worker-1:  docker-init:
    worker-1:   Version:        
    worker-1:   
    worker-1: 0.18.0
    worker-1:   GitCommit:
    worker-1:         fec3683
    worker-1: If you would like to use Docker as a non-root user, you should now consider
    worker-1: adding your user to the "docker" group with something like:
    worker-1: 
    worker-1:   sudo usermod -aG docker your-user
    worker-1: 
    worker-1: Remember that you will have to log out and back in for this to take effect!
    worker-1: 
    worker-1: WARNING: Adding a user to the "docker" group will grant the ability to run
    worker-1:          containers which can be used to obtain root privileges on the
    worker-1:          docker host.
    worker-1:          Refer to https://docs.docker.com/engine/security/security/#docker-daemon-attack-surface
    worker-1:          for more information.
==> worker-1: Running provisioner: allow-bridge-nf-traffic (shell)...
    worker-1: Running: /tmp/vagrant-shell20200406-8383-bbuw85.sh
    worker-1: net.bridge.bridge-nf-call-iptables = 1
==> worker-2: Box 'ubuntu/bionic64' could not be found. Attempting to find and install...
    worker-2: Box Provider: virtualbox
    worker-2: Box Version: >= 0
==> worker-2: Loading metadata for box 'ubuntu/bionic64'
    worker-2: URL: https://vagrantcloud.com/ubuntu/bionic64
==> worker-2: Adding box 'ubuntu/bionic64' (v20200402.0.0) for provider: virtualbox
==> worker-2: Importing base box 'ubuntu/bionic64'...
==> worker-2: Matching MAC address for NAT networking...
==> worker-2: Setting the name of the VM: kubernetes-ha-worker-2
==> worker-2: Fixed port collision for 22 => 2222. Now on port 2204.
==> worker-2: Clearing any previously set network interfaces...
==> worker-2: Preparing network interfaces based on configuration...
    worker-2: Adapter 1: nat
    worker-2: Adapter 2: hostonly
==> worker-2: Forwarding ports...
    worker-2: 22 (guest) => 2722 (host) (adapter 1)
    worker-2: 22 (guest) => 2204 (host) (adapter 1)
==> worker-2: Running 'pre-boot' VM customizations...
==> worker-2: Booting VM...
==> worker-2: Waiting for machine to boot. This may take a few minutes...
    worker-2: SSH address: 127.0.0.1:2204
    worker-2: SSH username: vagrant
    worker-2: SSH auth method: private key
    worker-2: 
    worker-2: Vagrant insecure key detected. Vagrant will automatically replace
    worker-2: this with a newly generated keypair for better security.
    worker-2: 
    worker-2: Inserting generated public key within guest...
    worker-2: Removing insecure key from the guest if it's present...
    worker-2: Key inserted! Disconnecting and reconnecting using new SSH key...
==> worker-2: Machine booted and ready!
==> worker-2: Checking for guest additions in VM...
    worker-2: The guest additions on this VM do not match the installed version of
    worker-2: VirtualBox! In most cases this is fine, but in rare cases it can
    worker-2: prevent things such as shared folders from working properly. If you see
    worker-2: shared folder errors, please make sure the guest additions within the
    worker-2: virtual machine match the version of VirtualBox you have installed on
    worker-2: your host and reload your VM.
    worker-2: 
    worker-2: Guest Additions Version: 5.2.34
    worker-2: VirtualBox Version: 6.1
==> worker-2: Setting hostname...
==> worker-2: Configuring and enabling network interfaces...
==> worker-2: Mounting shared folders...
    worker-2: /vagrant => /ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant
==> worker-2: Running provisioner: setup-hosts (shell)...
    worker-2: Running: /tmp/vagrant-shell20200406-8383-16avt4b.sh
==> worker-2: Running provisioner: setup-dns (shell)...
    worker-2: Running: /tmp/vagrant-shell20200406-8383-eem6md.sh
==> worker-2: Running provisioner: install-docker (shell)...
    worker-2: Running: /tmp/vagrant-shell20200406-8383-1dv38pf.sh
    worker-2: # Executing docker install script, commit: 442e66405c304fa92af8aadaa1d9b31bf4b0ad94
    worker-2: + 
    worker-2: sh
    worker-2:  -c
    worker-2:  apt-get update -qq >/dev/null
    worker-2: + sh -c DEBIAN_FRONTEND=noninteractive apt-get install -y -qq apt-transport-https ca-certificates curl >/dev/null
    worker-2: + sh -c curl -fsSL "https://download.docker.com/linux/ubuntu/gpg" | apt-key add -qq - >/dev/null
    worker-2: Warning: apt-key output should not be parsed (stdout is not a terminal)
    worker-2: + sh -c echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" > /etc/apt/sources.list.d/docker.list
    worker-2: + sh -c apt-get update -qq >/dev/null
    worker-2: + 
    worker-2: [
    worker-2:  -n
    worker-2:  
    worker-2:  ]
    worker-2: + 
    worker-2: sh
    worker-2:  -c
    worker-2:  apt-get install -y -qq --no-install-recommends docker-ce >/dev/null
    worker-2: dpkg-preconfigure: unable to re-open stdin: No such file or directory
    worker-2: + 
    worker-2: sh
    worker-2:  -c
    worker-2:  docker version
    worker-2: Client: Docker Engine - Community
    worker-2:  Version:
    worker-2:         
    worker-2:    
    worker-2: 19.03.8
    worker-2:  API version:
    worker-2:        
    worker-2: 1.40
    worker-2:  Go version:
    worker-2:         
    worker-2: go1.12.17
    worker-2:  Git commit:
    worker-2:         
    worker-2: afacb8b7f0
    worker-2:  Built:
    worker-2:         
    worker-2:      
    worker-2: Wed Mar 11 01:25:46 2020
    worker-2:  OS/Arch:
    worker-2:         
    worker-2:    
    worker-2: linux/amd64
    worker-2:  Experimental:
    worker-2:       
    worker-2: false
    worker-2: Server: Docker Engine - Community
    worker-2:  Engine:
    worker-2:   Version:
    worker-2:         
    worker-2:   
    worker-2: 19.03.8
    worker-2:   API version:      1.40 (minimum version 1.12)
    worker-2:   Go version:       go1.12.17
    worker-2:   Git commit:       afacb8b7f0
    worker-2:   Built:            Wed Mar 11 01:24:19 2020
    worker-2:   OS/Arch:          linux/amd64
    worker-2:   Experimental:     false
    worker-2:  containerd:
    worker-2:   Version:          1.2.13
    worker-2:   GitCommit:        7ad184331fa3e55e52b890ea95e65ba581ae3429
    worker-2:  runc:
    worker-2:   Version:          1.0.0-rc10
    worker-2:   GitCommit:        dc9208a3303feef5b3839f4323d9beb36df0a9dd
    worker-2:  docker-init:
    worker-2:   Version:          0.18.0
    worker-2:   GitCommit:        fec3683
    worker-2: If you would like to use Docker as a non-root user, you should now consider
    worker-2: adding your user to the "docker" group with something like:
    worker-2: 
    worker-2:   sudo usermod -aG docker your-user
    worker-2: 
    worker-2: Remember that you will have to log out and back in for this to take effect!
    worker-2: 
    worker-2: WARNING: Adding a user to the "docker" group will grant the ability to run
    worker-2:          containers which can be used to obtain root privileges on the
    worker-2:          docker host.
    worker-2:          Refer to https://docs.docker.com/engine/security/security/#docker-daemon-attack-surface
    worker-2:          for more information.
==> worker-2: Running provisioner: allow-bridge-nf-traffic (shell)...
    worker-2: Running: /tmp/vagrant-shell20200406-8383-jvtzjp.sh
    worker-2: net.bridge.bridge-nf-call-iptables = 1
==> worker-3: Box 'ubuntu/bionic64' could not be found. Attempting to find and install...
    worker-3: Box Provider: virtualbox
    worker-3: Box Version: >= 0
==> worker-3: Loading metadata for box 'ubuntu/bionic64'
    worker-3: URL: https://vagrantcloud.com/ubuntu/bionic64
==> worker-3: Adding box 'ubuntu/bionic64' (v20200402.0.0) for provider: virtualbox
==> worker-3: Importing base box 'ubuntu/bionic64'...
==> worker-3: Matching MAC address for NAT networking...
==> worker-3: Setting the name of the VM: kubernetes-ha-worker-3
==> worker-3: Fixed port collision for 22 => 2222. Now on port 2205.
==> worker-3: Clearing any previously set network interfaces...
==> worker-3: Preparing network interfaces based on configuration...
    worker-3: Adapter 1: nat
    worker-3: Adapter 2: hostonly
==> worker-3: Forwarding ports...
    worker-3: 22 (guest) => 2723 (host) (adapter 1)
    worker-3: 22 (guest) => 2205 (host) (adapter 1)
==> worker-3: Running 'pre-boot' VM customizations...
==> worker-3: Booting VM...
==> worker-3: Waiting for machine to boot. This may take a few minutes...
    worker-3: SSH address: 127.0.0.1:2205
    worker-3: SSH username: vagrant
    worker-3: SSH auth method: private key
    worker-3: 
    worker-3: Vagrant insecure key detected. Vagrant will automatically replace
    worker-3: this with a newly generated keypair for better security.
    worker-3: 
    worker-3: Inserting generated public key within guest...
    worker-3: Removing insecure key from the guest if it's present...
    worker-3: Key inserted! Disconnecting and reconnecting using new SSH key...
==> worker-3: Machine booted and ready!
==> worker-3: Checking for guest additions in VM...
    worker-3: The guest additions on this VM do not match the installed version of
    worker-3: VirtualBox! In most cases this is fine, but in rare cases it can
    worker-3: prevent things such as shared folders from working properly. If you see
    worker-3: shared folder errors, please make sure the guest additions within the
    worker-3: virtual machine match the version of VirtualBox you have installed on
    worker-3: your host and reload your VM.
    worker-3: 
    worker-3: Guest Additions Version: 5.2.34
    worker-3: VirtualBox Version: 6.1
==> worker-3: Setting hostname...
==> worker-3: Configuring and enabling network interfaces...
==> worker-3: Mounting shared folders...
    worker-3: /vagrant => /ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant
==> worker-3: Running provisioner: setup-hosts (shell)...
    worker-3: Running: /tmp/vagrant-shell20200406-8383-36hufq.sh
==> worker-3: Running provisioner: setup-dns (shell)...
    worker-3: Running: /tmp/vagrant-shell20200406-8383-1u2f6le.sh
==> worker-3: Running provisioner: install-docker (shell)...
    worker-3: Running: /tmp/vagrant-shell20200406-8383-1yd5ebj.sh
    worker-3: # Executing docker install script, commit: 442e66405c304fa92af8aadaa1d9b31bf4b0ad94
    worker-3: + 
    worker-3: sh
    worker-3:  -c
    worker-3:  apt-get update -qq >/dev/null
    worker-3: + sh -c DEBIAN_FRONTEND=noninteractive apt-get install -y -qq apt-transport-https ca-certificates curl >/dev/null
    worker-3: + sh -c curl -fsSL "https://download.docker.com/linux/ubuntu/gpg" | apt-key add -qq - >/dev/null
    worker-3: Warning: apt-key output should not be parsed (stdout is not a terminal)
    worker-3: + sh -c echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" > /etc/apt/sources.list.d/docker.list
    worker-3: + sh -c apt-get update -qq >/dev/null
    worker-3: + 
    worker-3: [
    worker-3:  -n
    worker-3:  
    worker-3:  ]
    worker-3: + 
    worker-3: sh
    worker-3:  -c
    worker-3:  apt-get install -y -qq --no-install-recommends docker-ce >/dev/null
    worker-3: dpkg-preconfigure: unable to re-open stdin: No such file or directory
    worker-3: + 
    worker-3: sh
    worker-3:  -c
    worker-3:  docker version
    worker-3: Client: Docker Engine - Community
    worker-3:  Version:
    worker-3:         
    worker-3:    
    worker-3: 19.03.8
    worker-3:  API version:
    worker-3:        
    worker-3: 1.40
    worker-3:  Go version:
    worker-3:         
    worker-3: go1.12.17
    worker-3:  Git commit:
    worker-3:         
    worker-3: afacb8b7f0
    worker-3: 
    worker-3:  Built:             Wed Mar 11 01:25:46 2020
    worker-3:  OS/Arch:           linux/amd64
    worker-3:  Experimental:      false
    worker-3: 
    worker-3: Server: Docker Engine - Community
    worker-3:  Engine:
    worker-3:   Version:          19.03.8
    worker-3:   API version:      1.40 (minimum version 1.12)
    worker-3:   Go version:       go1.12.17
    worker-3:   Git commit:       afacb8b7f0
    worker-3:   Built:            Wed Mar 11 01:24:19 2020
    worker-3:   OS/Arch:          linux/amd64
    worker-3:   Experimental:     false
    worker-3:  containerd:
    worker-3:   Version:          1.2.13
    worker-3:   GitCommit:        7ad184331fa3e55e52b890ea95e65ba581ae3429
    worker-3:  runc:
    worker-3:   Version:          1.0.0-rc10
    worker-3:   GitCommit:        dc9208a3303feef5b3839f4323d9beb36df0a9dd
    worker-3:  docker-init:
    worker-3:   Version:          0.18.0
    worker-3:   GitCommit:        fec3683
    worker-3: If you would like to use Docker as a non-root user, you should now consider
    worker-3: adding your user to the "docker" group with something like:
    worker-3: 
    worker-3:   sudo usermod -aG docker your-user
    worker-3: 
    worker-3: Remember that you will have to log out and back in for this to take effect!
    worker-3: 
    worker-3: WARNING: Adding a user to the "docker" group will grant the ability to run
    worker-3:          containers which can be used to obtain root privileges on the
    worker-3:          docker host.
    worker-3:          Refer to https://docs.docker.com/engine/security/security/#docker-daemon-attack-surface
    worker-3:          for more information.
==> worker-3: Running provisioner: allow-bridge-nf-traffic (shell)...
    worker-3: Running: /tmp/vagrant-shell20200406-8383-egl3qk.sh
    worker-3: net.bridge.bridge-nf-call-iptables = 1
==> worker-4: Box 'ubuntu/bionic64' could not be found. Attempting to find and install...
    worker-4: Box Provider: virtualbox
    worker-4: Box Version: >= 0
==> worker-4: Loading metadata for box 'ubuntu/bionic64'
    worker-4: URL: https://vagrantcloud.com/ubuntu/bionic64
==> worker-4: Adding box 'ubuntu/bionic64' (v20200402.0.0) for provider: virtualbox
==> worker-4: Importing base box 'ubuntu/bionic64'...
==> worker-4: Matching MAC address for NAT networking...
==> worker-4: Setting the name of the VM: kubernetes-ha-worker-4
==> worker-4: Fixed port collision for 22 => 2222. Now on port 2206.
==> worker-4: Clearing any previously set network interfaces...
==> worker-4: Preparing network interfaces based on configuration...
    worker-4: Adapter 1: nat
    worker-4: Adapter 2: hostonly
==> worker-4: Forwarding ports...
    worker-4: 22 (guest) => 2724 (host) (adapter 1)
    worker-4: 22 (guest) => 2206 (host) (adapter 1)
==> worker-4: Running 'pre-boot' VM customizations...
==> worker-4: Booting VM...
==> worker-4: Waiting for machine to boot. This may take a few minutes...
    worker-4: SSH address: 127.0.0.1:2206
    worker-4: SSH username: vagrant
    worker-4: SSH auth method: private key
    worker-4: 
    worker-4: Vagrant insecure key detected. Vagrant will automatically replace
    worker-4: this with a newly generated keypair for better security.
    worker-4: 
    worker-4: Inserting generated public key within guest...
    worker-4: Removing insecure key from the guest if it's present...
    worker-4: Key inserted! Disconnecting and reconnecting using new SSH key...
==> worker-4: Machine booted and ready!
==> worker-4: Checking for guest additions in VM...
    worker-4: The guest additions on this VM do not match the installed version of
    worker-4: VirtualBox! In most cases this is fine, but in rare cases it can
    worker-4: prevent things such as shared folders from working properly. If you see
    worker-4: shared folder errors, please make sure the guest additions within the
    worker-4: virtual machine match the version of VirtualBox you have installed on
    worker-4: your host and reload your VM.
    worker-4: 
    worker-4: Guest Additions Version: 5.2.34
    worker-4: VirtualBox Version: 6.1
==> worker-4: Setting hostname...
==> worker-4: Configuring and enabling network interfaces...
==> worker-4: Mounting shared folders...
    worker-4: /vagrant => /ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant
==> worker-4: Running provisioner: setup-hosts (shell)...
    worker-4: Running: /tmp/vagrant-shell20200406-8383-157gkby.sh
==> worker-4: Running provisioner: setup-dns (shell)...
    worker-4: Running: /tmp/vagrant-shell20200406-8383-ifnoyd.sh
==> worker-4: Running provisioner: install-docker (shell)...
    worker-4: Running: /tmp/vagrant-shell20200406-8383-1vgx65j.sh
    worker-4: # Executing docker install script, commit: 442e66405c304fa92af8aadaa1d9b31bf4b0ad94
    worker-4: + 
    worker-4: sh
    worker-4:  -c
    worker-4:  apt-get update -qq >/dev/null
    worker-4: + sh -c DEBIAN_FRONTEND=noninteractive apt-get install -y -qq apt-transport-https ca-certificates curl >/dev/null
    worker-4: + sh -c curl -fsSL "https://download.docker.com/linux/ubuntu/gpg" | apt-key add -qq - >/dev/null
    worker-4: Warning: apt-key output should not be parsed (stdout is not a terminal)
    worker-4: + sh -c echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" > /etc/apt/sources.list.d/docker.list
    worker-4: + sh -c apt-get update -qq >/dev/null
    worker-4: + 
    worker-4: [
    worker-4:  -n
    worker-4:  
    worker-4:  ]
    worker-4: + 
    worker-4: sh
    worker-4:  -c
    worker-4:  apt-get install -y -qq --no-install-recommends docker-ce >/dev/null
    worker-4: dpkg-preconfigure: unable to re-open stdin: No such file or directory
    worker-4: + 
    worker-4: sh -c docker version
    worker-4: Client: Docker Engine - Community
    worker-4:  Version:
    worker-4:         
    worker-4:    
    worker-4: 19.03.8
    worker-4:  API version:
    worker-4:        
    worker-4: 1.40
    worker-4:  Go version:
    worker-4:         
    worker-4: go1.12.17
    worker-4:  Git commit:
    worker-4:         
    worker-4: afacb8b7f0
    worker-4:  Built:
    worker-4:         
    worker-4:      
    worker-4: Wed Mar 11 01:25:46 2020
    worker-4:  OS/Arch:
    worker-4:         
    worker-4:    
    worker-4: linux/amd64
    worker-4:  Experimental:
    worker-4:       
    worker-4: false
    worker-4: Server: Docker Engine - Community
    worker-4:  Engine:
    worker-4:   Version:
    worker-4:         
    worker-4:   
    worker-4: 19.03.8
    worker-4:   API version:
    worker-4:       
    worker-4: 1.40 (minimum version 1.12)
    worker-4:   Go version:
    worker-4:        
    worker-4: go1.12.17
    worker-4:   Git commit:
    worker-4:        
    worker-4: afacb8b7f0
    worker-4:   Built:
    worker-4:             Wed Mar 11 01:24:19 2020
    worker-4:   OS/Arch:
    worker-4:         
    worker-4:   
    worker-4: linux/amd64
    worker-4:   Experimental:
    worker-4:      
    worker-4: false
    worker-4:  containerd:
    worker-4:   Version:
    worker-4:         
    worker-4:   
    worker-4: 1.2.13
    worker-4:   GitCommit:
    worker-4:         
    worker-4: 7ad184331fa3e55e52b890ea95e65ba581ae3429
    worker-4:  runc:
    worker-4:   Version:
    worker-4:         
    worker-4:   
    worker-4: 1.0.0-rc10
    worker-4:   GitCommit:
    worker-4:         
    worker-4: dc9208a3303feef5b3839f4323d9beb36df0a9dd
    worker-4:  docker-init:
    worker-4:   Version:
    worker-4:         
    worker-4:   
    worker-4: 0.18.0
    worker-4:   GitCommit:
    worker-4:         
    worker-4: fec3683
    worker-4: If you would like to use Docker as a non-root user, you should now consider
    worker-4: adding your user to the "docker" group with something like:
    worker-4: 
    worker-4:   sudo usermod -aG docker your-user
    worker-4: 
    worker-4: Remember that you will have to log out and back in for this to take effect!
    worker-4: 
    worker-4: WARNING: Adding a user to the "docker" group will grant the ability to run
    worker-4:          containers which can be used to obtain root privileges on the
    worker-4:          docker host.
    worker-4:          Refer to https://docs.docker.com/engine/security/security/#docker-daemon-attack-surface
    worker-4:          for more information.
==> worker-4: Running provisioner: allow-bridge-nf-traffic (shell)...
    worker-4: Running: /tmp/vagrant-shell20200406-8383-vu92ho.sh
    worker-4: net.bridge.bridge-nf-call-iptables = 1
arif@ariflindesk1:/ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant$ v
```

