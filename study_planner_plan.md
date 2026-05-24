# 学生学习任务规划 App 实现方案

## Context

设计一款帮助学生规划学习时间的双端 App，家长端设置任务和时间范围，学生端通过语音输入学习任务，AI 自动生成学习时间表，并通过 Screen Time 实现学习期间的应用限制和任务提醒。

**技术栈**: Flutter/Dart | **AI**: DeepSeek API | **通信**: Apple Family Sharing

---

## 1. 整体架构

### 1.1 双端职责

| 家长端 (Parent) | 学生端 (Student) |
|----------------|------------------|
| 任务审核确认 | 语音输入学习任务 |
| 设置周末学习时间范围 | 查看 AI 生成的时间表 |
| 管理白名单 APP | 不可清除的学习提醒 |
| 查看学习报告 | 专注学习模式 |

### 1.2 数据同步

- **主渠道**: iCloud CloudKit (Apple 原生，Family 成员天然共享)
- **备用**: Firebase Firestore (跨平台支持)

---

## 2. 核心数据模型

```dart
// 学习任务
StudyTask {
  id, studentId, title, category, // recitation/math/freeReview
  estimatedMinutes, status, createdAt
}

// 学习时间表
Schedule {
  id, studentId, date, timeSlots: [
    { startTime, endTime, taskId, status }
  ]
}

// 白名单应用
WhiteListApp {
  id, bundleId, appName, isPermanent, allowedTimeRange?
}
```

---

## 3. AI 规划流程

```
学生语音输入 → 本地 Whisper 识别 → 规则引擎解析任务
    ↓
家长端审核任务列表
    ↓
调用 DeepSeek API 生成学习时间表
    ↓
学生端展示时间表 + 启动 Screen Time 限制
```

**Prompt 模板**:
- 输入: 学生信息 + 任务列表 + 可用时间范围
- 输出: JSON 格式时间表（每45分钟休息5分钟）
- 离线降级: 本地规则引擎生成简化时间表

---

## 4. iOS Screen Time 集成

### 4.1 分层防护

| 层级 | 机制 |
|-----|------|
| 应用层 | 学生端全屏遮罩，任务提醒不可清除 |
| Screen Time | Family Controls 设置 APP 使用限制 |
| MDM (可选) | 企业证书实现设备策略锁定 |

### 4.2 白名单策略

- **永久白名单**: 作业帮、Safari、地图等
- **学习时间白名单**: 限于学习时段使用
- **完全禁止**: 抖音、游戏等

---

## 5. 核心 Flutter 依赖

```yaml
# 状态管理
flutter_riverpod: ^2.4.9

# 语音识别
speech_to_text: ^6.6.0        # iOS Speech 框架
onnxruntime_flutter: ^1.0.0   # Whisper 本地推理

# 平台集成
family_controls: ^2.0.0        # Apple Family Controls
device_info_plus: ^9.1.2

# 数据存储
hive_flutter: ^1.1.0           # 本地快速存储
cloud_firestore: ^4.13.6        # 云同步

# AI 调用
dio: ^5.4.0                    # HTTP 客户端
```

---

## 6. 项目结构

```
lib/
├── core/           # 常量、主题、工具类
├── data/           # 模型、仓库、数据源
├── domain/         # 服务层 (语音/AI规划/ScreenTime)
├── presentation/  # UI层
│   ├── parent/    # 家长端页面
│   └── student/   # 学生端页面
└── providers/     # Riverpod 状态管理
```

---

## 7. 实现路线图

| 阶段 | 内容 | 周期 |
|-----|------|-----|
| 1 | 基础架构、项目初始化、数据模型 | 2周 |
| 2 | 语音输入 (Whisper + 句式解析) | 2周 |
| 3 | AI 规划 (DeepSeek API 集成) | 2周 |
| 4 | Screen Time 集成 (应用限制) | 2周 |
| 5 | 家长端功能 (审核、配置、报告) | 1周 |
| 6 | 测试与发布准备 | 1周 |

---

## 8. 技术难点

| 难点 | 解决方案 |
|-----|---------|
| iOS 无法真正"无法清除"提醒 | 分层防护 (应用遮罩 + Screen Time 限制) |
| Whisper 模型体积大 | 使用 tiny 模型 (39MB)，后台预加载 |
| 离线 AI 规划 | 本地规则引擎降级 |
| 双端数据同步 | CloudKit 主同步 + Firebase 备用 |

---

## 9. 验证方式

1. 运行 `flutter doctor` 确保环境正常
2. 构建 iOS Simulator 版本测试 UI 流程
3. 语音输入测试任务解析
4. 集成测试 DeepSeek API 返回时间表