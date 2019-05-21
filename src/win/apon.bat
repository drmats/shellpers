@echo on
netsh wlan set hostednetwork mode=allow ssid=dummy key=abcdefghijkl keyUsage=persistent
netsh wlan start hostednetwork
pause
