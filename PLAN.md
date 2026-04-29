# Brain Map 개발 현황

## 배포 정보
- **URL**: https://workflow-memo-canvas.netlify.app/memo.html
- **GitHub**: https://github.com/min54/workflow_memo
- **Supabase 프로젝트**: workflow_memo (Northeast Asia, Tokyo)
- **배포 방식**: GitHub push → Netlify 자동 배포

---

## ⚠️ 현재 보안 상태 (반드시 개선 필요)

> 지금 구조는 **개인 테스트용** 수준. 외부 공개 또는 친구 초대 전에 아래 항목 해결 필수.

| 항목 | 현재 상태 | 위험도 |
|------|-----------|--------|
| 아이디/패스워드 | 코드에 하드코딩 (`11/11`, `bae/bae`, `yim/yim`) | 🔴 높음 |
| Supabase API Key | 클라이언트 JS에 노출 | 🟡 중간 (anon key라 제한적) |
| Row Level Security | owner 문자열 비교만 — 진짜 인증 없음 | 🔴 높음 |
| 데이터 접근 제어 | 누구나 브라우저 콘솔로 타인 데이터 조회 가능 | 🔴 높음 |
| 파일 업로드 제한 | 파일 크기/타입 서버 검증 없음 | 🟡 중간 |
| HTTPS | Netlify 기본 제공 ✓ | 🟢 양호 |

---

## 완료된 기능

### 인프라
- [x] Supabase 연동 (projects, canvases, folders 테이블)
- [x] Netlify 배포 (GitHub 자동 연동)
- [x] localStorage → Supabase 마이그레이션 코드
- [x] Supabase Storage 파일/이미지 업로드

### 인증 (현재 — 임시 구조)
- [x] 로그인 화면 (하드코딩 아이디/패스워드 — 오너: `11/11`, 게스트: `bae/bae`, `yim/yim`)
- [x] `OWNER_MAP`: 로그인 ID → DB owner ID 매핑 (`11` → `min`)
- [x] sessionStorage 기반 세션 유지 (탭 닫으면 재로그인)
- [x] 유저별 데이터 분리 (owner TEXT 컬럼으로 필터링)

### 로그인 화면 (브랜딩)
- [x] 앱 이름 Brain Map으로 변경
- [x] 뇌 형태 흑백 SVG 로고
- [x] 철학적 영문 배경 텍스트
- [x] Three.js WebGL 파티클 배경 (1500개, 신경망 연결선)
- [x] 마우스 패럴랙스 + 배경 텍스트 유영/도망 인터랙션
- [x] 로그인 박스 유리 효과, 페이드인 애니메이션
- [x] 리소스 최적화 (low-power WebGL, 로그인 후 루프 완전 종료)

### 사이드바 / 프로젝트 관리
- [x] 다중 프로젝트 (생성 / 이름 변경 / 삭제)
- [x] 폴더 기능 (1단계, 생성 / 이름 변경 / 삭제)
- [x] 프로젝트 → 폴더 이동: 드래그 앤 드롭 + 우클릭 컨텍스트 메뉴
- [x] 폴더 순서 드래그로 변경 (sort_order DB 저장)
- [x] Supabase Storage 사용량 표시

### 캔버스
- [x] 무한 캔버스 (휠 줌), Space + 드래그 패닝
- [x] 프로젝트 이름 워터마크
- [x] 바탕화면에서 파일 드래그 앤 드롭 업로드

### 텍스트 블록
- [x] 더블클릭 → 텍스트 블록 생성, 빈 블록 자동 삭제
- [x] 슬래시 커맨드 (`/섹션`, `/제목`, `/설명`)
- [x] 블록 이동 핸들, 형광펜

### 파일 / 이미지
- [x] 이미지 / PDF / Excel / Word / PPT / TXT 업로드
- [x] 하단 스트립 카드 (파일 열기 / 다운로드)
- [x] 파일명 직접 입력 모달, 파일명 검색

### 선택 / 편집
- [x] 그룹 선택 (러버밴드), 이동 / 삭제
- [x] Ctrl+C / Ctrl+V (프로젝트 간 가능)
- [x] Ctrl+Z Undo (최대 20단계)

### Brain Map (텍스트 전체보기)
- [x] 전체 프로젝트 텍스트 카드 무한 캔버스 뷰
- [x] Space + 드래그 패닝, 휠 줌, 카드 클릭 → 프로젝트 이동
- [x] Brain Map 내 검색

### 검색 / 내보내기
- [x] 전체 프로젝트 검색 (Ctrl+F)
- [x] ZIP 다운로드 (레이아웃 보존 HTML + 파일)
- [x] 도움말 모달, 달력 위젯

