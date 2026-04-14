-- workflow_memo 테이블 생성
-- Supabase 대시보드 → SQL Editor에서 실행

-- ── folders 테이블 (신규) ──────────────────────────────────────
CREATE TABLE IF NOT EXISTS folders (
  id          TEXT PRIMARY KEY,
  name        TEXT NOT NULL,
  collapsed   BOOLEAN DEFAULT false,
  created_at  TIMESTAMPTZ DEFAULT NOW()
);

-- ── projects 테이블 ────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS projects (
  id          TEXT PRIMARY KEY,
  name        TEXT NOT NULL,
  folder_id   TEXT REFERENCES folders(id) ON DELETE SET NULL,
  created_at  TIMESTAMPTZ DEFAULT NOW()
);

-- 기존 projects 테이블에 folder_id 추가 (이미 테이블이 있는 경우)
ALTER TABLE projects ADD COLUMN IF NOT EXISTS folder_id TEXT REFERENCES folders(id) ON DELETE SET NULL;

CREATE TABLE IF NOT EXISTS canvases (
  project_id  TEXT PRIMARY KEY REFERENCES projects(id) ON DELETE CASCADE,
  data        JSONB NOT NULL DEFAULT '{}',
  updated_at  TIMESTAMPTZ DEFAULT NOW()
);

-- RLS 활성화 (Row Level Security)
ALTER TABLE folders  ENABLE ROW LEVEL SECURITY;
ALTER TABLE projects ENABLE ROW LEVEL SECURITY;
ALTER TABLE canvases ENABLE ROW LEVEL SECURITY;

-- 모든 사용자 접근 허용 (인증 없이 사용)
CREATE POLICY "public_all" ON folders  FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "public_all" ON projects FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "public_all" ON canvases FOR ALL USING (true) WITH CHECK (true);
