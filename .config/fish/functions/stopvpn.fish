# Defined in - @ line 1
function stopvpn --wraps=nmcli\ c\ d\ UMB\\\ SOM\\\ VPN --description alias\ stopvpn\ nmcli\ c\ d\ UMB\\\ SOM\\\ VPN
  nmcli c d UMB\ SOM\ VPN $argv;
end
