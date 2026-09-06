# porest-home

`porest.cloud` 루트에 나가는 그룹 홈페이지. **정적 파일 하나(`index.html`)** 다 — 빌드 없음, 의존성 없음(글꼴만 Google Fonts).

| 파일 | 역할 |
|---|---|
| `index.html` | 페이지 전부. 글·스타일·스크립트가 한 파일에 있다 |
| `Dockerfile` | 비루트 nginx(8080)에 `index.html` 을 담는다. `porest-desk-guide` 와 같은 모양 |
| `nginx.conf` | 컨테이너 안 nginx. 어떤 경로로 와도 `index.html` |
| `Jenkinsfile` | `porest-desk-guide` 와 같은 파이프라인 — dev 는 브랜치·태그, prod 는 `vX.Y.Z` 태그만, 승인 후 배포 |

## 고치는 법

`index.html` 을 고쳐 PR → 머지 → 태그 → Jenkins `porest-home` 잡에서 prod 배포. 그게 전부다.
서비스 링크(`hr.` `desk.` `sso.porest.cloud`)와 설명 문구만 이 파일 안에서 바꾼다.

## 엣지 nginx (서버 `nginx/prod/nginx.conf` · `nginx/dev/nginx.conf`)

처음 한 번 아래 블록을 넣는다. **이 블록이 `default_server` 다** — 어느 `server_name` 에도 안 걸리는 요청
(IP 직접 접근, 모르는 호스트)이 hr 로 떨어지던 것을 여기서 받는다.

```nginx
    # 그룹 홈페이지 — porest-home. 기본 서버: 이름이 안 맞는 요청도 여기로 온다
    server {
        listen 443 ssl default_server;
        http2 on;
        server_name porest.cloud www.porest.cloud;
        # ssl_certificate 줄들은 다른 블록과 같게

        location / {
            set $home http://home-prod:8080;
            proxy_pass $home;
            proxy_set_header Host $host;
            proxy_set_header X-Forwarded-Proto https;
        }
    }
```

dev 는 `home-dev:8080` 으로, `listen 10443 ssl default_server` 로 같은 블록을 넣는다.
컨테이너 이름은 Jenkinsfile 의 `CONTAINER_NAME=home` 에서 나온다(`home-prod` / `home-dev`).

검사·반영은 서버 규칙대로 (`nginx -t` 는 `-c` 로 그 파일을 지정해야 한다).
