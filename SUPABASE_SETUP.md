# Supabase 设置指南

## 1. 创建 Supabase 项目

1. 访问 [Supabase](https://supabase.com) 并注册/登录
2. 点击 "New Project" 创建新项目
3. 选择组织，输入项目名称和数据库密码
4. 等待项目创建完成

## 2. 获取项目配置

1. 在 Supabase 控制台中，进入你的项目
2. 点击左侧菜单的 "Settings" -> "API"
3. 复制以下信息：
   - Project URL (格式: https://xxx.supabase.co)
   - anon public key

## 3. 配置环境变量

在项目根目录创建 `.env.local` 文件，内容如下：

```env
NEXT_PUBLIC_SUPABASE_URL=你的项目URL
NEXT_PUBLIC_SUPABASE_ANON_KEY=你的anon key
```

## 4. 创建数据库表

在 Supabase 控制台中：

1. 进入 "Table Editor"
2. 点击 "New Table"
3. 创建名为 `todos` 的表，包含以下字段：

```sql
id: uuid (主键，默认值: gen_random_uuid())
text: text (非空)
completed: boolean (默认值: false)
created_at: timestamp with time zone (默认值: now())
user_id: uuid (可选，用于用户认证)
```

## 5. 设置行级安全策略 (RLS)

在 SQL Editor 中运行以下命令：

```sql
-- 启用 RLS
ALTER TABLE todos ENABLE ROW LEVEL SECURITY;

-- 创建策略允许所有操作（开发环境）
CREATE POLICY "Allow all operations" ON todos
FOR ALL USING (true);
```

## 6. 运行项目

```bash
pnpm dev
```

现在你的 todo 应用就可以将数据持久化存储到 Supabase 了！
