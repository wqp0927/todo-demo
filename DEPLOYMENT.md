# 部署指南

## 本地开发

### 1. 设置环境变量

在项目根目录创建 `.env.local` 文件：

```env
NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
```

### 2. 运行开发服务器

```bash
pnpm dev
```

访问 [http://localhost:3000](http://localhost:3000)

## Supabase 设置

### 1. 创建项目

1. 访问 [Supabase](https://supabase.com)
2. 注册/登录账户
3. 点击 "New Project"
4. 填写项目信息：
   - 组织：选择你的组织
   - 项目名称：例如 `todo-app`
   - 数据库密码：设置一个强密码
   - 地区：选择离你最近的地区

### 2. 获取配置信息

1. 项目创建完成后，进入项目控制台
2. 点击左侧菜单 "Settings" → "API"
3. 复制以下信息：
   - **Project URL**: `https://xxx.supabase.co`
   - **anon public key**: 以 `eyJ` 开头的长字符串

### 3. 创建数据库表

#### 方法一：使用 SQL Editor（推荐）

1. 在 Supabase 控制台中，点击 "SQL Editor"
2. 点击 "New query"
3. 复制以下 SQL 代码并粘贴：

```sql
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
CREATE POLICY "Allow all operations" ON todos
FOR ALL USING (true);

-- 创建索引以提高查询性能
CREATE INDEX IF NOT EXISTS idx_todos_created_at ON todos(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_todos_completed ON todos(completed);
CREATE INDEX IF NOT EXISTS idx_todos_user_id ON todos(user_id);
```

4. 点击 "Run" 执行

#### 方法二：使用 Table Editor

1. 点击 "Table Editor"
2. 点击 "New Table"
3. 设置表名：`todos`
4. 添加以下列：
   - `id`: UUID, 主键，默认值：`gen_random_uuid()`
   - `text`: TEXT, 非空
   - `completed`: BOOLEAN, 默认值：`false`
   - `created_at`: TIMESTAMPTZ, 默认值：`now()`
   - `user_id`: UUID（可选）

### 4. 设置行级安全策略

在 SQL Editor 中运行：

```sql
-- 启用 RLS
ALTER TABLE todos ENABLE ROW LEVEL SECURITY;

-- 创建策略（开发环境）
CREATE POLICY "Allow all operations" ON todos
FOR ALL USING (true);
```

## 生产环境部署

### Vercel 部署（推荐）

1. **准备代码**
   ```bash
   git add .
   git commit -m "Add Supabase integration"
   git push origin main
   ```

2. **连接 Vercel**
   - 访问 [Vercel](https://vercel.com)
   - 使用 GitHub 登录
   - 点击 "New Project"
   - 选择你的仓库

3. **配置环境变量**
   - 在项目设置中找到 "Environment Variables"
   - 添加以下变量：
     - `NEXT_PUBLIC_SUPABASE_URL`: 你的 Supabase URL
     - `NEXT_PUBLIC_SUPABASE_ANON_KEY`: 你的 Supabase anon key

4. **部署**
   - 点击 "Deploy"
   - 等待部署完成

### 其他平台

#### Netlify

1. 连接 GitHub 仓库
2. 构建命令：`pnpm build`
3. 发布目录：`.next`
4. 在环境变量中添加 Supabase 配置

#### Railway

1. 连接 GitHub 仓库
2. 在环境变量中添加 Supabase 配置
3. 自动部署

## 故障排除

### 常见问题

1. **"supabaseUrl is required" 错误**
   - 检查环境变量是否正确设置
   - 确保变量名拼写正确

2. **"relation 'todos' does not exist" 错误**
   - 确保在 Supabase 中创建了 `todos` 表
   - 检查表名拼写是否正确

3. **"permission denied" 错误**
   - 确保启用了 RLS 并创建了适当的策略
   - 检查 API 密钥是否正确

4. **数据不显示**
   - 检查网络连接
   - 查看浏览器控制台是否有错误
   - 确认 Supabase 项目状态正常

### 调试技巧

1. **查看 Supabase 日志**
   - 在 Supabase 控制台中查看 "Logs"
   - 检查是否有错误信息

2. **浏览器开发者工具**
   - 打开 Network 标签页
   - 查看 Supabase API 请求是否成功

3. **环境变量检查**
   ```bash
   # 在开发环境中检查
   echo $NEXT_PUBLIC_SUPABASE_URL
   ```

## 安全注意事项

1. **API 密钥安全**
   - 永远不要在客户端代码中暴露 `service_role` 密钥
   - 只使用 `anon` 密钥进行客户端操作

2. **行级安全策略**
   - 在生产环境中，创建更严格的 RLS 策略
   - 考虑添加用户认证

3. **环境变量**
   - 确保 `.env.local` 文件已添加到 `.gitignore`
   - 在生产环境中使用平台的环境变量功能

## 下一步

- 添加用户认证功能
- 实现实时数据同步
- 添加数据备份功能
- 优化性能和用户体验
