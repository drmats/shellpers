# kernel params with grubby

## get current config
```
grubby --info ALL
```

## add params to all entries
```
grubby --args="rd.driver.blacklist=nouveau modprobe.blacklist=nouveau nvidia-drm.modeset=1" --update-kernel ALL
```

## remove params from all entries
```
grubby --remove-args="intel_iommu=on iommu=pf" --update-kernel ALL
```
