# porest-home — 작업 규칙

> **워크스페이스 공통 규칙**(Git 작업 격리 · 스테이징 범위 · 태그·릴리스)은
> 상위 `/home/lshdainty/study/CLAUDE.md` 에 있다. Claude Code 가 디렉토리 워크업으로
> 자동 로드하므로 여기에 복사하지 않는다 — 복사본은 원문이 바뀌어도 따라오지 않는다.

## 이 레포는

`porest.cloud` 루트의 그룹 홈페이지. `index.html` 한 파일이 전부이고 빌드가 없다.
디자인은 `porest-design` 을 따르지 않는다 — 제품 화면이 아니라 그룹 소개 페이지라 일부러 다른 인상을 낸다.

## 지킬 것

- 외부 의존은 Google Fonts 뿐. 스크립트·스타일은 파일 안에 둔다 — 서버에서 CDN 이 막혀도 페이지가 선다
- 제품 화면 목업의 숫자는 가짜다. 실제 스크린샷으로 바꿀 때는 운영 화면을 깨끗한 계정으로 찍는다(dev 는 워터마크가 박힌다)
- 링크는 운영 도메인만(`hr.` `desk.` `sso.porest.cloud`, `desk.porest.cloud/guide/`). 관리자 도구(jenkins·grafana·cards)는 싣지 않는다
