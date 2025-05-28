# Markdown Factory

一个基于Flask的Markdown文档管理系统，支持创建、编辑、查看、下载和批量操作Markdown文档。

## 🌟 主要功能

### 📝 文档管理
- **创建文档**: 支持实时Markdown预览的文档创建
- **编辑文档**: 在线编辑Markdown内容
- **查看文档**: HTML渲染显示和源码查看切换
- **删除文档**: 单个或批量删除文档

### 📋 列表展示
- **列表布局**: 以表格形式展示所有文档
- **分页显示**: 支持大量文档的分页浏览
- **文档预览**: 在列表中显示文档内容摘要
- **时间信息**: 显示创建和更新时间

### 📥 下载功能
- **Markdown下载**: 下载原始Markdown文件
- **Word下载**: 将Markdown转换为Word文档下载
- **批量下载**: 支持批量下载多个文档为ZIP压缩包
- **格式选择**: 批量下载时可选择Markdown或Word格式

### ✅ 批量操作
- **批量选择**: 支持全选和单选文档
- **批量下载**: 一键下载多个文档
- **批量删除**: 一键删除多个文档
- **操作提示**: 实时显示选中文档数量

### 📱 响应式设计
- **移动端适配**: 完美支持手机和平板设备
- **Bootstrap 5**: 现代化的UI设计
- **交互优化**: 流畅的用户体验

### 🖼️ 图片支持
- **网络图片嵌入**: 自动下载网络图片并嵌入到Word文档中
- **多种图片格式**: 支持PNG、JPEG、GIF等常见图片格式
- **智能图片处理**: 自动调整图片大小并优化质量
- **多场景支持**: 支持独立行图片、行内图片、列表中的图片、引用块中的图片
- **容错处理**: 图片下载失败时显示图片链接作为备选方案

## 🛠️ 技术栈

- **后端**: Python Flask + SQLAlchemy
- **数据库**: MySQL 8.0
- **前端**: Bootstrap 5 + JavaScript
- **文档处理**: Python-Markdown + python-docx
- **样式**: 自定义CSS + Font Awesome图标

## 📦 安装部署

### 环境要求
- Python 3.8+
- MySQL 8.0
- pip

### 快速安装

#### Linux/Mac
```bash
chmod +x install.sh
./install.sh
```

#### Windows
```cmd
install.bat
```

### 手动安装

1. **克隆项目**
```bash
git clone <repository-url>
cd MarkdownFactory
```

2. **创建虚拟环境**
```bash
python3 -m venv .venv
source .venv/bin/activate  # Linux/Mac
# 或
.venv\Scripts\activate     # Windows
```

3. **安装依赖**
```bash
pip install -r requirements.txt
```

4. **配置数据库**
```bash
# 连接MySQL并执行
mysql -h 192.168.16.105 -u root -p < database_setup.sql
```

5. **启动应用**
```bash
python run.py
```

## ⚙️ 配置说明

### 数据库配置
在 `config.py` 中修改数据库连接信息：

```python
class Config:
    SQLALCHEMY_DATABASE_URI = 'mysql://root:19900114xin@192.168.16.105:3306/markdown_factory'
```

### 应用配置
- **端口**: 默认8888端口
- **调试模式**: 开发环境默认开启
- **文件上传**: 支持Markdown和Word格式

## 🚀 使用指南

### 基本操作

1. **访问首页**: http://localhost:8888
2. **创建文档**: 点击"创建新文档"按钮
3. **编辑文档**: 在文档列表中点击编辑按钮
4. **查看文档**: 点击文档标题或查看按钮

### 批量操作

1. **选择文档**: 使用复选框选择要操作的文档
2. **批量下载**: 
   - 选择文档后点击"批量下载 MD"或"批量下载 Word"
   - 系统会生成ZIP压缩包供下载
3. **批量删除**: 选择文档后点击"批量删除"

### Word转换功能

