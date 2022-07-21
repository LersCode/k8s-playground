#!/bin/bash
#set -e
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
CURRENT_DIR=$(pwd)

cd $SCRIPT_DIR/
asdf plugin-add java
asdf install java adoptopenjdk-17.0.2+8
asdf local java adoptopenjdk-17.0.2+8

asdf plugin-add golang
asdf install golang 1.18.2
asdf local golang 1.18.2

asdf plugin-add kind
asdf install kind 0.14.0
asdf local kind 0.14.0

KUBECTL_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt | cut -c2-)
echo "$KUBECTL_VERSION=$KUBECTL_VERSION"
#KUBECTL_VERSION=1.23.6
#KUBECTL_VERSION=1.24.3
asdf plugin-add kubectl
asdf install kubectl $KUBECTL_VERSION
asdf local kubectl $KUBECTL_VERSION

asdf plugin-add helm
asdf install helm 3.8.2
asdf local helm 3.8.2

asdf plugin-add kustomize
asdf install kustomize 4.5.4
asdf local kustomize 4.5.4

asdf plugin-add k9s
asdf install k9s 0.25.18
asdf local k9s 0.25.18

asdf plugin-add octant https://github.com/looztra/asdf-octant
asdf install octant 0.25.1
asdf local octant 0.25.1

asdf plugin add tilt
asdf install tilt 0.30.5
asdf local tilt 0.30.5

asdf plugin-add dive https://github.com/looztra/asdf-dive
asdf install dive 0.10.0
asdf local dive 0.10.0

echo "reload shell $SHELL"
${SHELL}

cd $CURRENT_DIR