# Dockerfile
FROM jenkins/jenkins:lts-jdk17

USER root

# 安装必要的软件
RUN apt-get update && apt-get install -y \
    vim \
    tini \
    sudo \
    git \
    && rm -rf /var/lib/apt/lists/*
    
# 备份原有 sudoers 文件并添加新权限规则
RUN cp /etc/sudoers /etc/sudoers.bak && \
    echo "jenkins ALL=(ALL) NOPASSWD: /bin/mkdir, /bin/chown, /bin/cp, /bin/rm, /usr/bin/git" >> /etc/sudoers

# 复制配置文件和插件列表
COPY jenkins.yaml /var/jenkins_home/jenkins.yaml
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

# 复制初始化脚本
COPY init.groovy.d/ /usr/share/jenkins/ref/init.groovy.d/

# 清理 Jenkins 插件和缓存
RUN rm -rf /var/jenkins_home/plugins/*.hpi.pinned && \
    rm -rf /var/jenkins_home/plugins/*.hpi && \
    rm -rf /var/jenkins_home/war && \
    rm -rf /var/jenkins_home/cache

# 安装 Jenkins 插件
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt

# 切换到 jenkins 用户
USER jenkins

# 使用 tini 作为 entrypoint
ENTRYPOINT ["/usr/bin/tini", "--", "/usr/local/bin/jenkins.sh"]