"""
Markdown Factory 配置文件
"""

import os
from datetime import timedelta

class Config:
    """基础配置类"""
    
    # 应用基础配置
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'markdown-factory-secret-key-2024'
    
    # 数据库配置
    MYSQL_HOST = os.environ.get('MYSQL_HOST') or '192.168.16.112'
    MYSQL_PORT = os.environ.get('MYSQL_PORT') or '3306'
    MYSQL_USER = os.environ.get('MYSQL_USER') or 'root'
    MYSQL_PASSWORD = os.environ.get('MYSQL_PASSWORD') or '19900114xin'
    MYSQL_DATABASE = os.environ.get('MYSQL_DATABASE') or 'markdown_factory'
    
    SQLALCHEMY_DATABASE_URI = f'mysql+pymysql://{MYSQL_USER}:{MYSQL_PASSWORD}@{MYSQL_HOST}:{MYSQL_PORT}/{MYSQL_DATABASE}?charset=utf8mb4'
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SQLALCHEMY_ENGINE_OPTIONS = {
        'pool_pre_ping': True,
        'pool_recycle': 300,
        'connect_args': {
            'connect_timeout': 10,
            'charset': 'utf8mb4'
        }
    }
    
    # 文件上传配置
    MAX_CONTENT_LENGTH = 16 * 1024 * 1024  # 16MB
    
    # 会话配置
    PERMANENT_SESSION_LIFETIME = timedelta(hours=24)
    
    # Markdown配置
    MARKDOWN_EXTENSIONS = [
        'codehilite',
        'fenced_code',
        'tables',
        'toc',
        'nl2br',
        'sane_lists'
    ]
    
    # 应用配置
    ITEMS_PER_PAGE = 12  # 每页显示的文档数量
    
    # API配置
    API_KEY = os.environ.get('API_KEY') or 'markdown-factory-api-key-2024'
    API_KEY_HEADER = 'X-API-Key'  # API密钥请求头名称
    REQUIRE_API_KEY = os.environ.get('REQUIRE_API_KEY', 'true').lower() == 'true'  # 是否启用API密钥验证
    
class DevelopmentConfig(Config):
    """开发环境配置"""
    DEBUG = True
    TESTING = False

class ProductionConfig(Config):
    """生产环境配置"""
    DEBUG = False
    TESTING = False
    
    # 生产环境安全配置
    SESSION_COOKIE_SECURE = True
    SESSION_COOKIE_HTTPONLY = True
    SESSION_COOKIE_SAMESITE = 'Lax'

class TestingConfig(Config):
    """测试环境配置"""
    TESTING = True
    DEBUG = True
    SQLALCHEMY_DATABASE_URI = 'sqlite:///:memory:'

# 配置字典
config = {
    'development': DevelopmentConfig,
    'production': ProductionConfig,
    'testing': TestingConfig,
    'default': DevelopmentConfig
} 