#Import openshift operators

##Prereqs: 
* Install git & podman   


##On the bastion node. 

```
sudo -i 
git clone https://github.com/rhedsord/operator-import.git
```

##Modify the auth.json to fit your environment. 
```
ssh to the registry node 

cd /root/deploy/secrets/docker

jq -s '.[0] * .[1]' auth.json config.json > combo.json

Copy that file output to the templates/auth.json
```

##Modify vars
In the operator-import/vars directory change the global vars change localhost to the registry name

##Run 

## Example single image mirror
```oc image mirror --force --filter-by-os=.* --keep-manifest-list=true --registry-config /root/auth.json --insecure=true 'quay.io/projectquay/quay:qui-gon' "registry.spartaeast.spo-east.io:5000/projectquay/quay" ```