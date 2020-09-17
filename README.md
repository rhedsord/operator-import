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

##Copy kubeconfig 
```
cd  /root/deploy/secrets/cluster/auth/ 
cat kubeconfig 
save the output and copy that to templates/auth.json
```

##Modify vars
In the operator-import/vars directory change the global vars change localhost to the registry name

##Run 
As the root user kick off the upstream import. This will take 4-8 hours to import all of the images contained in Red hat and community operator catalogs. 
```
cd /root/operator-import
bash tools/dev.sh
./upstream.yaml -vv
```

## Custom images 
To get images not associated with the catalogs edit 
* templates/custom-mapping.j2 with the images you wish to import. 
* Run the custom-image-import.yaml 
```
./custom-image-import.yaml -vv 
```



## Example single image mirror
```oc image mirror --force --filter-by-os=.* --keep-manifest-list=true --registry-config /root/auth.json --insecure=true 'quay.io/projectquay/quay:qui-gon' "registry.spartaeast.spo-east.io:5000/projectquay/quay" ```