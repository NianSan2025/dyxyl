# dyxyl - 学生学习任务规划 App (iOS Only)

## 项目概述

帮助学生规划学习时间的双端 iOS App。家长端设置任务和时间范围，学生端通过语音输入学习任务，AI 自动生成学习时间表，并通过 Screen Time 实现学习期间的应用限制。

**技术栈**: SwiftUI | **AI**: DeepSeek API | **存储**: UserDefaults (Codable)

---

## 技术栈

- **框架**: SwiftUI (iOS 17+)
- **架构**: MVVM
- **存储**: UserDefaults (Codable 序列化)
- **HTTP**: URLSession (后续接 DeepSeek API)
- **语音**: iOS Speech 框架
- **Screen Time**: Family Controls

---

## 架构

```
Sources/
├── App/           # App 入口
├── Models/        # 数据模型 (StudyTask, Schedule, AppConfig)
├── Services/      # 服务层 (StorageService)
├── ViewModels/    # MVVM ViewModels
├── Views/
│   ├── Student/   # 学生端页面
│   └── Parent/    # 家长端页面
├── Shared/        # 常量、扩展
└── Resources/     # 资源文件
```

---

## 数据模型

- **StudyTask**: id, studentId, title, category, estimatedMinutes, status, createdAt
- **Schedule**: id, studentId, date, timeSlots
- **AppConfig**: studentId, whiteListApps, permanentWhiteListApps, studyTimeRange

---

## 开发约定

- 提交信息: 中文描述本次改动
- 学生端页面放 `Views/Student/`
- 家长端页面放 `Views/Parent/`
- 每个 View 配对一个 ViewModel

---

## 阶段规划

| 阶段 | 内容 | 周期 |
|-----|------|-----|
| 1 | 基础架构、项目初始化、数据模型 | 2周 |
| 2 | 语音输入 (iOS Speech + 句式解析) | 2周 |
| 3 | AI 规划 (DeepSeek API 集成) | 2周 |
| 4 | Screen Time 集成 (应用限制) | 2周 |
| 5 | 家长端功能 (审核、配置、报告) | 1周 |
| 6 | 测试与发布准备 | 1周 |

---

## 环境要求

- Xcode 15+
- iOS 17+ (Screen Time API)
- DeepSeek API Key (AI 规划)