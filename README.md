# 🛍️ 二手交易平台SecondHandHub （readme的草稿，待修改）

## 📌 项目简介

一个简易的二手交易平台（前后端新手练习使用）

这是一个基于 **前端 Vue** 构建的二手交易平台，用户可以发布二手商品、浏览商品、与卖家交流并完成交易。

## 🚀 功能特点
- 🛒 **商品发布**：用户可以上传商品信息、图片，并设置价格。
- 🔍 **商品浏览**：支持分类筛选、关键字搜索。
- 💬 **聊天系统**：支持买家与卖家以邮件方式聊天。
- 🔄 **订单管理**：查看历史订单、交易记录。
- 🔐 **用户认证**：登录注册、密码在数据库中加密等。

## 🏗️ 技术栈
- **前端**：Vue 3 + Vite + Pinia
- **后端**（可选）：Node.js + SpringBoot

## 📦 安装与运行
```bash
# 克隆项目
git clone git@github.com:SoftGhostGU/SecondHandHub.git
cd fronted

# 安装依赖
npm install

# 运行项目
npm run dev
```

## 📜 目录结构 （待完成）
```
📂 SecondHandHub
 ├── 📁 backend  # 后端
 │   ├── 📁 second_hand
 │   │   ├── 📁 src
 │   │   │   ├── 📁 main
 │   │   │   │   ├── 📁 java/com/GHOST
 │   │   │   │   │   ├── 📁 anno
 │   │   │   │   │   ├── 📁 config
 │   │   │   │   │   ├── 📁 controller
 │   │   │   │   │   ├── 📁 exception
 │   │   │   │   │   ├── 📁 interceptors
 │   │   │   │   │   ├── 📁 mapper
 │   │   │   │   │   ├── 📁 pojo
 │   │   │   │   │   ├── 📁 service
 │   │   │   │   │   ├── 📁 utils
 │   │   │   │   │   ├── 📁 validation
 │   │   │   │   │   ├── 📄 SecondHandApplication.java # 启动类
 │   │   │   │   ├── 📁 resource
 │   │   │   │   │   ├── 📁 com/GHOST/mapper
 │   │   │   │   │   │   ├── 📄 GoodsMapper.xml
 │   │   │   │   │   ├── 📄 application-dev.yml
 │   │   │   │   │   ├── 📄 application-pro.yml
 │   │   │   │   │   ├── 📄 application-test.yml
 │   │   │   │   │   ├── 📄 application.yml
 │   │   │   ├── 📁 test
 │   │   ├── 📁 target
 │   │   ├── 📄 pom.xml
 ├── 📁 fronted  # 前端
 │   ├── 📁 .vscode
 │   ├── 📁 node_modules
 │   ├── 📁 public
 │   ├── 📁 src
 │   ├── 📄 .gitignore
 │   ├── 📄 index.html
 │   ├── 📄 package-lock.json
 │   ├── 📄 package.json
 │   ├── 📄 README.md
 │   ├── 📄 vite.config.js
 ├── 📁 profile_photo  # 部分图片
 └── 📄 README.ms
```

## 🎨 界面预览
（可在这里添加截图）

## 📌 未来计划
- ✅ **优化 UI 设计**
- ✅ **增加竞价功能**
- ✅ **支持加密货币支付**（结合区块链智能合约）
- ✅ **提供 API 接口，支持第三方集成**

## 🤝 贡献指南

📧 **联系邮箱**：3089308393@qq.com

