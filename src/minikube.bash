#!/usr/bin/env bash

set -Eeuo pipefail

# shellcheck disable=SC1090
source "$(dirname "$0")/crio.bash"
# shellcheck disable=SC1090
source "$(dirname "$0")/minikube.bash"

readonly kubeversion="${1:-1.17.0}"

ensure.container.installed
ensure.minikube.installed
ensure.minikube.started "${kubeversion}"
