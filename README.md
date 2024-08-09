# my-jenkins

##  My-Jenkins Docker Automation
##  使用最新的 jenkins:lts-jdk17 镜像作为基础镜像


## 1.目录结构
```
/              
├── docker-compose.yml          Docker 服务配置示例文件
├── Dockerfile                  构建配置文件
├── jenkins.yaml                jenkins配置文件
├── deploy.sh                   jenkins构建shell
├── init.groovy.d               Jenkins Groovy 脚本目录
│   ├── basic-security.groovy   配置 Jenkins 的安全设置
```

## 2.构建启动和容器常用操作
### 2.1 编译并启动容器
docker-compose up -d --build

### 2.2 停止所有docker compose容器
docker-compose down

### 2.3 删除容器
docker-compose rm my_container_name

### 2.4 删除容器和镜像
docker rmi my_image:latest