系统支持将Markdown文档转换为Word格式，转换规则：
- **标题**: 转换为Word标题样式
- **段落**: 保持原有格式
- **列表**: 转换为Word列表
- **代码块**: 使用等宽字体显示
- **粗体**: 保持粗体格式
- **引用**: 转换为Word引用样式
- **图片**: 自动下载网络图片并嵌入到Word文档中
  - 支持 `![alt文本](图片URL)` 语法
  - 自动调整图片大小（最大800x600像素）
  - 转换为JPEG格式以优化文件大小
  - 支持独立行图片和行内图片

## 📡 API接口

### 🔐 认证

所有API接口都需要API密钥验证。请在请求头中添加：

```
X-API-Key: markdown-factory-api-key-2024
```

**环境变量配置**:
```bash
export API_KEY="your-custom-api-key"
export REQUIRE_API_KEY="true"  # 设置为false可禁用验证
```

**获取API信息** (无需验证):
```bash
curl -X GET http://localhost:8888/api/info
```

### 外部API接口

#### 创建文档
```http
POST /api/documents
Content-Type: application/json

{
  "content": "# 文档标题\n\n文档内容..."
}
```

**响应**:
```json
{
  "success": true,
  "data": {
    "id": 1,
    "title": "自动提取的标题",
    "content": "文档内容",
    "created_at": "2023-01-01T00:00:00",
    "updated_at": "2023-01-01T00:00:00"
  },
  "message": "文档创建成功"
}
```

**特性**:
- 自动从内容中提取标题
- 支持完整的Markdown语法
- 返回创建的文档详细信息

#### 获取文档列表
```http
GET /api/documents?page=1&per_page=10
```

**响应**:
```json
{
  "success": true,
  "data": {
    "documents": [...],
    "pagination": {
      "page": 1,
      "per_page": 10,
      "total": 100,
      "pages": 10,
      "has_prev": false,
      "has_next": true
    }
  }
}
```

#### 获取单个文档
```http
GET /api/documents/{doc_id}
```

**响应**:
```json
{
  "success": true,
  "data": {
    "id": 1,
    "title": "文档标题",
    "content": "文档内容",
    "created_at": "2023-01-01T00:00:00",
    "updated_at": "2023-01-01T00:00:00"
  }
}
```

### 内部API接口

#### 批量下载
```http
POST /batch_download
Content-Type: application/json

{
  "doc_ids": [1, 2, 3],
  "file_type": "md"  // 或 "docx"
}
```

#### 批量删除
```http
POST /batch_delete
Content-Type: application/json

{
  "doc_ids": [1, 2, 3]
}
```

### 单个文档下载
- **Markdown**: `GET /download/{doc_id}`
- **Word**: `GET /download_word/{doc_id}`

### API使用示例

#### Python示例
```python
import requests

# 创建文档
def create_document(content):
    url = "http://localhost:8888/api/documents"
    headers = {"Content-Type": "application/json", "X-API-Key": "markdown-factory-api-key-2024"}
    data = {"content": content}
    
    response = requests.post(url, headers=headers, json=data)
    return response.json()

# 使用示例
content = """# API测试文档

这是通过API创建的文档。

## 功能特点

- 自动标题提取
- RESTful设计
- JSON响应格式
"""

result = create_document(content)
print(result)
```

#### JavaScript示例
```javascript
// 创建文档
async function createDocument(content) {
    const response = await fetch('http://localhost:8888/api/documents', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-API-Key': 'markdown-factory-api-key-2024'
        },
        body: JSON.stringify({ content })
    });
    
    return await response.json();
}

// 使用示例
const content = `# JavaScript API测试

这是通过JavaScript API创建的文档。

## 特性

- 异步操作
- Promise支持
- 现代ES6+语法
`;

createDocument(content).then(result => {
    console.log('创建文档:', result);
});
```

**详细API文档**: 请查看 [API_DOCUMENTATION.md](API_DOCUMENTATION.md)

## 📁 项目结构

```