#!/bin/bash
# 环境变量
COMMIT_HASH="${GIT_COMMIT}"

# 配置变量
DEPLOY_DIR="/var/jenkins_home/jenkins"
WORKSPACE_DIR="/var/jenkins_home/workspace/dnmp-php" # Jenkins 工作空间路径
BACKUP_DIR="/var/jenkins_home/jenkins_backup_$(date +'%Y%m%d%H%M%S')"

echo "当前用户: $(whoami)"
echo "当前目录权限及所有者:"
ls -ld "$DEPLOY_DIR"

# 备份当前代码到备份目录
if [ -d "$DEPLOY_DIR" ]; then
  echo "备份代码到 $BACKUP_DIR..."
  cp -r "$DEPLOY_DIR" "$BACKUP_DIR"
  echo "代码备份到 $BACKUP_DIR"
fi

# 删除并重新创建部署目录
echo "删除部署目录: $DEPLOY_DIR"
rm -rf "$DEPLOY_DIR"

echo "重新创建部署目录: $DEPLOY_DIR"
mkdir -p "$DEPLOY_DIR"
chown -R jenkins:jenkins "$DEPLOY_DIR"

echo "克隆仓库到部署目录: $DEPLOY_DIR"
git clone --branch "$GIT_BRANCH" "$GIT_URL" "$DEPLOY_DIR"

# 确保目录权限正确
echo "更新目录权限..."
chown -R jenkins:jenkins "$DEPLOY_DIR"
if [ $? -eq 0 ]; then
  echo "权限更新成功"
else
  echo "权限更新失败"
  exit 1
fi

# 打印结果
cd "$DEPLOY_DIR"
echo "当前目录: $(pwd)"

# 检查 WORKSPACE_DIR 中的 .gitignore 文件内容
if [ -f "$WORKSPACE_DIR/.gitignore" ]; then
  echo "内容 .gitignore 文件:"
  cat "$WORKSPACE_DIR/.gitignore"
else
  echo "$WORKSPACE_DIR 目录下的 .gitignore 文件不存在"
fi

echo "部署完成"

# 显示目录内容
echo "DEPLOY_DIR 目录内容:"
ls -la "$DEPLOY_DIR"