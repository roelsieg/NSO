# NSO and SAE

Download the NSO image `nso-5.3.linux.x86_64.signed.bin` and place it in the folder provision

<https://developer.cisco.com/docs/nso/#!getting-nso/getting-nso>

## SAE Install

SAE Installation is still under investigation. Availability of a download for the Core Function
Package is currently unknown. `nso-x.x.x.x-cisco-sae-core-fp-x.x.x.tar.gz`  Should be placed in the
provision directory.

<https://software.cisco.com/download/home/286323467/type/286321795/release/2.2.0>

## Getting started

```bash
vagrant up
vagrant ssh nso
/opt/ncs/bin/ncs_cli -u admin
```

http://127.0.0.1:8080/login.html login admin:admin
