#Import openshift operators

##Prereqs: 
* Install git & podman   


##On the bastion node. 

```
sudo -i 
git clone https://github.com/rhedsord/operator-import.git
```

##Copy kubeconfig 
```
On the registry node

cd  /root/deploy/secrets/cluster/auth/ 
cat kubeconfig 
save the output and copy that to files/kubeconfig on the operator-import project
```

##Modify vars
In the operator-import/vars directory change the global vars change localhost to the registry name

```
sudo -i 
cd operator-import/var/
vi global.yml

Modify 

local_registry: localhost:5000 to your local registry name:

Example record: registry.redhat.exmaple.com:500
```

## OperatorHub Catalog mirror 
As the root user kick off the upstream import. This will take 4-8 hours to import all of the images contained in Red hat and community operator catalogs. I reccommend that the user runs in screen or tmux to avoid loosing connection if running from a remote location. The upstream playbook only has to be run once 
```
cd /root/operator-import
bash tools/dev.sh
./upstream.yaml -vv

This will prompt for your quay secret which can be obtained at https://cloud.redhat.com/openshift/
```

## Custom images 
To get images not associated with the catalogs edit. This playbook can be modified to add new images by editing the templates/custom-mapping.j2 and rerunning the playbook.  
* templates/custom-mapping.j2 with the images you wish to import. 
* Run the custom-image-import.yaml 
```
./custom-image-import.yaml -vv 
```



## Example single image mirror
```oc image mirror --force --filter-by-os=.* --keep-manifest-list=true --registry-config /root/auth.json --insecure=true 'quay.io/projectquay/quay:qui-gon' "registry.spartaeast.spo-east.io:5000/projectquay/quay" ```
