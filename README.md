# Running kube cf on ubuntu

## Steps

### setup workspace
```bash
mkdir ~/workspace
cd ~/workspace
# clone repo
git clone https://github.com/jim-haughey1990/KubeCF
cd KubeCF
```

### making changes using theia ide
```bash
cd ~/workspace/
# run IDE 
docker run -it --init -p 3000:3000 \
    -u $(id -u ${USER}):$(id -g ${USER}) \
    -v "$(pwd):/home/project:cached" theiaide/theia:next
```

#### Supporting info
- Tools needed:
    - docker
    - minikube
- specs of my machine:
    - 32Gb RAM
    - 2Tb disk
- docs followed
    - [kubecf](https://github.com/cloudfoundry-incubator/kubecf)
    - [Quarks operator](https://quarks.suse.dev/docs/core-tasks/install/)
    