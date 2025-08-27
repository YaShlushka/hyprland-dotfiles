## nvidia settings
create `/etc/modprobe.d/nvidia.conf` and add this line 
:w
```
options nvidia_drm modeset=1
```
in `/etc/mkinitcpio.conf` edit `MODULES` to this and then rebuild initramfs with `sudo mkinitcpio -P`
```
MODULES=(i915 nvidia nvidia_modeset nvidia_uvm nvidia_drm)
```
in `/etc/default/grub` add to `GRUB_CMDLINE_LINUX_DEFAULT` this `nvidia_drm.modeset=1`
```
GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet nvidia_drm.modeset=1"
```
rebuild grub `sudo grub-mkconfig -o /boot/grub/grub.cfg`

## firefox
in `about:config` set toolkit.`legacyUserProfileCustomizations.stylesheets` to true