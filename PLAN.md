# Brain Map 개발 현황

## 배포 정보
- **URL**: https://workflow-memo-canvas.netlify.app/memo.html
- **GitHub**: https://github.com/min54/workflow_memo
- **Supabase 프로젝트**: workflow_memo (Northeast Asia, Tokyo)
- **배포 방식**: GitHub push → Netlify 자동 배포

---

## 완료된 기능

### 인프라
- [x] Supabase 연동 (projects, canvases, folders 테이블)
- [x] Netlify 배포 (GitHub 자동 연동)
- [x] localStorage → Supabase 마이그레이션 코드
- [x] Supabase Storage 파일/이미지 업로드

### 인증
- [x] 로그인 화면 (아이디/패스워드 1/1, 2/2 멀티유저)
- [x] sessionStorage 기반 세션 유지 (탭 닫으면 재로그인)
- [x] 유저별 데이터 분리 (owner 컬럼, DB 필터링)

### 로그인 화면 (브랜딩)
- [x] 앱 이름 Brain Map으로 변경
- [x] 뇌 형태 흑백 SVG 로고
- [x] 철학적 영문 배경 텍스트 (Clarity begins when the mind finds its structure.)
- [x] Three.js WebGL 파티클 배경 (1500개, 신경망 연결선)
- [x] 마우스 패럴랙스 (파티클 구 기울기)
- [x] 배경 텍스트 자유 유영 + 마우스 도망 인터랙션
- [x] 로그인 박스 유리 효과 (backdrop-filter blur)
- [x] 로그인 페이드인 애니메이션
- [x] 리소스 최적화 (low-power WebGL, 로그인 후 루프 완전 종료)

### 사이드바 / 프로젝트 관리
- [x] 다중 프로젝트 (생성 / 이름 변경 / 삭제)
- [x] 폴더 기능 (1단계, 생성 / 이름 변경 / 삭제)
- [x] 프로젝트 → 폴더 이동: 드래그 앤 드롭 + 우클릭 컨텍스트 메뉴
- [x] 폴더 순서 드래그로 변경 (sort_order DB 저장)
- [x] 폴더 기본 상태: 닫힘 (collapsed)
- [x] 폴더 그룹은 사이드바 하단에 표시
- [x] 사이드바 텍스트 선택 방지
- [x] Supabase Storage 사용량 표시

### 캔버스
- [x] 무한 캔버스 (휠 줌)
- [x] 패닝: Space + 드래그
- [x] 프로젝트 이름 워터마크 (좌상단, 투명도 30%)
- [x] 바탕화면에서 파일 드래그 앤 드롭으로 캔버스에 바로 업로드

### 텍스트 블록
- [x] 더블클릭 → 텍스트 블록 생성
- [x] 빈 블록 자동 삭제 (포커스 해제 시)
- [x] 슬래시 커맨드 (`/섹션`, `/제목`, `/설명`)
- [x] 블록 이동 핸들
- [x] 형광펜 색상 (투명도 조정)

### 파일 / 이미지
- [x] 이미지 업로드 (Supabase Storage)
- [x] PDF / Excel / Word / PPT / TXT 업로드
- [x] 하단 스트립 카드 (파일 열기 / 다운로드, 높이 균일)
- [x] 파일명 직접 입력 모달
- [x] 파일명 검색 지원

### 선택 / 편집
- [x] 그룹 선택 (S 툴 + 러버밴드)
- [x] 선택 블록 이동 / 삭제
- [x] Ctrl+C / Ctrl+V 복사·붙여넣기 (프로젝트 간 가능)
- [x] Ctrl+Z Undo (최대 20단계)

### Brain Map (텍스트 전체보기)
- [x] 전체 프로젝트 텍스트를 카드로 모아보는 무한 캔버스 뷰
- [x] Space + 드래그 패닝 (흔들림 없음)
- [x] 휠 줌인/줌아웃
- [x] 카드 클릭 → 해당 프로젝트로 이동
- [x] Brain Map 내 검색 기능

### 검색 / 내보내기
- [x] 전체 프로젝트 검색 (Ctrl+F, 중복 결과 버그 수정)
- [x] ZIP 다운로드 (레이아웃 보존 HTML + 파일)
- [x] 도움말 모달 (`?` 아이콘)

### 위젯
- [x] 달력 위젯 (우측 툴바, 한글 표기)

---

## 앞으로 할 것

### 단기 (UI/UX 개선)
- [ ] 로그인 보안 강화 (Supabase Auth 이메일/패스워드)
- [ ] 모바일 기본 지원 (터치 패닝/줌)
- [ ] 폴더 드래그 순서 변경 버그 확인 및 개선
- [ ] Brain Map 카드 디자인 개선 (미리보기 썸네일 포함)

### 음악 플레이어 (재도전)
- [ ] 유튜브 iframe 방식 대신 다른 방법 검토
  - Web Audio API + 외부 음원 URL 직접 재생
  - SoundCloud embed (계정 제한 없음)
  - 로컬 음악 파일 업로드 후 재생 (Supabase Storage 활용)
- [ ] 이퀄라이저 애니메이션은 완성되어 있음 (CSS only) — 재생 연동만 필요

### 중기 (기능 확장)
- [ ] 블록 간 연결선 (화살표, 마인드맵 스타일)
- [ ] 프로젝트별 친구 공유 (이메일 초대, editor/viewer 권한)
- [ ] 공유 중인 프로젝트 뱃지 표시
- [ ] Undo 범위 확장 (이미지·파일 블록까지)
- [ ] 텍스트 블록 서식 강화 (볼드, 이탤릭, 링크)

### 장기 (협업)
- [ ] 실시간 공동 편집 (Supabase Realtime)
- [ ] 실시간 커서 표시
- [ ] Google OAuth 로그인

### 파일 품질 개선 (다음 버전)
- [ ] 이미지 업로드 시 썸네일 + 원본 분리 저장
  - 캔버스/하단 스트립 표시 → 썸네일 (최대 800px, JPEG 82%) — 빠른 로딩
  - 클릭(모달) / 다운로드 → 원본 URL — 풀 화질
  - 현재는 압축본만 저장하며 원본 유실됨
  - Google Drive와 동일한 방식 (`thumb_*`, `orig_*` 분리 경로)
  - Cloudflare R2 전환 시 같이 작업 권장

### 인프라 (용량 확장)
- [ ] 파일 저장소 Cloudflare R2 전환
  - 현재: Supabase Storage 1GB 무료
  - 목표: R2 10GB 무료, egress 무제한
  - Supabase DB는 유지, 파일/이미지만 R2로 교체
  - 구글 드라이브급 대용량 파일 저장 목표
