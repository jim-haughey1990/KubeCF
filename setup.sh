#!/usr/bin/env bash

function check_helm(){
  if [ "$(helm version | head -n1 | cut -d"\"" -f2 | tr -d v | tr -d .)" -lt 300 ]; then
    echo "please install helm 3+"
  else
    echo "Greater than 3.0.0"
  fi
}

function install_cf_operator(){
  echo " --- installing cf operator --- "
  kubectl create namespace kubecf
  kubectl config set-context --current --namespace=kubecf
  helm repo update
  if [[ $(helm status cf-operator  || false) ]]; then
    echo "cf-operator already exists updating ..."
    HELM_VERB="upgrade"
  else 
    HELM_VERB="install"
  fi
  helm ${HELM_VERB} cf-operator \
    --namespace kubecf quarks/cf-operator

}

function install_kubecf(){
  echo " --- installing kubecf --- "
  export MINIKUBE_IP=$(minikube ip)
  envsubst < ./assets/kubecf/deployment.yml > ./assets/kubecf/my_values.yml
  if [[ $(helm status kubecf || false) ]]; then
    echo "kubecf already exists updating ..."
    HELM_VERB="upgrade"
  else 
    HELM_VERB="install"
  fi
  helm ${HELM_VERB} kubecf \
    --namespace kubecf \
    --values ./assets/kubecf/my_values.yml \
    https://github.com/cloudfoundry-incubator/kubecf/releases/download/v2.3.0/kubecf-v2.3.0.tgz
}

check_helm
install_cf_operator
install_kubecf
