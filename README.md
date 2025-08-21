# Todo 应用 - Supabase 集成版

一个现代化的待办事项管理应用，使用 Next.js、React 和 Supabase 构建。

## 功能特性

- ✨ 现代化的 UI 设计，支持深色/浅色主题
- 📱 响应式设计，适配各种设备
- 🔄 实时数据同步
- 💾 数据持久化存储
- ⚡ 快速加载和流畅交互
- 🎨 美观的渐变和动画效果

## 技术栈

- **前端**: Next.js 15, React 19, TypeScript
- **UI 组件**: Radix UI, Tailwind CSS
- **数据库**: Supabase (PostgreSQL)
- **状态管理**: React Hooks
- **包管理**: pnpm

## 快速开始

### 1. 克隆项目

```bash
git clone <your-repo-url>
cd todo-demo
```

### 2. 安装依赖

```bash
pnpm install
```

### 3. 设置 Supabase

#### 3.1 创建 Supabase 项目

1. 访问 [Supabase](https://supabase.com) 并注册/登录
2. 点击 "New Project" 创建新项目
3. 选择组织，输入项目名称和数据库密码
4. 等待项目创建完成

#### 3.2 获取项目配置

1. 在 Supabase 控制台中，进入你的项目
2. 点击左侧菜单的 "Settings" -> "API"
3. 复制以下信息：
   - Project URL (格式: https://xxx.supabase.co)
   - anon public key

#### 3.3 配置环境变量

在项目根目录创建 `.env.local` 文件：

```env
NEXT_PUBLIC_SUPABASE_URL=你的项目URL
NEXT_PUBLIC_SUPABASE_ANON_KEY=你的anon key
```

#### 3.4 设置数据库

在 Supabase 控制台中：

1. 进入 "SQL Editor"
2. 复制 `supabase-setup.sql` 文件中的内容
3. 粘贴到 SQL Editor 中并执行

或者手动创建表：

1. 进入 "Table Editor"
2. 点击 "New Table"
3. 创建名为 `todos` 的表，包含以下字段：
   - `id`: uuid (主键，默认值: gen_random_uuid())
   - `text`: text (非空)
   - `completed`: boolean (默认值: false)
   - `created_at`: timestamp with time zone (默认值: now())
   - `user_id`: uuid (可选)

### 4. 运行项目

```bash
pnpm dev
```

访问 [http://localhost:3000](http://localhost:3000) 查看应用。

## 项目结构

```
todo-demo/
├── app/                    # Next.js App Router
│   ├── globals.css        # 全局样式
│   ├── layout.tsx         # 根布局
│   └── page.tsx           # 主页面
├── components/            # React 组件
│   ├── ui/               # UI 组件库
│   ├── theme-provider.tsx # 主题提供者
│   └── theme-toggle.tsx   # 主题切换
├── lib/                  # 工具库
│   ├── hooks/            # 自定义 Hooks
│   │   └── useTodos.ts   # Todo 数据管理 Hook
│   ├── supabase.ts       # Supabase 客户端
│   └── utils.ts          # 工具函数
├── public/               # 静态资源
└── styles/               # 样式文件
```

## 部署

### Vercel 部署

1. 将代码推送到 GitHub
2. 在 [Vercel](https://vercel.com) 中导入项目
3. 在项目设置中添加环境变量：
   - `NEXT_PUBLIC_SUPABASE_URL`
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY`
4. 部署完成

### 其他平台

项目可以部署到任何支持 Next.js 的平台，如：
- Netlify
- Railway
- DigitalOcean App Platform
- AWS Amplify

## 开发

### 添加新功能

1. 在 `lib/hooks/useTodos.ts` 中添加新的数据操作方法
2. 在 `app/page.tsx` 中集成新功能
3. 根据需要添加新的 UI 组件

### 样式定制

项目使用 Tailwind CSS，你可以：
- 修改 `tailwind.config.ts` 来自定义主题
- 在 `app/globals.css` 中添加全局样式
- 使用 CSS 变量来自定义颜色和间距

## 贡献

欢迎提交 Issue 和 Pull Request！

## 许可证

MIT License
