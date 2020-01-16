#!/usr/bin/env bash

set -Eeuo pipefail

function ensure.container.installed {
  local patchfile
  
  # FIXME: Remove this after https://bugzilla.redhat.com/show_bug.cgi?id=1754170 is fixed
  if ! grep -q 'updates/testing' /etc/yum.repos.d/fedora-updates-modular.repo; then
    if ! rpm -q --nosignature --nodigest --qf '%{VERSION}-%{RELEASE}.%{ARCH}' patch > /dev/null; then
      yum install -y patch
    fi
    patchfile="/vagrant/src/lib/updates-modular-enable-testing.patch"
    patch --directory=/ --strip=0 < "${patchfile}"
  fi

  if ! rpm -q --nosignature --nodigest --qf '%{VERSION}-%{RELEASE}.%{ARCH}' cri-o > /dev/null; then
    yum module enable cri-o:1.16 -y
    yum install -y cri-o
    systemctl enable --now crio
  fi
  if ! rpm -q --nosignature --nodigest --qf '%{VERSION}-%{RELEASE}.%{ARCH}' cri-tools > /dev/null; then
    yum install -y cri-tools
  fi
  if ! rpm -q --nosignature --nodigest --qf '%{VERSION}-%{RELEASE}.%{ARCH}' iptables > /dev/null; then
    yum install -y iptables
    update-alternatives --set iptables /usr/sbin/iptables-legacy
  fi
  if ! [ -f /bin/docker ]; then
    ln -s "$(command -v crictl)" /bin/docker
  fi
}