#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o pipefail

Green_font_prefix="\033[32m"
Red_font_prefix="\033[31m"
Green_background_prefix="\033[42;37m"
Red_background_prefix="\033[41;37m"
Font_color_suffix="\033[0m"

INFO="[${Green_font_prefix}信息${Font_color_suffix}]"
ERROR="[${Red_font_prefix}错误${Font_color_suffix}]"

# 检查是否为 root 用户
[[ $EUID -ne 0 ]] && echo -e "${ERROR} 此脚本必须以 root 身份运行！" && exit 1

# 检查是否提供了 SSH 公钥 URL
[[ -z "\$1" ]] && echo -e "${ERROR} 请提供 SSH 公钥 URL！" && exit 1

# 检查系统类型
if [[ -f /etc/redhat-release ]]; then
    release="centos"
elif cat /etc/issue | grep -q -E -i "debian"; then
    release="debian"
elif cat /etc/issue | grep -q -E -i "ubuntu"; then
    release="ubuntu"
elif cat /etc/issue | grep -q -E -i "centos|red hat|redhat"; then
    release="centos"
elif cat /proc/version | grep -q -E -i "debian"; then
    release="debian"
elif cat /proc/version | grep -q -E -i "ubuntu"; then
    release="ubuntu"
elif cat /proc/version | grep -q -E -i "centos|red hat|redhat"; then
    release="centos"
else
    echo -e "${ERROR} 未检测到系统版本，请联系脚本作者！" && exit 1
fi

# 设置 SSH 目录和 authorized_keys 文件
SSH_DIR="/root/.ssh"
AUTHORIZED_KEYS="${SSH_DIR}/authorized_keys"

# 如果 SSH 目录不存在，则创建
mkdir -p ${SSH_DIR}

# 下载并安装 SSH 密钥
if ! curl -sSL "\$1" >> ${AUTHORIZED_KEYS}; then
    echo -e "${ERROR} 下载 SSH 公钥失败！" && exit 1
fi

# 设置正确的权限
chmod 700 ${SSH_DIR}
chmod 600 ${AUTHORIZED_KEYS}

# 禁用密码认证，启用公钥认证
sed -i '/^#\?PubkeyAuthentication\s\+\w\+/c\PubkeyAuthentication yes' /etc/ssh/sshd_config
sed -i '/^#\?PasswordAuthentication\s\+\w\+/c\PasswordAuthentication no' /etc/ssh/sshd_config

# 允许 root 用户使用 SSH 密钥登录
sed -i '/^#\?PermitRootLogin\s\+\w\+/c\PermitRootLogin prohibit-password' /etc/ssh/sshd_config

# 重启 SSH 服务
if [[ ${release} == "centos" ]]; then
    systemctl restart sshd.service
else
    systemctl restart ssh
fi

echo -e "${INFO} SSH 密钥安装完成！"
echo -e "${INFO} 请尝试使用您的私钥登录。"
echo -e "${INFO} 如果无法登录，请检查您的私钥并重试。"
