-- Markdown Factory 数据库建表语句
-- 数据库服务器: 192.168.16.105:3306
-- 用户名: root
-- 密码: 19900114xin

-- 创建数据库
CREATE DATABASE IF NOT EXISTS markdown_factory 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

-- 使用数据库
USE markdown_factory;

-- 创建markdown_documents表
CREATE TABLE IF NOT EXISTS markdown_documents (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT '文档ID',
    title VARCHAR(255) NOT NULL COMMENT '文档标题',
    content TEXT NOT NULL COMMENT 'Markdown内容',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX idx_title (title),
    INDEX idx_created_at (created_at),
    INDEX idx_updated_at (updated_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Markdown文档表';

-- 插入示例数据
INSERT INTO markdown_documents (title, content) VALUES 
('欢迎使用Markdown Factory', '# 欢迎使用Markdown Factory

这是一个简单而强大的Markdown文档管理工具。

## 功能特性

- ✅ **创建文档**: 支持创建新的Markdown文档
- ✅ **编辑文档**: 实时预览编辑效果
- ✅ **查看文档**: 渲染后的HTML显示
- ✅ **下载文档**: 导出为.md文件
- ✅ **删除文档**: 管理不需要的文档

## 使用方法

1. 点击"创建新文档"开始编写
2. 使用Markdown语法编写内容
3. 实时预览确保格式正确
4. 保存并管理您的文档

## Markdown语法示例

### 文本格式
- **粗体文本**
- *斜体文本*
- `代码片段`

### 列表
1. 有序列表项1
2. 有序列表项2

- 无序列表项1
- 无序列表项2

### 代码块
```python
def hello_world():
    print("Hello, Markdown Factory!")
```

### 表格
| 功能 | 状态 | 描述 |
|------|------|------|
| 创建 | ✅ | 创建新文档 |
| 编辑 | ✅ | 编辑现有文档 |
| 下载 | ✅ | 导出文档 |

> 这是一个引用块，用于突出显示重要信息。

---

**开始您的Markdown之旅吧！** 🚀'),

('Python编程指南', '# Python编程指南

Python是一种高级、解释型、交互式和面向对象的脚本语言。

## 基础语法

### 变量和数据类型

```python
# 字符串
name = "Python"
message = f"Hello, {name}!"

# 数字
age = 30
price = 99.99

# 布尔值
is_active = True

# 列表
fruits = ["apple", "banana", "orange"]

# 字典
person = {
    "name": "Alice",
    "age": 25,
    "city": "Beijing"
}
```

### 控制结构

#### 条件语句
```python
if age >= 18:
    print("成年人")
elif age >= 13:
    print("青少年")
else:
    print("儿童")
```

#### 循环
```python
# for循环
for fruit in fruits:
    print(f"我喜欢{fruit}")

# while循环
count = 0
while count < 5:
    print(f"计数: {count}")
    count += 1
```

### 函数

```python
def greet(name, greeting="Hello"):
    """问候函数"""
    return f"{greeting}, {name}!"

# 调用函数
message = greet("World")
print(message)  # 输出: Hello, World!
```

### 类和对象

```python
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age
    
    def introduce(self):
        return f"我是{self.name}，今年{self.age}岁"

# 创建对象
person = Person("张三", 25)
print(person.introduce())
```

## 常用库

### 文件操作
```python
# 读取文件
with open("file.txt", "r", encoding="utf-8") as f:
    content = f.read()

# 写入文件
with open("output.txt", "w", encoding="utf-8") as f:
    f.write("Hello, World!")
```

### 日期时间
```python
from datetime import datetime, timedelta

now = datetime.now()
tomorrow = now + timedelta(days=1)
print(f"现在: {now}")
print(f"明天: {tomorrow}")
```

## 最佳实践

1. **代码风格**: 遵循PEP 8规范
2. **注释**: 为复杂逻辑添加注释
3. **函数**: 保持函数简洁，单一职责
4. **异常处理**: 使用try-except处理可能的错误
5. **测试**: 编写单元测试确保代码质量

```python
try:
    result = 10 / 0
except ZeroDivisionError:
    print("除零错误!")
except Exception as e:
    print(f"其他错误: {e}")
finally:
    print("清理工作")
```

Happy Coding! 🐍'),

('项目文档模板', '# 项目名称

简短描述项目的目的和功能。

## 目录

- [安装](#安装)
- [使用方法](#使用方法)
- [API文档](#api文档)
- [贡献指南](#贡献指南)
- [许可证](#许可证)

## 安装

### 环境要求

- Python 3.8+
- Node.js 14+
- MySQL 8.0+

### 安装步骤

1. 克隆仓库
```bash
git clone https://github.com/username/project-name.git
cd project-name
```

2. 安装依赖
```bash
pip install -r requirements.txt
npm install
```

3. 配置环境变量
```bash
cp .env.example .env
# 编辑.env文件，填入相应配置
```

4. 初始化数据库
```bash
python manage.py migrate
```

5. 启动服务
```bash
python app.py
```

## 使用方法

### 基本用法

```python
from project import Client

client = Client(api_key="your-api-key")
result = client.process_data(data)
print(result)
```

### 高级配置

```python
config = {
    "timeout": 30,
    "retry_count": 3,
    "debug": True
}

client = Client(config=config)
```

## API文档

### 认证

所有API请求都需要在请求头中包含API密钥：

```
Authorization: Bearer YOUR_API_KEY
```

### 端点

#### GET /api/data
获取数据列表

**参数:**
- `page` (int): 页码，默认为1
- `limit` (int): 每页数量，默认为10

**响应:**
```json
{
    "data": [...],
    "total": 100,
    "page": 1,
    "limit": 10
}
```

#### POST /api/data
创建新数据

**请求体:**
```json
{
    "name": "数据名称",
    "value": "数据值"
}
```

**响应:**
```json
{
    "id": 1,
    "name": "数据名称",
    "value": "数据值",
    "created_at": "2024-01-01T00:00:00Z"
}
```

## 贡献指南

我们欢迎所有形式的贡献！

### 开发流程

1. Fork项目
2. 创建功能分支 (`git checkout -b feature/amazing-feature`)
3. 提交更改 (`git commit -m ''Add some amazing feature''`)
4. 推送到分支 (`git push origin feature/amazing-feature`)
5. 创建Pull Request

### 代码规范

- 遵循PEP 8 Python代码风格
- 添加适当的测试
- 更新相关文档

### 报告问题

如果发现bug或有功能建议，请[创建issue](https://github.com/username/project-name/issues)。

## 许可证

本项目采用MIT许可证 - 查看[LICENSE](LICENSE)文件了解详情。

## 联系方式

- 邮箱: contact@example.com
- 项目主页: https://github.com/username/project-name
- 文档: https://docs.example.com

---

**感谢使用本项目！** ⭐');

-- 显示表结构
DESCRIBE markdown_documents;

-- 显示插入的数据
SELECT id, title, LEFT(content, 100) as content_preview, created_at, updated_at 
FROM markdown_documents 
ORDER BY created_at DESC; 