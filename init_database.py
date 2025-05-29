#!/usr/bin/env python3
"""
数据库初始化脚本
用于手动创建数据库表结构

使用方法:
python init_database.py
"""

import os
import sys
from app import app, db
from sqlalchemy import inspect

def init_database():
    """初始化数据库表"""
    print("开始初始化数据库...")
    
    try:
        with app.app_context():
            # 创建所有表
            db.create_all()
            print("✅ 数据库表创建成功")
            
            # 检查表是否创建成功
            from app import MarkdownDocument
            
            inspector = inspect(db.engine)
            table_exists = inspector.has_table('markdown_documents')
            
            if table_exists:
                print("✅ markdown_documents 表已创建")
                
                # 检查是否有数据
                count = MarkdownDocument.query.count()
                print(f"📊 当前文档数量: {count}")
                
                if count == 0:
                    print("💡 提示: 数据库为空，你可以:")
                    print("   1. 通过Web界面创建文档")
                    print("   2. 执行 database_setup.sql 插入示例数据")
                    print("   3. 使用API接口创建文档")
            else:
                print("❌ 表创建失败")
                return False
                
    except Exception as e:
        print(f"❌ 数据库初始化失败: {e}")
        print("\n可能的解决方案:")
        print("1. 检查数据库连接配置 (config.py)")
        print("2. 确保MySQL服务正在运行")
        print("3. 确保数据库 'markdown_factory' 已创建")
        print("4. 检查数据库用户权限")
        return False
    
    print("\n🎉 数据库初始化完成!")
    print("现在可以启动应用: python run.py")
    return True

if __name__ == '__main__':
    print("=" * 50)
    print("Markdown Factory - 数据库初始化工具")
    print("=" * 50)
    
    # 检查配置
    print(f"数据库配置: {app.config['SQLALCHEMY_DATABASE_URI']}")
    
    # 确认操作
    if len(sys.argv) > 1 and sys.argv[1] == '--force':
        # 强制执行，不询问
        init_database()
    else:
        confirm = input("\n是否继续初始化数据库? (y/N): ").strip().lower()
        if confirm in ['y', 'yes']:
            init_database()
        else:
            print("操作已取消") 