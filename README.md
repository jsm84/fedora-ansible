## RHC4TP Fedora Ansible Playbook
This is a playbook for configuring a Fedora system for use as a Red Hat workstation (specifically to use Fedora in place of RHEL CSB).

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
| *playbooks/fedora.yml*           | Primary playbook which installs essential productivity, developer and container tools, in addition to web browser and multimedia codecs from RPM Fusion
| *playbooks/libvirt.yml*          | Installs libvirt and virt-manager for handling virtual machines under the Linux kernel KVM hypervisor
| *playbooks/rhworkstation.yml*    | Provided for internal use (requires additional RPM packages to configure CUPS, VPN profiles and Kerberos SSO)
| *playbooks/minikube.yml*         | Installs Minikube (dates to 01/2021)
| *playbooks/extras.yml*           | Installs Steam and wine by default, plus optional NVIDIA drivers, USENET, artwork, media players and audio workstation packages
| *playbooks/crc.yml*              | CodeReady Containers installation

### Customizable Settings
The following options are available as (mostly) boolean variables which can be customized using `--extra-vars` or changed in the respective playbook or role.
This list is not exhaustive. Please see the defaults/main.yml for each applicable ansible role for a full list of variables. 

| Variable Name            | Role    | Default Value        | Description
|--------------------------|---------|----------------------|:------------------------------------------------------------------------------------------------
| *laptop_pmfix*           | fedora  | true                 | Fixes an issue w/systemd preventing a closed-lid, docked laptop from booting
| *install_base*           | fedora  | true                 | Essential packages to be installed by default
| *install_cloud*          | fedora  | true                 | Cloud and container related tooling
| *install_devel*          | fedora  | true                 | Development frameworks and DevOps tooling
| *install_codecs*         | fedora  | false                | Optionally install non-free multimedia codecs and browswer functionality
| *configure_network*      | libvirt | true                 | Configure the default libvirt network with a domain name to assign virtual hosts
| *configure_storage*      | libvirt | true                 | Modifies the default storage location for VM disks
| *modify_default_network* | libvirt | true                 | Choose wheter to create a new network for libvirt or modify the default/existing network
| *vm_storage_dir*         | libvirt | /home/libvirt/images | Sets the VM disk storage location to the /home volume (usually much larger than the root volume)
| *install_drivers*        | extras  | true                 | NVIDIA graphics drivers, plus Razer and Corsair peripheral utilities, but only if such devices are detected
| *install_spotify*        | extras  | false                | Spotify LPF package; currently requires user post-configuration via `lpf update`
| *install_media_players*  | extras  | false                | VLC, MPV and SMPlayer
| *install_usenet*         | extras  | false                | Installs sabnzbd client for USENET access
| *install_artwork*        | extras  | false                | Purely optional, official Fedora desktop backgrounds
| *install_daw*            | extras  | false                | Installs digital audio workstation (DAW) utilities

