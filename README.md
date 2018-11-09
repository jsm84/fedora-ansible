## RHC4TP Fedora Ansible Playbook
This is a playbook for configuring a Fedora system for use as a Red Hat workstation (specifically to use Fedora in place of RHEL 7 CSB).

In order to use this playbook, you'll need to install Ansible on your Fedora laptop. That can be done rather simply:

```
# dnf install ansible
```

You can use the playbook as-is, which will use default values for all variables (you will be prompted for the `sudo` password):

```
$ tar -xzvf fedora-ansible-0.1.0.tar.gz
$ cd fedora-ansible/
$ ansible-playbook -i hosts -bK playbooks/fedora.yml
```

This playbook will run against the local machine and configure things like CUPS printing, VPN access and Kerberos SSO. It will also install additional packages selected by the RHC4TP team.

The included Ansible role uses the following variables (which can be overridden using `--extra-vars`):
* *virt_domain* - Domain name used to assign to libvirt VMs and OCP apps (can be a .local domain)
* *ocp_public_ip* - IP address of an OpenShift router endpoint, used to assign a machine-local hostname (eg: apps.exampledomain.local) for easy access to cloud or locally hosted OpenShift apps
* *fedora_pkgs* - List of packages to be installed by the `dnf` package manager (not recommended, as the default list is more than sufficient)
