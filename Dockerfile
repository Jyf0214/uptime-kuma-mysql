FROM chipsman/uptime-kuma:latest

# 切换到 root 用户以执行安装操作
USER root

# 1. 安装 Node.js 和 npm (保留你原本的需求)
# 2. 安装 curl (用于下载 cloudflared)
# 3. 下载并安装 Cloudflared (使用官方二进制文件，这是最节省空间的方式)
# 4. 设置权限
# 5. 清理不必要的缓存 (--no-cache 参数已自动处理 apk 缓存)
RUN apk add --no-cache nodejs npm curl && \
    curl -L https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -o /usr/local/bin/cloudflared && \
    chmod +x /usr/local/bin/cloudflared && \
    mkdir -p /app/data && \
    chown -R node:node /app
    
EXPOSE 3001

CMD ["node","server/server.js"]
