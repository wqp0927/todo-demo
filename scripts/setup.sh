#!/bin/bash

echo "🚀 Todo App - Supabase 设置脚本"
echo "=================================="

# 检查是否已安装依赖
if [ ! -d "node_modules" ]; then
    echo "📦 安装依赖..."
    pnpm install
else
    echo "✅ 依赖已安装"
fi

# 检查环境变量文件
if [ ! -f ".env.local" ]; then
    echo "📝 创建环境变量文件..."
    cat > .env.local << EOF
# Supabase配置
# 请将以下值替换为你的Supabase项目配置
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url_here
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key_here
EOF
    echo "✅ 已创建 .env.local 文件"
    echo "⚠️  请编辑 .env.local 文件，填入你的 Supabase 配置"
else
    echo "✅ 环境变量文件已存在"
fi

echo ""
echo "📋 下一步操作："
echo "1. 访问 https://supabase.com 创建项目"
echo "2. 在 Supabase 控制台中创建 'todos' 表"
echo "3. 复制项目 URL 和 anon key 到 .env.local 文件"
echo "4. 运行 'pnpm dev' 启动开发服务器"
echo ""
echo "📖 详细说明请查看 DEPLOYMENT.md 文件"
