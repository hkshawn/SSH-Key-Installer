使用示例
从 GitHub 获取公钥并禁用密码登录：

bash <(curl -fsSL git.io/key.sh) -g YourGitHubUsername -d
从自定义 URL 获取公钥并修改 SSH 端口：

bash <(curl -fsSL git.io/key.sh) -u https://your-domain.com/your-key.pub -p 2222
从本地文件安装公钥：

bash <(curl -fsSL git.io/key.sh) -f /path/to/your/key.pub
覆盖模式安装并禁用密码登录：

bash <(curl -fsSL git.io/key.sh) -o -g YourGitHubUsername -d
注意事项
脚本需要 root 权限才能运行。
如果使用 -d 选项，密码认证将被禁用，请确保你的 SSH 密钥正确无误。
建议在使用此脚本之前备份你的 SSH 配置。
如果你的服务器在防火墙后面，请确保 SSH 端口（默认 22 或你自定义的端口）是开放的。
常见问题
Q: 如何为多个用户安装 SSH 密钥？
A: 你可以多次运行脚本，每次指定不同的用户和对应的密钥来源。

Q: 使用 -p 选项修改 SSH 端口后需要做什么？
A: 修改端口后，请确保在防火墙中开放新端口，并使用新端口进行 SSH 连接。

贡献
欢迎提交 Issues 和 Pull Requests。对于重大更改，请先开 Issue 讨论你想要改变的内容。

许可证
本项目采用 MIT 许可证。详情请见 LICENSE 文件。

致谢
本脚本基于 P3TERX 的工作，并进行了修改以适应 GCP 环境。感谢 P3TERX 的开源贡献。

