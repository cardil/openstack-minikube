#!/usr/bin/env bash

set -Eeuo pipefail

function ensure.minikube.installed {
  local version
  if ! rpm -q --nosignature --nodigest --qf '%{VERSION}-%{RELEASE}.%{ARCH}' minikube > /dev/null; then
    version=$(curl -sL \
      https://api.github.com/repos/kubernetes/minikube/releases/latest \
      | grep -oP '"tag_name": "\K(.*)(?=")')
    version="${version:1}"
    yum install -y https://github.com/kubernetes/minikube/releases/download/v${version}/minikube-${version}.rpm
  fi
}

function ensure.minikube.started {
  local kubeversion
  kubeversion="${1:-1.17.0}"
  if ! minikube status | grep 'Running'; then
    minikube start \
      --vm-driver=none \
      --container-runtime=crio \
      --kubernetes-version="${kubeversion}" \
      --extra-config=apiserver.enable-admission-plugins="LimitRanger,NamespaceExists,NamespaceLifecycle,ResourceQuota,ServiceAccount,DefaultStorageClass,MutatingAdmissionWebhook"
  fi
}