---

## 🔍 확인 노트 (2026-04-29)

### 휠 줌 시 텍스트 블록 크기 비율 — **버그 아님 (의도된 동작)**
- **현상**: 휠로 확대했을 때 하단 블록의 두 줄(파란색)이 서로 다른 크기로 보여 색상별 버그 의심
- **원인**: 두 줄이 같은 블록의 **제목(titleEl)** 과 **내용(contentEl)** 영역이라 기본 폰트 크기가 다름
  - `titleEl`: 32px × scale
  - `contentEl`: 25px × scale
  - 비율: 32 : 25 = **1.28 : 1** (항상 일정)
- **관련 코드**: `memo.html:3362-3364`
  ```js
  b.titleEl.style.fontSize   = Math.max(1, 32 * scale) + 'px';
  b.contentEl.style.fontSize = Math.max(1, 25 * scale) + 'px';
  ```
- **결론**: 확대/축소 모두 동일한 `scale` 변수를 곱하므로 비율은 깨지지 않음. 색상은 `style.color`만 변경하며 크기에 영향 없음.
- **유일한 예외**: scale ≈ 0.04 극단 줌아웃에서 `Math.max(1, …)` 클램프로 둘 다 1px로 붙음 — 일반 사용 범위에선 무관
- **조치**: 코드 변경 없음 → **배포 불필요**

---

## 🆕 최근 수정 (2026-04-28)

### UX 개선
- [x] **달력 위젯 접이식 토글** — 우상단 달력이 캔버스 가리는 문제 해결
  - 헤더에 −/+ 버튼 추가, 접힘 상태에서는 그리드/이전·다음 화살표 숨김
  - 접힌 상태 표시 형식: `M월 D일(요일)` (예: `4월 28일(화)`)
  - `localStorage('calCollapsed')`로 새로고침 후에도 상태 유지
- [x] **LifeMap 버튼 정렬 보정** — 다른 사이드바 버튼과 일관되게 `justify-content: center` 추가
- [x] **링크 "열기" 버튼 위치 개선** — 우측 X 삭제 버튼과 겹치는 문제 해결
  - 링크 우측(rect.right + 30px) → 링크 위쪽(rect.left, top - btnH - 6px)으로 이동
  - 닫힘 지연 180ms → 350ms, 버튼 아래 8px 투명 hit-area로 갭 메움 → 클릭하려다 사라지는 현상 해소
- [x] **캔버스 좌상단 프로젝트 타이틀 위치 조정** — 월드 좌표 (30, 30) → (200, 50)

---

## 🆕 최근 수정 (2026-04-24)

### UX 개선
- [x] **사이드바 토글** — 좌측 슬라이드 숨김/표시 (Claude 스타일 패널 아이콘)
  - 사이드바 헤더 우측 아이콘 → 닫기 / 좌측 상단 floating 버튼 → 열기
  - `sessionStorage`로 상태 유지 (탭 유지 동안)

### 버그 수정
- [x] **크로스 오리진 다운로드** — Supabase Storage URL의 `<a download>` 무시 문제
  - `fetch` → `Blob` → `blob:` URL 방식으로 우회 (`downloadFromUrl()` 헬퍼)
  - 적용: 이미지 모달 / 하단 스트립 카드 / 파일 블록 클릭
- [x] **줌 시 `/섹션` `/제목` 스팬 미동작** — 옛날 저장 데이터의 `font-size: Npx` 하드코딩
  - 로드 시 `migratePxFontSizes()` 1회 실행, px → em 자동 변환
  - 1.364em / 1.8em 근처는 정확한 값으로 스냅 → 다음 저장부터 영구 교정
- [x] **포인터/그룹선택 전환 시 사이드바가 열림** — `setTool`이 `body.className`을 덮어써서 `sidebar-hidden` 유실
  - `classList.remove/add`로 교체해 다른 상태 클래스 보존
- [x] **Undo 스냅샷 타이밍 오류** — 이전엔 `focusout` 이후(이미 변경된 상태)에 스냅샷을 찍어 `Ctrl+A+Delete` 후 복원 불가
  - `focusin` 시점(편집 이전 상태)에 1회 스냅샷 저장 (세션 중복 방지 플래그 `_editSessionActive`)
  - 블록 생성(더블클릭) / 단일·그룹 드래그 이동 시작 전에도 스냅샷 추가
  - 결과: 실수로 글 지우거나 블록 이동해도 Ctrl+Z로 이전 상태 복원 가능

