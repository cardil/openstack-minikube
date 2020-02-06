#!/usr/bin/env bash

set -Eeuo pipefail

# shellcheck disable=SC1090
source "$(dirname "$0")/lib/crio.bash"
# shellcheck disable=SC1090
source "$(dirname "$0")/lib/kubelet.bash"
# shellcheck disable=SC1090
source "$(dirname "$0")/lib/minikube.bash"

readonly kubeversion="${1:-1.17.2}"

ensure.container.installed
ensure.minikube.installed
ensure.minikube.started "${kubeversion}"
