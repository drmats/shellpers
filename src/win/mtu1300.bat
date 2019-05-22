@echo on
netsh interface ipv4 set subinterface "vpn" mtu=1300 store=persistent
netsh interface ipv4 show subinterfaces
pause