### 계정 정리
- [x] 하드코딩 `2/2` 삭제
- [x] `admin/1` → `11/11`로 변경 (타이핑 편의, `OWNER_MAP` 매핑 유지로 기존 `min` 데이터 접근 보존)

---

## 앞으로 할 것

---

### 🔐 1순위 — 보안 & 인증 (외부 공개 전 필수)

#### 1-1. Supabase Auth 도입
- [ ] Supabase Auth 이메일/패스워드 로그인으로 교체
  - 현재 하드코딩 방식 완전 제거
  - `supabase.auth.signInWithPassword()` 사용
  - `supabase.auth.signOut()` 로그아웃
  - `supabase.auth.getSession()` 으로 세션 복원
- [ ] 회원가입 기능 (또는 관리자가 초대 링크 발송)
- [ ] 비밀번호 재설정 이메일

#### 1-2. Row Level Security (RLS) 강화
- [ ] 현재: `owner TEXT = '1'` 단순 문자열 비교 → 클라이언트가 owner 위조 가능
- [ ] 목표: `auth.uid()` 기반 RLS 정책으로 서버에서 완전 차단
  ```sql
  -- 예시: 본인 데이터만 접근 가능
  CREATE POLICY "own_data" ON projects
    FOR ALL USING (auth.uid()::text = owner);
  ```
- [ ] projects, folders, canvases 테이블 모두 적용
- [ ] Storage 버킷도 RLS 적용 (현재 public)

#### 1-3. 권한 관리 (공유 기능 전제)
- [ ] `project_members` 테이블 설계
  ```sql
  project_members (
    project_id TEXT,
    user_id    UUID,  -- Supabase auth.uid()
    role       TEXT   -- 'owner' | 'editor' | 'viewer'
  )
  ```
- [ ] viewer: 읽기만, editor: 편집 가능, owner: 삭제/공유 가능
- [ ] RLS에 멤버 테이블 연동
  ```sql
  USING (
    auth.uid()::text = owner OR
    EXISTS (SELECT 1 FROM project_members
            WHERE project_id = projects.id
            AND user_id = auth.uid())
  )
  ```

---

### 👥 2순위 — 친구 공유 & 멀티유저

- [ ] 이메일로 프로젝트 초대 (Supabase Auth 유저 대상)
- [ ] 초대 수락 → project_members에 자동 추가
- [ ] 사이드바에서 공유된 프로젝트 구분 뱃지 표시
- [ ] 공유 프로젝트 권한별 UI 제한 (viewer는 편집 버튼 숨김)
- [ ] 공유 링크 생성 (viewer 전용, 만료 시간 설정)

---

### 🎵 3순위 — 음악 플레이어 (재도전)

- [ ] YouTube iframe 방식 한계 확인됨 (계정 세션 충돌)
- [ ] 대안 검토:
  - **SoundCloud embed** — 계정 제한 없음, 로그인 불필요
  - **로컬 음악 파일 업로드** — Supabase Storage에 mp3 저장 후 `<audio>` 태그 재생
  - **Web Audio API** — 외부 음원 URL 직접 스트리밍
- [ ] 이퀄라이저 CSS 애니메이션은 완성 — 재생 연동만 필요

---

### 🛠 4순위 — 기능 확장

- [ ] 블록 간 연결선 (화살표, 마인드맵 스타일)
- [ ] 텍스트 블록 서식 강화 (볼드, 이탤릭, 링크)
- [ ] Undo 범위 확장 (이미지·파일 블록까지)
- [ ] 모바일 기본 지원 (터치 패닝/줌)
- [ ] Brain Map 카드 썸네일 미리보기
- [ ] 폴더 드래그 순서 변경 버그 개선

---

### 💾 5순위 — 파일 품질 & 인프라

#### 이미지 품질 개선
- [ ] 썸네일 + 원본 분리 저장
  - 캔버스 표시 → 썸네일 (최대 800px, JPEG 82%)
  - 클릭/다운로드 → 원본 URL
  - `thumb_*` / `orig_*` 분리 경로 (Google Drive 방식)

#### 저장소 확장
- [ ] Cloudflare R2 전환
  - 현재: Supabase Storage 1GB 무료
  - R2: 10GB 무료, egress 무제한
  - Supabase DB 유지, 파일만 R2로 교체
  - Supabase Auth 도입 후 함께 작업 권장

---

### 🚀 장기 — 협업

- [ ] 실시간 공동 편집 (Supabase Realtime)
- [ ] 실시간 커서 표시
- [ ] Google / Kakao OAuth 로그인
