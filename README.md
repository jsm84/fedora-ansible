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
| Variable Name  | Default Value  | Description
|----------------|----------------|:------------------------------------------------------
| *virt_domain*  | ansible_domain | Domain name used to assign to libvirt VMs and OCP apps 
| *ocp_public_ip*| 127.0.0.1      | IP address of an OpenShift router endpoint to assign the hostname `apps.<virt_domain>` for access to OpenShift apps 
| *fedora_pkgs*  | See below      | List of packages to be installed by the `dnf` package manager

A breakdown of the playbook and role format is below:
| File/Directory                                  | Description
|:------------------------------------------------|:-----------------------------------------------------------------------
| *fedora-ansible/*                               | base playbook directory
| *fedora-ansible/hosts*                          | ansible inventory file containing `localhost` and setting the `ansible_connection` var to `local` (instead of the default `ssh`)
| *fedora-ansible/playbooks/fedora.yml*           | primary playbook used to call the `fedora` role
| *fedora-ansible/roles/fedora/*                  | Fedora ansible role containing all of the defined state
| *fedora-ansible/roles/fedora/files/*            | static configuration files and RPMs
| *fedora-ansible/roles/fedora/tasks/main.yml*    | the list of tasks to be beformed by the role
| *fedora-ansible/roles/fedora/defaults/main.yml* | default values for the the three primary variables mentioned above
| *fedora-ansible/roles/fedora/handlers/main.yml* | defines a handler to restart the CUPS print service after modifying the CUPS config file

### Known Issues
The following items are either issues that are known to exist or features that are currently lacking:

* There is a circular dependency when installing the RH VPN profile RPMs, where you have to have access to the VPN in order to download the packages (this would only work for those based at a RH office). The actual RPMs will need to be included in the `files/` dir, then copied to the system `/tmp` and installed via the `dnf` ansible module.
* The libvirt/dnsmasq ability to resolve friendly hostnames of local VMs is only partially implemented. This will need to be completed using the `virt_net` modules for Ansible, in order to set the preferred domain name (in the `virt_domain` var) in the `default` network for libvirt. A `virsh destroy default` command will also need to be issued for the config to take effect (and NetworkManager restarted).
* The nested virtualization flag under the kernel's `/sys` filesystem currently isn't enabled.
* The `docker` group isn't added to the system, and the primary user account isn't added to the `docker` group. This means that all `docker` commands must be issued as root.
* Several other things that haven't been thought of yet.
