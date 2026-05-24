# dyxyl - 学生学习任务规划 App

## 项目概述

帮助学生规划学习时间的双端 iOS App。家长端设置任务和时间范围，学生端通过语音输入学习任务，AI 自动生成学习时间表，并通过 Screen Time 实现学习期间的应用限制。

**技术栈**: Flutter/Dart | **AI**: DeepSeek API | **同步**: iCloud CloudKit / Firebase Firestore

---

## 技术栈

- **框架**: Flutter 3.x
- **状态管理**: flutter_riverpod
- **语音识别**: speech_to_text (iOS Speech) + Whisper (onnxruntime)
- **平台集成**: family_controls (Apple Family Controls)
- **本地存储**: hive_flutter
- **云同步**: cloud_firestore (Firebase)
- **HTTP**: dio

---

## 架构

```
lib/
├── core/           # 常量、主题、工具类
├── data/           # 模型、仓库、数据源
├── domain/         # 服务层 (语音/AI规划/ScreenTime)
├── presentation/    # UI层
│   ├── parent/     # 家长端页面
│   └── student/    # 学生端页面
└── providers/      # Riverpod 状态管理
```

---

## 数据模型

- **StudyTask**: id, studentId, title, category, estimatedMinutes, status, createdAt
- **Schedule**: id, studentId, date, timeSlots
- **WhiteListApp**: id, bundleId, appName, isPermanent, allowedTimeRange

---

## AI 规划流程

```
学生语音输入 → 本地 Whisper 识别 → 规则引擎解析任务
    ↓
家长端审核任务列表
    ↓
调用 DeepSeek API 生成学习时间表
    ↓
学生端展示时间表 + 启动 Screen Time 限制
```

---

## 开发约定

- 分支策略: main (稳定) / develop (开发)
- 提交信息: 中文描述本次改动
- 家长端页面放 `presentation/parent/`
- 学生端页面放 `presentation/student/`
- 数据模型放 `data/models/`

---

## 常用命令

```bash
flutter pub get          # 安装依赖
flutter run              # 运行
flutter build ios        # 构建 iOS
flutter doctor           # 检查环境
```

---

## 阶段规划

| 阶段 | 内容 | 周期 |
|-----|------|-----|
| 1 | 基础架构、项目初始化、数据模型 | 2周 |
| 2 | 语音输入 (Whisper + 句式解析) | 2周 |
| 3 | AI 规划 (DeepSeek API 集成) | 2周 |
| 4 | Screen Time 集成 (应用限制) | 2周 |
| 5 | 家长端功能 (审核、配置、报告) | 1周 |
| 6 | 测试与发布准备 | 1周 |

---

## 环境要求

- Flutter SDK 3.x
- Xcode 15+
- iOS 17+ (Screen Time API)
- DeepSeek API Key (AI 规划)