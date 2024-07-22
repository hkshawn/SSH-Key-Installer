# SSH 密钥安装程序

## 描述

这是一个用于自动安装 SSH 公钥的 Bash 脚本，专门针对 Google Cloud Platform (GCP) 实例进行了优化。它可以帮助用户快速设置 SSH 密钥认证，提高服务器的安全性。

## 功能

- 自动下载并安装指定的 SSH 公钥
- 配置 SSH 服务以使用密钥认证
- 禁用密码认证，增强安全性
- 允许 root 用户使用 SSH 密钥登录
- 适用于 Debian、Ubuntu、CentOS 和 RHEL 系统

## 系统要求

- Debian、Ubuntu、CentOS 或 RHEL 操作系统
- Root 访问权限
- 互联网连接（用于下载 SSH 公钥）

## 使用方法

1. 下载脚本：

wget https://raw.githubusercontent.com/yourusername/your-repo/main/key.sh


2. 赋予脚本执行权限：

chmod +x key.sh


3. 运行脚本，提供 SSH 公钥的 URL 作为参数：

./key.sh https://github.com/yourusername.keys


注意：将 `https://github.com/yourusername.keys` 替换为你的 SSH 公钥 URL。

## 注意事项

- 此脚本会修改 SSH 配置。请确保你有其他方式访问服务器，以防 SSH 配置出现问题。
- 脚本执行后，密码认证将被禁用。请确保你的 SSH 密钥正确无误。
- 建议在使用此脚本之前备份你的 SSH 配置。

## 贡献

欢迎提交问题和拉取请求。对于重大更改，请先开issue讨论您想要更改的内容。

## 许可证

本项目采用 MIT 许可证。详情请见 [LICENSE](LICENSE) 文件。

## 致谢

本脚本基于 [P3TERX](https://github.com/P3TERX/SSH_Key_Installer) 的工作，并进行了修改以适应 GCP 环境。
