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
  kubectl create namespace cf-operator
  helm repo \
    add quarks https://cloudfoundry-incubator.github.io/quarks-helm/
  helm install quarks/cf-operator -n cf-operator --generate-name
}

function install_kubecf(){
  echo " --- installing kubecf --- "
  helm install kubecf \
    --namespace kubecf \
    --values ./assets/kubecf/deployment.yml \
    https://github.com/SUSE/kubecf/releases/download/v0.2.0/kubecf-0.2.0.tgz
}

check_helm
install_cf_operator
install_kubecf
