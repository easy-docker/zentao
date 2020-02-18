# docker-zentao

禅道

首先安装数据库,之后再安装禅道。

可挂载目录
/app/zentaopms:该目录为禅道目录，里面包含禅道代码及附件上传目录。

首次运行容器后，浏览器访问 http://IP:端口 ，如果界面显示禅道安装界面，说明容器运行正常。
依照安装程序，最后将禅道安装成功，就可以使用禅道了。

```
docker run -d --name mysql \
    -e MYSQL_ROOT_PASSWORD=l5Aqn59akWD4psPd \
    -e MYSQL_LOG_CONSOLE=true \
    -v /data/mysql:/var/lib/mysql \
    -p 3306:3306 \
    --restart always \
    mariadb:10

docker run --name gzentao \
    --restart=always \
    -p 8888:80 \
    -v /data/zentao:/app/zentaopms \
    -d ghostry/zentao
```
