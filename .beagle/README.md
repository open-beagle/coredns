# coredns

```bash
git remote add upstream git@github.com:coredns/coredns.git
git fetch upstream
git merge v1.11.4
```

## build

```bash
# build
docker run -it --rm \
  -w /go/src/github.com/coredns/coredns \
  -v $PWD/:/go/src/github.com/coredns/coredns \
  registry.cn-qingdao.aliyuncs.com/wod/golang:1.24 \
  rm -rf vendor && go mod tidy && go mod vendor

# build
docker run -it --rm \
  -w /go/src/github.com/coredns/coredns \
  -v $PWD/:/go/src/github.com/coredns/coredns \
  registry.cn-qingdao.aliyuncs.com/wod/golang:1.24 \
  bash .beagle/build.sh

# devops-docker
docker run -it --rm \
  -w /go/src/github.com/coredns/coredns \
  -v $PWD/:/go/src/github.com/coredns/coredns \
  -e CI_WORKSPACE=/go/src/github.com/coredns/coredns \
  -e PLUGIN_BASE=registry.cn-qingdao.aliyuncs.com/wod/alpine:3 \
  -e PLUGIN_DOCKERFILE=.beagle/dockerfile \
  -e PLUGIN_REPO=wod/coredns \
  -e PLUGIN_VERSION='v1.11.4' \
  -e PLUGIN_ARGS='TARGETOS=linux,TARGETARCH=amd64' \
  -e PLUGIN_REGISTRY=registry.cn-qingdao.aliyuncs.com \
  -e REGISTRY_USER=${REGISTRY_USER_ALIYUN} \
  -e REGISTRY_PASSWORD=${REGISTRY_PASSWORD_ALIYUN} \
  -v /var/run/docker.sock:/var/run/docker.sock \
  registry.cn-qingdao.aliyuncs.com/wod/devops-docker:1.0
```
