# Zabbix Template to get values for TCP stack
https://danielfm.me/posts/painless-nginx-ingress.html

TCP/UDP queues

Support zabbix v3.4

    1) Import template to zabbix server

    2) Copy files to /etc/zabbix/scripts

Script usage:
    python check_tcp_stack.py -h


To DO:
    Still lack of support for UDP statistics


FreePBX

Support zabbix v3.4
Monitoring state of trunks and peers for FreePBX 13


    1) Import template to zabbix server

    2) Copy files to /etc/zabbix/scripts

Script usage:
  -   ./freepbx-autodiscovery.sh trunks
  -   ./freepbx-autodiscovery.sh trunk {trunkname}
