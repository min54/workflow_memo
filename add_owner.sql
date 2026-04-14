-- owner 컬럼 추가 (기존 데이터는 '1'로 설정)
ALTER TABLE projects ADD COLUMN IF NOT EXISTS owner TEXT DEFAULT '1';
ALTER TABLE folders  ADD COLUMN IF NOT EXISTS owner TEXT DEFAULT '1';

UPDATE projects SET owner = '1' WHERE owner IS NULL;
UPDATE folders  SET owner = '1' WHERE owner IS NULL;
