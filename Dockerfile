# 베이스는 버전을 고정한다 — 움직이는 태그는 빌드 시점 따라 내용물이 바뀐다. 업데이트는 태그를 올려서.
# 빌드 단계가 없다 — 정적 파일 하나라 그대로 담는다.
# 비루트(uid 101) nginx. 1024 미만 포트를 못 물어 8080 을 쓴다.
# 엣지 nginx(prod/dev)의 프록시 대상도 :8080 이어야 한다 — 서버 conf 와 동시 전환.
FROM nginxinc/nginx-unprivileged:1.29.4-alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY index.html /usr/share/nginx/html/index.html

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget -qO- http://127.0.0.1:8080/ >/dev/null || exit 1

CMD ["nginx", "-g", "daemon off;"]
