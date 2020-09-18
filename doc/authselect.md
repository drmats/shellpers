# authselect tool with pam_cap (fedora/centos)


## create custom profile

```
# authselect current
# authselect create-profile pamcap-sssd -b sssd
```


## tweak `/etc/authselect/custom/pamcap-ssd/` `password-auth` and `system-auth`

```
# just after pam_env.so
auth required pam_cap.so
```


## create `/etc/security/capabilities.conf`

```
cap_net_admin some-chosen-username
none *
```


## activate custom profile

```
# authselect select custom/pamcap-sssd
# authselect apply-changes
```
