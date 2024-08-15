# 仓库描述
s10 云顶之弈阵容助手
包括阵容推荐，英雄装备羁绊资料库，
可自己添加阵容

## 代码结构 entry/source/ets/
- `entryablity` —— 程序入口和标准生成
  - `EntryAbility.ts` —— 程序启动入口

- `model` —— 数据模型
  - `augment.ets` —— 强化符文类
  - `comp.ets` —— 阵容类
  - `item.ets` —— 装备类
  - `tabItem.ets` —— 主页tab类
  - `trait.ets` —— 羁绊类
  - `unit.ets` —— 英雄类

- `pages` —— 页面
  - `mainPage.ets` —— 首页
  - `splashPage.ets` —— 启动页
  - `shiZhanZhuShou.ets` —— 实战助手页
  - `tuiJianZhenRong.ets` —— 推荐阵容页
  - `woDeZhenRong.ets` —— 我的阵容页
  - `ziLiaoKu.ets` —— 资料库页

- `view` —— 视图类组件
  - 添加组件 (`addCompDialog.ets`, `addItemDialog.ets`, `extraDialog.ets`)
  - 选择组件 (`augChooseDialog.ets`, `unitDialog.ets`)
  - 对话框组件 (`itemDialog.ets`, `traitDialog.ets`, `tuiJianDialog.ets`)
  - 页面组件 (`itemComp.ets`, `unitComp.ets`, `augComp.ets`, `traitComp.ets`)

- `viewmodel` —— 视图与模型交互组件
  - 数据组件 (`augmentData.ets`, `compData.ets`, `itemData.ets`, `traitData.ets`, `unitData.ets`)

- `resources` —— 资源文件
  - `main` —— 主要资源
  - `base` —— 基础资源
  - `media` —— 包含所有英雄、装备和强化符文的图标

## 页面展示
