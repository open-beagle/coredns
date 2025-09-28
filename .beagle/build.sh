# /bin/bash

set -ex

export GO111MODULE=on
export CGO_ENABLED=0

git config --global --add safe.directory $PWD

GIT_COMMIT=$(git rev-parse --short HEAD)

LDFLAGS=(
  "-w -s"
  "-X github.com/coredns/coredns/coremain.GitCommit=${GIT_COMMIT}"
)

# version patch 版本号补丁
git apply .beagle/v1.11.3-kubernetai.patch

export GOARCH=amd64
go build -o ./build/coredns-$GOARCH -ldflags "${LDFLAGS[*]}" .

export GOARCH=arm64
go build -o ./build/coredns-$GOARCH -ldflags "${LDFLAGS[*]}" .

git apply -R .beagle/v1.11.3-kubernetai.patch
