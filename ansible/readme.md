# Ansible NSO automaton test

The objective of this quick test with Asnible is to see if we can setup automation with Ansible
towards NSO. We use the datacentre example from `/opt/ncs/examples.ncs/datacenter/datacenter`

Just as example of a change with ansible I adjust the name of one of the ASRs.

```csh
root@ubuntu-focal:/opt/ncs/bin# /opt/ncs/bin/ncs_cli -u admin

User admin last logged in 2021-11-29T10:32:44.027179+00:00, to ubuntu-focal, from 127.0.0.1 using cli-console
admin connected from 127.0.0.1 using console on ubuntu-focal
admin@ncs> switch cli
admin@ncs# config
Entering configuration mode terminal
admin@ncs(config)# devices device asr1
admin@ncs(config-device-asr1)# config hostname asr01
admin@ncs(config-config)# commit dry-run outformat xml
result-xml {
    local-node {
        data <devices xmlns="http://tail-f.com/ns/ncs">
               <device>
                 <name>asr1</name>
                 <config>
                   <hostname xmlns="http://tail-f.com/ned/cisco-ios-xr">asr01</hostname>
                 </config>
               </device>
             </devices>
    }
}
```

```yaml
- name: ADJUST HOSTNAME
  cisco.nso.nso_config:
    url: http://127.0.0.1:8080/jsonrpc
    username: developer
    password: C1sco12345
    data:
        tailf-ncs:devices:
        device:
        - name: asr1
          config:
            tailf-ned-cisco-ios-xr:hostname: "asr01"
```
