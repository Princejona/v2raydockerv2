FROM alpine:latest

RUN apk update && apk add --no-cache \
    wget \
    unzip \
    tzdata

# Kunin ang latest Xray core
ARG XRAY_VERSION=v26.2.6

RUN wget -O /tmp/xray.zip "https://github.com/XTLS/Xray-core/releases/download/${XRAY_VERSION}/Xray-linux-64.zip" && \
    unzip /tmp/xray.zip -d /usr/local/bin/ && \
    chmod +x /usr/local/bin/xray && \
    rm -rf /tmp/xray.zip

# Config
COPY config.json /etc/xray/config.json

# Timezone
ENV TZ=Asia/Manila

# Tanging Port 8080 na lang ang ie-expose para sa Cloud Run
EXPOSE 8080

CMD ["xray", "-c", "/etc/xray/config.json"]
