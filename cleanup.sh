#!/bin/bash

# 移除插件缓存及临时文件
rm -rf /var/jenkins_home/plugins/*.hpi.pinned
rm -rf /var/jenkins_home/plugins/*.hpi
rm -rf /var/jenkins_home/war
rm -rf /var/jenkins_home/cache
