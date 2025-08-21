-- 创建 todos 表
CREATE TABLE IF NOT EXISTS todos (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  text TEXT NOT NULL,
  completed BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  user_id UUID -- 可选，用于用户认证
);

-- 启用行级安全策略 (RLS)
ALTER TABLE todos ENABLE ROW LEVEL SECURITY;

-- 创建策略允许所有操作（开发环境）
-- 注意：在生产环境中，你应该创建更严格的策略
CREATE POLICY "Allow all operations" ON todos
FOR ALL USING (true);

-- 创建索引以提高查询性能
CREATE INDEX IF NOT EXISTS idx_todos_created_at ON todos(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_todos_completed ON todos(completed);
CREATE INDEX IF NOT EXISTS idx_todos_user_id ON todos(user_id);

-- 插入一些示例数据（可选）
INSERT INTO todos (text, completed) VALUES 
  ('学习 Supabase', false),
  ('完成项目部署', false),
  ('阅读文档', true)
ON CONFLICT DO NOTHING;
