## RHC4TP Fedora Ansible Playbook
This is a playbook for configuring a Fedora system for use as a Red Hat workstation (specifically to use Fedora in place of RHEL 7 CSB).

In order to use this playbook, you'll need to install Ansible on your Fedora laptop. That can be done rather simply:

```
# dnf install ansible
```

You can use the playbook as-is, which will use default values for all variables (you will be prompted for the `sudo` password):

```
$ tar -xzvf fedora-ansible-0.2.0.tar.gz
$ cd fedora-ansible/
$ ansible-playbook -i hosts -bK playbooks/fedora.yml
```

This playbook will run against the local machine and configure things like CUPS printing, VPN access and Kerberos SSO. It will also install additional packages selected by the RHC4TP team.

The included Ansible role uses the following variables (which can be overridden using `--extra-vars`):

| Variable Name  | Default Value  | Description
|----------------|----------------|:------------------------------------------------------
| *virt_domain*  | ansible_domain | Domain name used to assign to libvirt VMs and OCP apps 
| *fedora_pkgs*  | See below      | List of packages to be installed by the `dnf` package manager

A breakdown of the playbook and role format is below:

| File/Directory                                  | Description
|:------------------------------------------------|:-----------------------------------------------------------------------
| *fedora-ansible/*                               | Base playbook directory
| *fedora-ansible/hosts*                          | Ansible inventory file containing `localhost` and setting the `ansible_connection` var to `local` (instead of the default `ssh`)
| *fedora-ansible/playbooks/fedora.yml*           | Primary playbook used to call the `fedora` role
| *fedora-ansible/roles/fedora/*                  | Fedora ansible role configuring and installing common packages
| *fedora-ansible/roles/fedora/defaults/main.yml* | An array of packages to be installed by dnf on the Fedora host
| *fedora-ansible/roles/minikube/*                | Minkube role that installs a minikube cluster on the Fedora host (optional)
| *fedora-ansible/roles/libvirt/*                 | Libvirt/KVM role installs libvirt (required for minikube) and configures libvirt networking and dns (optional)

### Known Issues
The following items are either issues that are known to exist or features that are currently lacking:

* The current user isn't added to the `libvirt` group for access to things like `virt-manager`.
* Libvirt network configuration *breaks DNS resolution* on hosts without a properly formatted FQDN (hostname.example.local or hostname.example.com *not* hostname.local or hostname.example).
