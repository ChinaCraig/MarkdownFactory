#!/bin/bash

# Markdown Factory 安装脚本
# 适用于 Linux/macOS 系统

set -e  # 遇到错误时退出

echo "🚀 开始安装 Markdown Factory..."
echo "=================================="

# 检查Python版本
echo "📋 检查Python版本..."
if ! command -v python3 &> /dev/null; then
    echo "❌ 错误: 未找到Python3，请先安装Python 3.8+"
    exit 1
fi

PYTHON_VERSION=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')
echo "✅ Python版本: $PYTHON_VERSION"

# 检查pip
echo "📋 检查pip..."
if ! command -v pip3 &> /dev/null; then
    echo "❌ 错误: 未找到pip3，请先安装pip"
    exit 1
fi
echo "✅ pip已安装"

# 创建虚拟环境
echo "📦 创建虚拟环境..."
if [ ! -d ".venv" ]; then
    python3 -m venv .venv
    echo "✅ 虚拟环境创建成功"
else
    echo "✅ 虚拟环境已存在"
fi

# 激活虚拟环境
echo "🔧 激活虚拟环境..."
source .venv/bin/activate

# 升级pip
echo "⬆️  升级pip..."
pip install --upgrade pip

# 安装依赖
echo "📦 安装Python依赖..."
pip install -r requirements.txt
echo "✅ 依赖安装完成"

# 检查MySQL连接
echo "🗄️  检查数据库连接..."
python3 -c "
import pymysql
try:
    conn = pymysql.connect(
        host='192.168.16.105',
        port=3306,
        user='root',
        password='19900114xin',
        charset='utf8mb4'
    )
    conn.close()
    print('✅ 数据库连接成功')
except Exception as e:
    print(f'❌ 数据库连接失败: {e}')
    print('请检查数据库配置和网络连接')
    exit(1)
"

# 设置权限
echo "🔐 设置文件权限..."
chmod +x run.py
chmod +x install.sh
chmod +x init_database.py

echo "=================================="
echo "🎉 安装完成！"
echo ""
echo "📝 下一步操作:"
echo "1. 初始化数据库: python3 init_database.py"
echo "2. 启动应用: python3 run.py"
echo "3. 访问: http://localhost:8888"
echo ""
echo "💡 提示:"
echo "- 如果数据库不存在，请先创建: CREATE DATABASE markdown_factory;"
echo "- 也可以直接执行SQL文件: mysql -h 192.168.16.105 -u root -p < database_setup.sql"
echo ""
echo "📚 更多信息请查看 README.md"
echo "==================================" 