Ansible playbook to install a development Kubernetes (k8s) cluster
==================================================================

Basic recipes using the ansible cloudstack module to create ssh keys, etc and deploy [Kubernetes](http://kubernetes.io) on [CoreOS](http://coreos.com).
This setup is to be used for development purposes only, as there are no HA features in place.

BETA: support VPC

Prerequisites
-------------

You will need Ansible >= 2.0, sshpubkeys and [cs](https://github.com/exoscale/cs) :)

    $ sudo apt-get install -y python-pip
    $ sudo pip install ansible
    $ sudo pip install cs
    $ sudo pip install sshpubkeys

You will need kubecfg util

    $curl -O https://storage.googleapis.com/kubernetes-release/release/v1.2.3/bin/linux/amd64/kubectl
    $chmod +x kubectl
    $mv kubectl /usr/local/bin/kubectl	

You will need to patch ansible cloudstack modules to support VDC layout

    $./patch_ansible_modules.sh

Setup cloudstack
----------------

Create a `~/.cloudstack.ini` file with your creds and cloudstack endpoint, for example:

    [cloudstack]
    endpoint = https://swiss1.safeswisscloud.ch/client/api
    key = <your api access key> 
    secret = <your api secret key> 
    method = post

We need to use the http POST method to pass the userdata to the coreOS instances.

Create a Kubernetes cluster
---------------------------

VERY IMPORTANT TO SET PROPER VPC AND NETWORK NAME INSIDE THIS VPC! ONLY NAMES REQUIRED!
So, you will need to pre-create VPC and network inside this VPC and put it's names inside k8s.yml file!

    $ ansible-playbook k8s.yml

Some variables can be edited in the `k8s.yml` file.
This will start a Kubernetes master node and a number of compute nodes.

Check the tasks and templates in `roles/k8s`.

Test your cluster
-----------------

You will need `kubectl` CLI installed, the playbook will configure, set and use a new context automatically.

Then run

    $ kubectl get nodes
