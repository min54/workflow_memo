# Workflow Canvas 개발 현황

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
- [x] 로그인 화면 (아이디/패스워드 1/1)
- [x] sessionStorage 기반 세션 유지 (탭 닫으면 재로그인)

### 사이드바 / 프로젝트 관리
- [x] 다중 프로젝트 (생성 / 이름 변경 / 삭제)
- [x] 폴더 기능 (1단계, 생성 / 이름 변경 / 삭제)
- [x] 프로젝트 → 폴더 이동: 드래그 앤 드롭 + 우클릭 컨텍스트 메뉴
- [x] 폴더 순서 드래그로 변경 (sort_order DB 저장)
- [x] 폴더 기본 상태: 닫힘 (collapsed)
- [x] 폴더 그룹은 사이드바 하단에 표시
- [x] 사이드바 텍스트 선택 방지

### 캔버스
- [x] 무한 캔버스 (휠 줌)
- [x] 패닝: Space + 드래그 (텍스트 드래그 선택과 분리)
- [x] 프로젝트 이름 워터마크 (좌상단, 투명도 30%)
- [x] 새 프로젝트 초기 텍스트 블록 위치 (워터마크 아래)

### 텍스트 블록
- [x] 더블클릭 → 텍스트 블록 생성
- [x] 빈 블록 자동 삭제 (포커스 해제 시)
- [x] 슬래시 커맨드 (`/섹션`, `/제목`, `/설명`)
- [x] 블록 이동 핸들

### 파일 / 이미지
- [x] 이미지 업로드 (Supabase Storage)
- [x] PDF / Excel / Word / PPT / TXT 업로드
- [x] 하단 스트립 카드 (파일 열기 / 다운로드)
- [x] 파일명 직접 입력 모달

### 선택 / 편집
- [x] 그룹 선택 (S 툴 + 러버밴드)
- [x] 선택 블록 이동 / 삭제
- [x] Ctrl+C / Ctrl+V 복사·붙여넣기 (프로젝트 간 가능)
- [x] Ctrl+Z Undo (최대 20단계)

### 검색 / 내보내기
- [x] 전체 프로젝트 검색 (Ctrl+F)
- [x] ZIP 다운로드 (레이아웃 보존 HTML + 파일)
- [x] 도움말 모달 (`?` 아이콘)

---

## 앞으로 할 것

### 단기 (UI/UX 개선)
- [ ] 로그인 보안 강화 (Supabase Auth 이메일/패스워드)
- [ ] 폴더 드래그 순서 변경 버그 확인 및 개선
- [ ] 모바일 기본 지원 (터치 패닝/줌)

### 중기 (기능 확장)
- [ ] 블록 간 연결선 (화살표)
- [ ] 프로젝트별 친구 공유 (이메일 초대, editor/viewer 권한)
- [ ] 공유 중인 프로젝트 뱃지 표시
- [ ] Undo 범위 확장 (이미지·파일 블록까지)

### 장기 (협업)
- [ ] 실시간 공동 편집 (Supabase Realtime)
- [ ] 실시간 커서 표시
- [ ] Google OAuth 로그인
