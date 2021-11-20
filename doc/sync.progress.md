# sync / dirty / writeback progress


## invoke copy / write process and then observe
```
$ watch -n 0.5 -d grep -e Dirty: -e Writeback: /proc/meminfo
```
