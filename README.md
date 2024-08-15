# 仓库描述
s10 云顶之弈阵容助手

包括阵容推荐，英雄装备羁绊资料库，我的阵容，实战助手

## 代码结构 entry/src/main/ets/
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

## 流程图
![image](https://github.com/IloveSC228/tft-app/blob/main/images/%E5%9B%BE%E7%89%872.png)

## 页面展示
### 推荐阵容
<div style="display: flex; justify-content: space-around;">
  <img src="https://github.com/IloveSC228/tft-app/blob/main/images/tuijian1.png" alt="tuijian1" style="width: 30%;">
  <img src="https://github.com/IloveSC228/tft-app/blob/main/images/tuijian2.png" alt="tuijian2" style="width: 30%;">
  <img src="https://github.com/IloveSC228/tft-app/blob/main/images/tuijian3.png" alt="tuijian3" style="width: 30%;">
</div>

### 资料库
<div style="display: flex; justify-content: space-around;">
  <img src="https://github.com/IloveSC228/tft-app/blob/main/images/ziliaoku1.png" alt="Image 1" style="width: 22%; margin: 1%">
  <img src="https://github.com/IloveSC228/tft-app/blob/main/images/ziliaoku2.png" alt="Image 2" style="width: 22%; margin: 1%">
  <img src="https://github.com/IloveSC228/tft-app/blob/main/images/ziliaoku3.png" alt="Image 3" style="width: 22%; margin: 1%">
  <img src="https://github.com/IloveSC228/tft-app/blob/main/images/ziliaoku4.png" alt="Image 4" style="width: 22%; margin: 1%">
</div>

<div style="display: flex; justify-content: space-around;">
  <img src="https://github.com/IloveSC228/tft-app/blob/main/images/ziliaoku5.png" alt="Image 1" style="width: 22%; margin: 1%">
  <img src="https://github.com/IloveSC228/tft-app/blob/main/images/ziliaoku6.png" alt="Image 2" style="width: 22%; margin: 1%">
  <img src="https://github.com/IloveSC228/tft-app/blob/main/images/ziliaoku7.png" alt="Image 3" style="width: 22%; margin: 1%">
  <img src="https://github.com/IloveSC228/tft-app/blob/main/images/ziliaoku8.png" alt="Image 4" style="width: 22%; margin: 1%">
</div>

### 我的阵容
<div style="display: flex; justify-content: space-around;">
  <img src="https://github.com/IloveSC228/tft-app/blob/main/images/wode1.png" alt="Image 1" style="width: 22%; margin: 1%">
  <img src="https://github.com/IloveSC228/tft-app/blob/main/images/wode2.png" alt="Image 2" style="width: 22%; margin: 1%">
  <img src="https://github.com/IloveSC228/tft-app/blob/main/images/wode3.png" alt="Image 3" style="width: 22%; margin: 1%">
  <img src="https://github.com/IloveSC228/tft-app/blob/main/images/wode4.png" alt="Image 4" style="width: 22%; margin: 1%">
</div>

<div style="display: flex; justify-content: space-around;">
  <img src="https://github.com/IloveSC228/tft-app/blob/main/images/wode5.png" alt="Image 1" style="width: 22%; margin: 1%">
  <img src="https://github.com/IloveSC228/tft-app/blob/main/images/wode6.png" alt="Image 2" style="width: 22%; margin: 1%">
  <img src="https://github.com/IloveSC228/tft-app/blob/main/images/wode7.png" alt="Image 3" style="width: 22%; margin: 1%">
  <img src="https://github.com/IloveSC228/tft-app/blob/main/images/wode8.png" alt="Image 4" style="width: 22%; margin: 1%">
</div>

### 实战助手
<div style="display: flex; justify-content: space-around;">
  <img src="https://github.com/IloveSC228/tft-app/blob/main/images/shizhan1.png" alt="Image 1" style="width: 22%; margin: 1%">
  <img src="https://github.com/IloveSC228/tft-app/blob/main/images/shizhan2.png" alt="Image 2" style="width: 22%; margin: 1%">
  <img src="https://github.com/IloveSC228/tft-app/blob/main/images/shizhan3.png" alt="Image 3" style="width: 22%; margin: 1%">
  <img src="https://github.com/IloveSC228/tft-app/blob/main/images/shizhan4.png" alt="Image 4" style="width: 22%; margin: 1%">
</div>