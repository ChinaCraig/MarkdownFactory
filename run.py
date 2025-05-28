#!/usr/bin/env python3
"""
Markdown Factory 启动脚本
"""

import os
import sys
from app import app, db

def check_dependencies():
    """检查依赖是否安装"""
    try:
        import flask
        import flask_sqlalchemy
        import pymysql
        import markdown
        print("✅ 所有依赖已安装")
        return True
    except ImportError as e:
        print(f"❌ 缺少依赖: {e}")
        print("请运行: pip install -r requirements.txt")
        return False

def check_database():
    """检查数据库连接"""
    try:
        with app.app_context():
            db.create_all()
        print("✅ 数据库连接正常")
        return True
    except Exception as e:
        print(f"❌ 数据库连接失败: {e}")
        print("请检查数据库配置和连接信息")
        return False

def main():
    """主函数"""
    print("🚀 启动 Markdown Factory...")
    print("=" * 50)
    
    # 检查依赖
    if not check_dependencies():
        sys.exit(1)
    
    # 检查数据库
    if not check_database():
        sys.exit(1)
    
    print("=" * 50)
    print("✅ 所有检查通过，启动应用...")
    print(f"🌐 应用地址: http://localhost:5000")
    print("📝 按 Ctrl+C 停止应用")
    print("=" * 50)
    
    # 启动应用
    try:
        app.run(debug=True, host='0.0.0.0', port=5000)
    except KeyboardInterrupt:
        print("\n👋 应用已停止")
    except Exception as e:
        print(f"❌ 启动失败: {e}")
        sys.exit(1)

if __name__ == '__main__':
    main() 