@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

echo 🚀 开始安装 Markdown Factory...
echo ==================================

REM 检查Python
echo 📋 检查Python版本...
python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ 错误: 未找到Python，请先安装Python 3.8+
    pause
    exit /b 1
)

for /f "tokens=2" %%i in ('python --version 2^>^&1') do set PYTHON_VERSION=%%i
echo ✅ Python版本: %PYTHON_VERSION%

REM 检查pip
echo 📋 检查pip...
pip --version >nul 2>&1
if errorlevel 1 (
    echo ❌ 错误: 未找到pip，请先安装pip
    pause
    exit /b 1
)
echo ✅ pip已安装

REM 创建虚拟环境
echo 📦 创建虚拟环境...
if not exist ".venv" (
    python -m venv .venv
    echo ✅ 虚拟环境创建成功
) else (
    echo ✅ 虚拟环境已存在
)

REM 激活虚拟环境
echo 🔧 激活虚拟环境...
call .venv\Scripts\activate.bat

REM 升级pip
echo ⬆️  升级pip...
python -m pip install --upgrade pip

REM 安装依赖
echo 📦 安装Python依赖...
pip install -r requirements.txt
if errorlevel 1 (
    echo ❌ 依赖安装失败
    pause
    exit /b 1
)
echo ✅ 依赖安装完成

REM 检查数据库连接
echo 🗄️  检查数据库连接...
python -c "import pymysql; conn = pymysql.connect(host='192.168.16.105', port=3306, user='root', password='19900114xin', charset='utf8mb4'); conn.close(); print('✅ 数据库连接成功')" 2>nul
if errorlevel 1 (
    echo ❌ 数据库连接失败，请检查数据库配置和网络连接
    pause
    exit /b 1
)

echo ==================================
echo 🎉 安装完成！
echo.
echo 📝 下一步操作:
echo 1. 初始化数据库: python init_database.py
echo 2. 启动应用: python run.py
echo 3. 访问: http://localhost:8888
echo.
echo 💡 提示:
echo - 如果数据库不存在，请先创建: CREATE DATABASE markdown_factory;
echo - 也可以直接执行SQL文件: mysql -h 192.168.16.105 -u root -p ^< database_setup.sql
echo.
echo 📚 更多信息请查看 README.md
echo ==================================
echo.
echo 按任意键继续...
pause >nul 