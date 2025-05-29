# 数据库初始化指南

## 📋 概述

从现在开始，Markdown Factory 不会在启动时自动执行建表操作。数据库初始化需要手动执行，这样可以更好地控制数据库的创建时机和过程。

## 🔧 初始化方法

### 方法1: 使用Python脚本（推荐）

```bash
python3 init_database.py
```

**特点:**
- 交互式确认，避免误操作
- 自动检查表是否存在
- 显示详细的初始化状态
- 提供错误诊断信息

**强制执行（跳过确认）:**
```bash
python3 init_database.py --force
```

### 方法2: 直接执行SQL文件

```bash
# 首先创建数据库
mysql -h 192.168.16.105 -u root -p
CREATE DATABASE markdown_factory CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
EXIT;

# 然后执行SQL文件
mysql -h 192.168.16.105 -u root -p markdown_factory < database_setup.sql
```

## 📝 初始化流程

### 1. 安装依赖
```bash
pip install -r requirements.txt
```

### 2. 确保数据库存在
```sql
CREATE DATABASE IF NOT EXISTS markdown_factory 
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

### 3. 初始化表结构
```bash
python3 init_database.py
```

### 4. 启动应用
```bash
python3 run.py
```

## 🔍 初始化脚本功能

`init_database.py` 脚本提供以下功能：

- ✅ **安全检查**: 显示数据库配置信息
- ✅ **交互确认**: 防止误操作
- ✅ **表创建**: 使用SQLAlchemy创建表结构
- ✅ **状态验证**: 检查表是否创建成功
- ✅ **数据统计**: 显示当前文档数量
- ✅ **错误诊断**: 提供详细的错误信息和解决方案

## 🚨 常见问题

### 问题1: 数据库连接失败
```
❌ 数据库初始化失败: (2003, "Can't connect to MySQL server...")
```

**解决方案:**
1. 检查MySQL服务是否运行
2. 验证数据库地址和端口
3. 确认用户名和密码正确
4. 检查网络连接

### 问题2: 数据库不存在
```
❌ 数据库初始化失败: (1049, "Unknown database 'markdown_factory'")
```

**解决方案:**
```sql
CREATE DATABASE markdown_factory CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

### 问题3: 权限不足
```
❌ 数据库初始化失败: (1044, "Access denied for user...")
```

**解决方案:**
```sql
GRANT ALL PRIVILEGES ON markdown_factory.* TO 'root'@'%';
FLUSH PRIVILEGES;
```

## 📊 初始化后的状态

初始化成功后，你会看到：

```
✅ 数据库表创建成功
✅ markdown_documents 表已创建
📊 当前文档数量: 0
💡 提示: 数据库为空，你可以:
   1. 通过Web界面创建文档
   2. 执行 database_setup.sql 插入示例数据
   3. 使用API接口创建文档

🎉 数据库初始化完成!
现在可以启动应用: python run.py
```

## 🔄 重新初始化

如果需要重新初始化数据库（清空所有数据）：

```bash
# 删除数据库
mysql -h 192.168.16.105 -u root -p -e "DROP DATABASE IF EXISTS markdown_factory;"

# 重新创建数据库
mysql -h 192.168.16.105 -u root -p -e "CREATE DATABASE markdown_factory CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

# 重新初始化
python3 init_database.py --force
```

## 📚 相关文件

- `init_database.py` - 数据库初始化脚本
- `database_setup.sql` - SQL建表语句和示例数据
- `config.py` - 数据库配置文件
- `app.py` - 主应用文件（已移除自动建表）

## 🎯 最佳实践

1. **生产环境**: 总是手动执行数据库初始化
2. **开发环境**: 可以使用 `--force` 参数快速初始化
3. **备份**: 在重新初始化前备份重要数据
4. **权限**: 确保数据库用户有足够的权限
5. **网络**: 确保应用服务器可以访问数据库服务器 