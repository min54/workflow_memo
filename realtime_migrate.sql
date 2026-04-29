-- ─────────────────────────────────────────────────────────────
-- Realtime 기반 실시간 동기화를 위한 마이그레이션
-- Supabase 대시보드 → SQL Editor 에서 실행 (1회)
-- ─────────────────────────────────────────────────────────────

-- 1) client_id 컬럼 추가 (어떤 클라이언트가 변경했는지 식별 → 자기 변경 에코 무시용)
ALTER TABLE folders   ADD COLUMN IF NOT EXISTS client_id TEXT;
ALTER TABLE projects  ADD COLUMN IF NOT EXISTS client_id TEXT;
ALTER TABLE canvases  ADD COLUMN IF NOT EXISTS client_id TEXT;

-- 2) Realtime publication에 테이블 추가
--    (Supabase 대시보드 → Database → Replication 에서도 토글 가능. SQL로도 가능)
DO $$ BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_publication_tables
    WHERE pubname = 'supabase_realtime' AND tablename = 'folders'
  ) THEN
    ALTER PUBLICATION supabase_realtime ADD TABLE folders;
  END IF;
END $$;

DO $$ BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_publication_tables
    WHERE pubname = 'supabase_realtime' AND tablename = 'projects'
  ) THEN
    ALTER PUBLICATION supabase_realtime ADD TABLE projects;
  END IF;
END $$;

DO $$ BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_publication_tables
    WHERE pubname = 'supabase_realtime' AND tablename = 'canvases'
  ) THEN
    ALTER PUBLICATION supabase_realtime ADD TABLE canvases;
  END IF;
END $$;

-- 3) DELETE 이벤트의 OLD row 전체를 받기 위해 REPLICA IDENTITY FULL 설정
--    (기본값은 PRIMARY KEY만 보내서 owner/shared_with 등을 볼 수 없음)
ALTER TABLE folders  REPLICA IDENTITY FULL;
ALTER TABLE projects REPLICA IDENTITY FULL;
ALTER TABLE canvases REPLICA IDENTITY FULL;
