# Defined in - @ line 1
function startvpn --wraps='sudo openconnect vpn.som.umaryland.edu 2 >/dev/null &' --wraps='sudo openconnect vpn.som.umaryland.edu' --wraps=nmcli\ --ask\ c\ u\ UMB\\\ SOM\\\ VPN --description alias\ startvpn\ nmcli\ --ask\ c\ u\ UMB\\\ SOM\\\ VPN
  nmcli --ask c u UMB\ SOM\ VPN $argv;
end
