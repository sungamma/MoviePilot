#!/bin/bash
diff build.yml build-docker.yml.bak > /dev/null
if [  "$?" == "0" ]; then #"$?"是上一执行命令的返回值。
    echo "nothing to change"
else
    cp build.yml build-docker.yml.bak
    cp build.yml build-docker-auto.yml
    sudo snap install yq
    yq e '.on = "push"' -i build-docker-auto.yml
    yq e '.name = "MoviePilot Docker Auto"' -i build-docker-auto.yml && echo "已更新编译文件"
    git add .
    git commit -m "update build-docker-auto.yml"
fi