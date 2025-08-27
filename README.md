## nvidia settings
create `/etc/modprobe.d/nvidia.conf` and add this line 
:w
```
options nvidia_drm modeset=1
```

## firefox
in `about:config` set toolkit.`legacyUserProfileCustomizations.stylesheets` to true