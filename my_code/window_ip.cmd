set /p id="static(1)/dhcp(2):"

if %id% == 1 GOTO static
if %id% == 2 GOTO dhcp

:static
netsh interface ipv4 set  address name="vEthernet (wifi)" static 192.168.1.241 255.255.255.0 192.168.1.1
netsh interface ipv4  set dnsservers name="vEthernet (wifi)"  static 192.168.1.1 primary
GOTO END

:dhcp
netsh interface ipv4 set  address name="vEthernet (wifi)" source=dhcp
netsh interface ipv4  set dnsservers name="vEthernet (wifi)"  dhcp

:END
pause
