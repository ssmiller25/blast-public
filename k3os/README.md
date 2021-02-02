# k3os cloud-init configuration

Configuration for k3os raw installation - espcially those without a DHCP infrastructure.  

If doing an install by hand on a subnet without DHCP, then run the following commands:

```sh
ETH0=$(connmanctl services | awk '{ print $3 }' | while read -r s1; do connmanctl services $s1 | grep -q "eth0" && echo "$s1"; done)
  connmanctl config $ETH0 --ipv4 manual <ip> <netmask> <gw> --nameservers <dns>
  connmanctl config $ETH0 --domains <domain>
  connmanctl config $ETH0 --ipv6 off    
  service connman restart
```


