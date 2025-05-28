# Markdown Factory API 文档

## 概述

Markdown Factory 提供了RESTful API接口，允许外部应用程序创建和管理Markdown文档。

**基础URL**: `http://localhost:8888/api`

## 认证

API使用API密钥进行身份验证。所有API请求都需要在请求头中包含有效的API密钥。

### API密钥配置

**默认API密钥**: `markdown-factory-api-key-2024`

**请求头名称**: `X-API-Key`

### 获取API信息

可以通过以下接口获取API配置信息（无需验证）：

```bash
curl -X GET http://localhost:8888/api/info
```

响应示例：
```json
{
    "success": true,
    "data": {
        "api_version": "1.0.0",
        "require_api_key": true,
        "api_key_header": "X-API-Key",
        "endpoints": [...]
    }
}
```

### 环境变量配置

可以通过环境变量自定义API密钥：

```bash
export API_KEY="your-custom-api-key"
export REQUIRE_API_KEY="true"  # 设置为false可禁用API密钥验证
```

### 验证错误

如果API密钥验证失败，将返回以下错误：

**缺少API密钥** (HTTP 401):
```json
{
    "success": false,
    "error": "缺少API密钥，请在请求头中添加 X-API-Key"
}
```

**API密钥无效** (HTTP 401):
```json
{
    "success": false,
    "error": "API密钥无效"
}
```

## API接口

### 1. 创建文档

**端点**: `POST /api/documents`

**描述**: 创建新的Markdown文档，系统会自动从内容中提取标题。

**请求头**:
```
Content-Type: application/json
X-API-Key: markdown-factory-api-key-2024
```

**请求体**:
```json
{
    "content": "Markdown内容"
}
```

**参数说明**:
- `content` (string, 必需): Markdown格式的文档内容

**响应格式**:
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

**标题提取规则**:
1. 优先提取一级标题 (`# 标题`)
2. 如果没有一级标题，提取二级标题 (`## 标题`)
3. 如果没有任何标题，提取任意级别的标题
4. 如果完全没有标题，使用第一行非空内容（限制50字符）
5. 如果内容为空，使用"无标题文档"

**图片支持**:
- 支持Markdown图片语法：`![alt文本](图片URL)`
- 自动下载网络图片并嵌入到Word文档中
- 支持独立行图片、行内图片、列表中的图片、引用块中的图片
- 图片会被自动调整大小并转换为JPEG格式
- 如果图片下载失败，会显示图片链接作为备选方案

**示例请求**:
```bash
curl -X POST http://localhost:8888/api/documents \
  -H "Content-Type: application/json" \
  -H "X-API-Key: markdown-factory-api-key-2024" \
  -d '{
    "content": "# 我的新文档\n\n这是文档的内容。\n\n## 章节1\n\n这里是章节内容。"
  }'
```

**错误响应**:
```json
{
    "success": false,
    "error": "错误描述"
}
```

### 2. 获取文档列表

**端点**: `GET /api/documents`

**描述**: 获取文档列表，支持分页。

**查询参数**:
- `page` (int, 可选): 页码，默认为1
- `per_page` (int, 可选): 每页数量，默认为10，最大为100

**响应格式**:
```json
{
    "success": true,
    "data": {
        "documents": [
            {
                "id": 1,
                "title": "文档标题",
                "content": "文档内容",
                "created_at": "2023-01-01T00:00:00",
                "updated_at": "2023-01-01T00:00:00"
            }
        ],
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

**示例请求**:
```bash
curl -X GET "http://localhost:8888/api/documents?page=1&per_page=5" \
  -H "X-API-Key: markdown-factory-api-key-2024"
```

### 3. 获取单个文档

**端点**: `GET /api/documents/{doc_id}`

**描述**: 根据文档ID获取单个文档的详细信息。

**路径参数**:
- `doc_id` (int, 必需): 文档ID

**响应格式**:
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

**示例请求**:
```bash
curl -X GET http://localhost:8888/api/documents/1 \
  -H "X-API-Key: markdown-factory-api-key-2024"
