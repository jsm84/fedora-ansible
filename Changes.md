# List of Changes Sept 2021:

* fixed libvirt role due to changes in package names, and fixed storage pool permissions
* added optional support for the latest Google Chrome official with added kerberos support (with new extra var `install_chrome`)
* updated fedora role to install chromium-freeworld (again) if `install_codecs` is enabled and `install_chrome` is disabled
* added hands-free installation of the latest version of CodeReady Containers
* fixed the nuxref (sabnzbd) yum/dnf repository by reverting to the Fedora 33 repo (none exists for F34)
* fixed an issue with systemd power management when booting certain Lenovo laptops in docked mode w/closed lid
