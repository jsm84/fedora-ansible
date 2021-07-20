## RHC4TP Fedora Ansible Playbook
This is a playbook for configuring a Fedora system for use as a Red Hat workstation (specifically to use Fedora in place of RHEL 7 CSB).

In order to use this playbook, you'll need to install Ansible on your Fedora laptop. That can be done rather simply:

```
# dnf install ansible
```

### Available Playbooks
Most playbooks can be applied either locally or remotely, with the exception of `rhworkstation.yml` which needs rpm packages available locally.
Usage details are documented within each playbook.

| File/Directory                   | Description
|:---------------------------------|:-----------------------------------------------------------------------
| *hosts*                          | Ansible inventory file containing `localhost` with `ansible_connection=local` (overrides the default of `ssh`)
| *playbooks/fedora.yml*           | Primary playbook which installs essential productivity, developer and container tools, in addition to Fedora artwork and multimedia codecs from RPM Fusion
| *playbooks/libvirt.yml*          | Installs libvirt and virt-manager for handling virtual machines under the Linux kernel KVM hypervisor
| *playbooks/rhworkstation.yml*    | Provided for internal use (requires additional RPM packages to configure CUPS, VPN profiles and Kerberos SSO)
| *playbooks/minikube.yml*         | Installs latest version of Minikube (as of 01/2021)
| *playbooks/extras.yml*           | Installs Steam, wine, and optionally NVIDIA graphics drivers and sabnzbd (for USENET)
| *playbooks/crc.yml*              | CodeReady Container installation (coming soon)

### Customizable Settings
The following options are available as (mostly) boolean variables which can be customized using `--extra-vars` or changed in the respective playbook:

| Variable Name        | Role    | Default Value        | Description
|----------------------|---------|----------------------|:------------------------------------------------------
| *install_base*       | fedora  | true                 | Essential packages to be installed by default
| *install_cloud*      | fedora  | true                 | Cloud and container related tooling
| *install_devel*      | fedora  | true                 | Development frameworks and DevOps tooling
| *install_artwork*    | fedora  | false                | Purely optional backgrounds and beautification (cairo-dock)
| *install_codecs*     | fedora  | false                | Optionally install non-free multimedia codecs and browswer functionality
| *configure_network*  | libvirt | true                 | Configure the default libvirt network with a domain name to assign virtual hosts (negates the need to use IP addresses for host->guest ssh)
| *configure_storage*  | libvirt | true                 | Modifies the default storage location for VM disks
| *vm_storage_dir*     | libvirt | /home/libvirt/images | Sets the VM disk storage location to the /home volume (usually much larger than the root volume)
| *install_drivers*    | extras  | true                 | Installs NVIDIA graphics drivers, plus Razer and Corsair peripheral utilities
| *install_usenet*     | extras  | true                 | Installs sabnzbd client for USENET access


### TO DO
The following features are currently WIP:

* CodeReady Containers installation
* GOPATH and $HOME/bin setup for the local user