```

**错误响应** (文档不存在):
```json
{
    "success": false,
    "error": "文档不存在"
}
```

### 4. 获取API信息

**端点**: `GET /api/info`

**描述**: 获取API配置信息和可用端点列表。此接口无需API密钥验证。

**响应格式**:
```json
{
    "success": true,
    "data": {
        "api_version": "1.0.0",
        "require_api_key": true,
        "api_key_header": "X-API-Key",
        "endpoints": [
            {
                "method": "POST",
                "path": "/api/documents",
                "description": "创建文档",
                "requires_auth": true
            },
            {
                "method": "GET",
                "path": "/api/documents",
                "description": "获取文档列表",
                "requires_auth": true
            },
            {
                "method": "GET",
                "path": "/api/documents/{doc_id}",
                "description": "获取单个文档",
                "requires_auth": true
            },
            {
                "method": "GET",
                "path": "/api/info",
                "description": "获取API信息",
                "requires_auth": false
            }
        ]
    }
}
```

**示例请求**:
```bash
curl -X GET http://localhost:8888/api/info
```

## 错误处理

API使用标准的HTTP状态码：

- `200 OK`: 请求成功
- `201 Created`: 资源创建成功
- `400 Bad Request`: 请求参数错误
- `401 Unauthorized`: 认证失败（API密钥无效或缺失）
- `404 Not Found`: 资源不存在
- `500 Internal Server Error`: 服务器内部错误

所有错误响应都包含以下格式：
```json
{
    "success": false,
    "error": "错误描述"
}
```

## 使用示例

### Python示例

```python
import requests
import json

# 创建文档
def create_document(content):
    url = "http://localhost:8888/api/documents"
    headers = {"Content-Type": "application/json", "X-API-Key": "markdown-factory-api-key-2024"}
    data = {"content": content}
    
    response = requests.post(url, headers=headers, json=data)
    return response.json()

# 获取文档列表
def get_documents(page=1, per_page=10):
    url = f"http://localhost:8888/api/documents?page={page}&per_page={per_page}"
    headers = {"X-API-Key": "markdown-factory-api-key-2024"}
    response = requests.get(url, headers=headers)
    return response.json()

# 获取单个文档
def get_document(doc_id):
    url = f"http://localhost:8888/api/documents/{doc_id}"
    headers = {"X-API-Key": "markdown-factory-api-key-2024"}
    response = requests.get(url, headers=headers)
    return response.json()

# 使用示例
if __name__ == "__main__":
    # 创建文档
    content = """# API测试文档

这是通过Python API创建的文档。

## 功能特点

- 自动标题提取
- RESTful设计
- JSON响应格式
"""
    
    result = create_document(content)
    print("创建文档:", json.dumps(result, indent=2, ensure_ascii=False))
    
    # 获取文档列表
    documents = get_documents(page=1, per_page=5)
    print("文档列表:", json.dumps(documents, indent=2, ensure_ascii=False))
```

### JavaScript示例

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

// 获取文档列表
async function getDocuments(page = 1, perPage = 10) {
    const response = await fetch(
        `http://localhost:8888/api/documents?page=${page}&per_page=${perPage}`,
        {
            headers: {
                'X-API-Key': 'markdown-factory-api-key-2024'
            }
        }
    );
    
    return await response.json();
}

// 获取单个文档
async function getDocument(docId) {
    const response = await fetch(`http://localhost:8888/api/documents/${docId}`, {
        headers: {
            'X-API-Key': 'markdown-factory-api-key-2024'
        }
    });
    return await response.json();
}

// 使用示例
(async () => {
    try {
        // 创建文档
        const content = `# JavaScript API测试

这是通过JavaScript API创建的文档。

## 特性

- 异步操作
- Promise支持
- 现代ES6+语法
`;
        
        const result = await createDocument(content);
        console.log('创建文档:', result);
        
        // 获取文档列表
        const documents = await getDocuments(1, 5);
        console.log('文档列表:', documents);
        
    } catch (error) {
        console.error('API调用失败:', error);
    }
})();
```

## 注意事项

1. **内容长度**: 建议单个文档内容不超过1MB
2. **并发限制**: 建议控制并发请求数量，避免对服务器造成过大压力
3. **字符编码**: 所有文本内容使用UTF-8编码
4. **Markdown格式**: 支持标准Markdown语法
5. **数据持久化**: 所有数据存储在MySQL数据库中

## 更新日志

### v1.0.0 (2025-05-28)
- 新增文档创建API
- 新增文档列表获取API
- 新增单个文档获取API
- 实现自动标题提取功能
- 支持分页查询

## 联系方式

如有问题或建议，请通过以下方式联系：
- 项目地址: [GitHub Repository]
- 邮箱: [your-email@example.com] 