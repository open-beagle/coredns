# remote

```bash
git remote add upstream git@github.com:coredns/coredns.git
git fetch upstream
git merge v1.9.4
```

## build

```bash
# patch
git apply .beagle/0001-kubernetai.patch

# devops-go-arch
docker run -it --rm \
-w /go/src/github.com/coredns/coredns \
-v $PWD/:/go/src/github.com/coredns/coredns \
-e CI_WORKSPACE=/go/src/github.com/coredns/coredns \
-e PLUGIN_BINARY=coredns \
-e GO111MODULE=off \
registry.cn-qingdao.aliyuncs.com/wod/devops-go-arch:1.19-alpine

# devops-docker
docker run -it --rm \
-w /go/src/github.com/coredns/coredns \
-v $PWD/:/go/src/github.com/coredns/coredns \
-e CI_WORKSPACE=/go/src/github.com/coredns/coredns \
-e PLUGIN_BASE=registry.cn-qingdao.aliyuncs.com/wod/alpine:3 \
-e PLUGIN_DOCKERFILE=.beagle/dockerfile \
-e PLUGIN_REPO=wod/coredns \
-e PLUGIN_VERSION='v1.9.4' \
-e PLUGIN_ARGS='TARGETOS=linux,TARGETARCH=amd64' \
-e PLUGIN_REGISTRY=registry.cn-qingdao.aliyuncs.com \
-e REGISTRY_USER=<REGISTRY_USER> \
-e REGISTRY_PASSWORD=<REGISTRY_PASSWORD> \
-v /var/run/docker.sock:/var/run/docker.sock \
registry.cn-qingdao.aliyuncs.com/wod/devops-docker:1.0
```

## cache

```bash
# 构建缓存-->推送缓存至服务器
docker run --rm \
  -e PLUGIN_REBUILD=true \
  -e PLUGIN_ENDPOINT=$PLUGIN_ENDPOINT \
  -e PLUGIN_ACCESS_KEY=$PLUGIN_ACCESS_KEY \
  -e PLUGIN_SECRET_KEY=$PLUGIN_SECRET_KEY \
  -e DRONE_REPO_OWNER="open-beagle" \
  -e DRONE_REPO_NAME="coredns" \
  -e PLUGIN_MOUNT="./.git,./vendor" \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  registry.cn-qingdao.aliyuncs.com/wod/devops-s3-cache:1.0

# 读取缓存-->将缓存从服务器拉取到本地
docker run --rm \
  -e PLUGIN_RESTORE=true \
  -e PLUGIN_ENDPOINT=$PLUGIN_ENDPOINT \
  -e PLUGIN_ACCESS_KEY=$PLUGIN_ACCESS_KEY \
  -e PLUGIN_SECRET_KEY=$PLUGIN_SECRET_KEY \
  -e DRONE_REPO_OWNER="open-beagle" \
  -e DRONE_REPO_NAME="coredns" \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  registry.cn-qingdao.aliyuncs.com/wod/devops-s3-cache:1.0
```
