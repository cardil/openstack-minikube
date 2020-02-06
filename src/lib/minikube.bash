#!/usr/bin/env bash

set -Eeuo pipefail

function ensure.minikube.installed {
  local version
  echo '+ensure.minikube.installed'
  if ! rpm -q --nosignature --nodigest --qf '%{VERSION}-%{RELEASE}.%{ARCH}' minikube > /dev/null; then
    version=$(curl -sL \
      https://api.github.com/repos/kubernetes/minikube/releases/latest \
      | grep -oP '"tag_name": "\K(.*)(?=")')
    version="${version:1}"
    yum install -y https://github.com/kubernetes/minikube/releases/download/v${version}/minikube-${version}-0.x86_64.rpm
  fi
  ln -s /etc/pki/ca-trust/source/anchors /usr/share/ca-certificates
}

function ensure.minikube.started {
  local kubev
  echo '+ensure.minikube.started'
  kubev="${1:-1.17.2}"
  if ! minikube status | grep 'Running'; then
    minikube start \
      --vm-driver=none \
      --container-runtime=crio \
      --kubernetes-version="${kubev}" \
      --extra-config=apiserver.enable-admission-plugins="LimitRanger,NamespaceExists,NamespaceLifecycle,ResourceQuota,ServiceAccount,DefaultStorageClass,MutatingAdmissionWebhook"
  fi
}
