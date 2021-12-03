# Ansible NSO automaton test

The objective of this quick test with Asnible is to see if we can setup automation with Ansible
towards NSO. We use the datacentre example from `/opt/ncs/examples.ncs/datacenter/datacenter`

Just as example of a change with ansible I adjust the name of one of the ASRs.

You need to use the `ansible-galaxy collection install cisco.nso` command to get the collection.

```csh
root@ubuntu-focal:/opt/ncs/bin# /opt/ncs/bin/ncs_cli -u admin

User admin last logged in 2021-11-29T10:32:44.027179+00:00, to ubuntu-focal, from 127.0.0.1 using cli-console
admin connected from 127.0.0.1 using console on ubuntu-focal
admin@ncs> switch cli
admin@ncs# config
Entering configuration mode terminal
admin@ncs(config)# devices device asr1
admin@ncs(config-device-asr1)# config interface Loopback 0
admin@ncs(config-if)# ipv4 address 10.0.0.1 255.255.255.255
admin@ncs(config-if)# commit dry-run outformat xml
result-xml {
    local-node {
        data <devices xmlns="http://tail-f.com/ns/ncs">
               <device>
                 <name>asr1</name>
                 <config>
                   <interface xmlns="http://tail-f.com/ned/cisco-ios-xr">
                     <Loopback>
                       <id>0</id>
                     </Loopback>
                   </interface>
                 </config>
               </device>
             </devices>
    }
}
```

```yaml
- name: CREATE LOOPBACK
  cisco.nso.nso_config:
    url: http://127.0.0.1:8080/jsonrpc
    username: admin
    password: admin
    data:
      tailf-ncs:devices:
        device:
        - name: asr1
          config:
            tailf-ned-cisco-ios-xr:interface:
              Loopback:
              id: '0'
```
