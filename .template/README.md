# Manjaro-bootsplash-template
Kernel Bootsplash theme for manjaro Linux using template logo

# Installation:

- run `makepkg` to create Arch package and install it with `pacman -U $package_name`
- append `bootsplash-template` hook in the end of HOOKS string of `/etc/mkinitcpio.conf`
- add `quiet bootsplash.bootfile=bootsplash-themes/manjaro-template/bootsplash` into `GRUB_CMDLINE_LINUX` string in `/etc/default/grub`
- run `sudo mkinitcpio -P`
- run `sudo update-grub`
