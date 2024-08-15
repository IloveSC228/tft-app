import router from '@ohos.router'
import HashMap from '@ohos.util.HashMap';
import { comp } from '../model/comp';
import { augChooseDialog } from '../view/augChooseDialog';
import { augs } from '../viewmodel/augmentData';
import { tuiJianComp } from '../viewmodel/compData';
import { baseItems, baseToCraft, items } from '../viewmodel/itemData';
import { pro, race } from '../viewmodel/traitData';
import { unitIcons, units, unitsAll } from '../viewmodel/unitData';

@Entry
@Component
struct shiIndex {
  private tabController = new TabsController();
  @State currentIndex: number = 0; // tab的下标
  @State compSearch: Array<comp> = []; // 查询的阵容
  // 基于装备
  @State itemIndex: number = 0; // 选中的基础装备的下标
  @State itemSelect: Array<string> = []; // 选中的装备
  @State itemSelectCnt: Array<number> = []; // 用于查询是否出现过
  private itemTabController = new TabsController();
  // 基于英雄
  @State unitSelect: Array<string> = []; // 选择的英雄
  @State unitTypeIndex: number = 0; // 0是消耗，1是种族，2是职业
  @State unitSelected: Array<string> = []; // 等待被选的英雄
  @State unitCostIndex: number = 0;
  @State unitRaceIndex: number = 0;
  @State unitProIndex: number = 0;
  private unitCostTabsController : TabsController = new TabsController()
  private unitRaceTabsController : TabsController = new TabsController()
  private unitProTabsController : TabsController = new TabsController()
  @State compForSearch: Array<comp> = [];
  // 基于强化符文
  @State augmentSelect: Array<string> = []; // 选择的强化符文

  augChooseDialogController: CustomDialogController = new CustomDialogController({
    builder: augChooseDialog({
      augmentSelect: $augmentSelect,
      maxCnt: 3,
      confirm: () => {
        if (this.augmentSelect.length > 0)
          this.searchComp(2);
      }
    }),
    alignment: DialogAlignment.Center,
    customStyle: true,
  })
  // 英雄边框颜色
  private unitBorder: Record<number, string> = {0: '#31d8e2', 1:'#666666',2:'#779462',3:'#536fae',4:'#a5438c',5:'#f5cc5e'};

  aboutToAppear() {
    // 初始化
    this.compSearch = [];
    // 装备
    this.itemSelect = [];
    this.itemSelectCnt = [];
    // 英雄
    this.unitSelect = [];
    this.unitSelected = [];
    this.unitTypeIndex = 0
    this.unitCostIndex = 0;
    this.unitRaceIndex = 0;
    this.unitProIndex = 0;
    for (let i = 0; i < units.length; i++) {
      if (units[i].cost === 1)
        this.unitSelected.push(units[i].name);
    }
    this.augmentSelect = [];
    let myComp: Array<comp> = AppStorage.Get<Array<comp>>('myComp');
    this.compForSearch = tuiJianComp;
    console.log("lll123数量前"+ this.compForSearch.length);
    for (let i = 0; i < myComp.length; i++) {
      this.compForSearch.push(myComp[i]);
    }
    console.log("lll123数量后"+ this.compForSearch.length);
  }

  searchComp(index: number) {
    this.compSearch = [];
    if (index === 0) { // 基于装备
      if (this.itemSelect.length === 0)
        return;
      let base = new HashMap<string, number>();
      // 找所有的基础装备数
      for (let i = 0; i < this.itemSelect.length; i++) {
        if (baseItems.includes(this.itemSelect[i])) {
          if (base.hasKey(this.itemSelect[i])) {
            base.replace(this.itemSelect[i], base.get(this.itemSelect[i]) +
            this.itemSelectCnt[this.itemSelect.indexOf(this.itemSelect[i])]);
          }
          else {
            base.set(this.itemSelect[i], this.itemSelectCnt[this.itemSelect.indexOf(this.itemSelect[i])]);
          }
        }
        else {
          let compA = items[this.itemSelect[i]].compA;
          let compB = items[this.itemSelect[i]].compB;
          if (base.hasKey(compA)) {
            base.replace(compA, base.get(compA) + this.itemSelectCnt[this.itemSelect.indexOf(this.itemSelect[i])]);
          }
          else {
            base.set(compA, this.itemSelectCnt[this.itemSelect.indexOf(this.itemSelect[i])]);
          }
          if (base.hasKey(compB)) {
            base.replace(compB, base.get(compB) + this.itemSelectCnt[this.itemSelect.indexOf(this.itemSelect[i])]);
          }
          else {
            base.set(compB, this.itemSelectCnt[this.itemSelect.indexOf(this.itemSelect[i])]);
          }
        }
      }

      for (let i = 0; i < this.compForSearch.length; i++) {
        let flag: boolean = true; // 判断该阵容是否含有选中的成装
        for (let j = 0; j < this.itemSelect.length; j++) {
          if (baseItems.includes(this.itemSelect[j])) // 基础装备不判断
            continue;
          if (!this.compForSearch[i].items.includes(this.itemSelect[j])) { // 如果没有直接退出
            flag = false;
            break;
          }
        }
        if (flag) { // 如果选中的成装都有，再来查找对应的基础装备数
          let baseFlag: boolean = true;
          for (let [key, value] of base) {
            if (this.compForSearch[i].baseItems[key] < value) {
              baseFlag = false;
              break;
            }
          }
          if (baseFlag)
            this.compSearch.push(this.compForSearch[i]);
          else
            continue;
        }
        else
          continue;
      }
    }
    else if (index === 1) { // 基于英雄
      if (this.unitSelect.length === 0)
        return;
      for (let i = 0; i < this.compForSearch.length; i++) {
        let flag: boolean = true;
        for (let j = 0; j < this.unitSelect.length; j++) {
          if (!this.compForSearch[i].units.includes(this.unitSelect[j])) {
            flag = false;
            break;
          }
        }
        if (!flag)
          continue;
        else
          this.compSearch.push(this.compForSearch[i]);
      }
    }
    else if (index === 2) { // 基于强化符文
      if (this.augmentSelect.length === 0)
        return;
      for (let i = 0; i < this.compForSearch.length; i++) {
        let flag: boolean = true;
        for (let j = 0; j < this.augmentSelect.length; j++) {
          if (!this.compForSearch[i].augments.includes(this.augmentSelect[j])) {
            flag = false;
            break;
          }
        }
        if (!flag)
          continue;
        else
          this.compSearch.push(this.compForSearch[i]);
      }
    }
  }

  // tabBar 自定义类型
  @Builder tabBuilder(index: number, name: string) {
    Column() {
      Text(name)
        .fontColor('#182431')
        .fontSize(this.currentIndex === index ? 17 : 16)
        .opacity(this.currentIndex === index ? 1 : 0.5)
        .fontWeight(this.currentIndex === index ? 600 : 500)
        .lineHeight(18)
      Divider()
        .strokeWidth(2)
        .width(10)
        .color('#182431')
        .opacity(this.currentIndex === index ? 1 : 0)
    }
    .width('100%')
    .onClick(() => {
      this.currentIndex = index;
      this.tabController.changeIndex(this.currentIndex);
      this.searchComp(this.currentIndex);
    })
  }

  @Builder itemTabBuilder(index: number, name: string) {
    Stack({alignContent: Alignment.Center}) {
      Image(items[name].icon)
        .height(30)
        .width(30)
        .borderRadius(4)
        .renderMode(this.itemIndex === index ? ImageRenderMode.Original : ImageRenderMode.Template)
    }
    .padding(2)
    .borderWidth(4)
    .borderRadius(4)
    .borderColor(this.itemIndex === index ? '#9370DB' : Color.White)
    .onClick(() => {
      this.itemIndex = index;
      this.itemTabController.changeIndex(this.itemIndex);
    })
  }

  @Builder unitCostTabBuilder(index: number, name: string) {
    Row() {
      Text(name)
        .fontSize(13)
        .opacity(this.unitCostIndex === index ? 1 : 0.6)
        .margin({left: 15, right: 15})
    }
    .width(70)
    .justifyContent(FlexAlign.Center)
    .border({width: 2, color: this.unitBorder[index+1], radius: 12, style: BorderStyle.Solid})
    .backgroundColor(this.unitCostIndex === index ? this.unitBorder[index+1] : '#FFFFFF')
    .margin({bottom: 15})
    .onClick(() => {
      this.unitCostIndex = index;
      this.unitCostTabsController.changeIndex(this.unitCostIndex);
      this.unitSelected = [];
      for (let i = 0; i < units.length; i++) {
        if (units[i].cost === index + 1)
          this.unitSelected.push(units[i].name);
      }
    })
  }
  @Builder unitRaceTabBuilder(index: number, name: string) {
    Row() {
      Text(name)
        .fontSize(14)
        .fontColor(this.unitCostIndex === index ? '#FFFFFF' : Color.Black)
        .opacity(this.unitRaceIndex === index ? 1 : 0.6)
        .margin({left: 2, right: 2})
    }
    .width(80)
    .height(25)
    .justifyContent(FlexAlign.Center)
    .border({width: 1, color: Color.Black, radius: 12, style: BorderStyle.Solid})
    .backgroundColor(this.unitCostIndex === index ? Color.Black : '#FFFFFF')
    .margin({bottom: 10, right: 5})
    .onClick(() => {
      this.unitRaceIndex = index;
      this.unitRaceTabsController.changeIndex(this.unitRaceIndex);
      this.unitSelected = [];
      for (let i = 0; i < units.length; i++) {
        if (units[i].race === race[index])
          this.unitSelected.push(units[i].name);
      }
    })
  }
  @Builder unitProTabBuilder(index: number, name: string) {
    Row() {
      Text(name)
        .fontSize(14)
        .fontColor(this.unitCostIndex === index ? '#FFFFFF' : Color.Black)
        .opacity(this.unitProIndex === index ? 1 : 0.6)
        .margin({left: 2, right: 2})
    }
    .width(80)
    .height(25)
    .justifyContent(FlexAlign.Center)
    .border({width: 1, color: Color.Black, radius: 12, style: BorderStyle.Solid})
    .backgroundColor(this.unitCostIndex === index ? Color.Black : '#FFFFFF')
    .margin({bottom: 10, right: 5})
    .onClick(() => {
      this.unitProIndex = index;
      this.unitProTabsController.changeIndex(this.unitProIndex);
      this.unitSelected = [];
      for (let i = 0; i < units.length; i++) {
        if (units[i].pro.includes(pro[index]))
          this.unitSelected.push(units[i].name);
      }
    })
  }
  build() {
    Column() {
      Row() {
        Image($r('app.media.left'))
          .width(20)
          .height(20)
          .position({x: 12, y: 6})
          .borderWidth(0)
          .onClick(() => {
            router.back()
          })

        Text('实战助手')
          .fontSize(17)
          .fontFamily('HarmonyHeiTi-Bold')
          .fontWeight(600)
      }
      .height(40)
      .backgroundColor('#E6E6FA')
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .width('100%')

      Column() {
        Tabs({ barPosition: BarPosition.Start, controller: this.tabController }) {
          TabContent() {
            Column() {
              Divider()
                .width('100%')
                .color('#D3D3D3')
                .strokeWidth(0.5)

              List() {
                // 装备tabBar
                ListItem() {
                  Column() {
                    Row() {
                      Text('基础装备筛选')
                        .fontSize(19)
                        .fontWeight(400)
                        .margin({top: 10, bottom: 5, left: 15})
                    }
                    .width('100%')
                    .justifyContent(FlexAlign.Start)
                    .alignItems(VerticalAlign.Center)
                    .backgroundColor(Color.White)

                    Tabs({ barPosition: BarPosition.Start, controller: this.itemTabController }) {
                      ForEach(baseItems, (item: string, index) => {
                        TabContent() {
                          Column() {
                            Flex({ justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
                              Image(items[item].icon)
                                .height(35)
                                .width(35)
                                .margin(10)
                                .borderRadius(3)
                                .borderWidth(1)
                                .borderColor('#778899')
                                .onClick(() => {
                                  if (this.itemSelect.includes(item)) {
                                    this.itemSelectCnt[this.itemSelect.indexOf(item)]++;
                                    this.searchComp(0);
                                  }
                                  else {
                                    this.itemSelect.push(item)
                                    this.itemSelectCnt.push(1);
                                    this.searchComp(0);
                                  }
                                })
                              ForEach(baseToCraft[item], (craft: string) => {
                                Image(items[craft].icon)
                                  .height(35)
                                  .width(35)
                                  .margin(10)
                                  .borderRadius(3)
                                  .borderWidth(1)
                                  .borderColor('#778899')
                                  .onClick(() => {
                                    if (this.itemSelect.includes(craft)) {
                                      this.itemSelectCnt[this.itemSelect.indexOf(craft)]++;
                                      this.searchComp(0);
                                    }
                                    else {
                                      this.itemSelect.push(craft);
                                      this.itemSelectCnt.push(1);
                                      this.searchComp(0);
                                    }

                                  })
                              })
                            }
                            .width('100%')
                          }
                          .justifyContent(FlexAlign.Start)
                          .alignItems(HorizontalAlign.Center)
                          .width('100%')
                          .backgroundColor('#F1F2F7')
                          .padding({left: 35, right: 35, top: 15, bottom: 15})
                        }
                        .tabBar(this.itemTabBuilder(index, item))
                      })
                    }
                    .backgroundColor(Color.White)
                    .scrollable(false)
                    .width('100%')
                    .height('30%')
                    .barWidth('94%')
                    .barMode(BarMode.Fixed)
                    .vertical(false)
                  }
                  .width('100%')
                  .justifyContent(FlexAlign.Start)
                }
                // 已选装备 + 推荐阵容栏
                ListItem() {
                  Column() {
                    Row() {
                      Row() {
                        Text('已选装备')
                          .fontSize(19)
                          .fontWeight(400)
                          .margin({ top: 10, bottom: 5, left: 15 })
                        Text('点击删除装备')
                          .fontSize(14)
                          .opacity(0.7)
                          .margin({ top: 10, bottom: 5, left: 15 })
                      }
                      .width('30%')

                      Row() {
                        Image($r('app.media.deleteAll'))
                          .height(15)
                          .width(15)
                          .margin({ top: 10, bottom: 5, right: 5 })
                        Text('全部删除')
                          .fontSize(15)
                          .fontColor('#9370DB')
                          .margin({ top: 10, bottom: 5})
                      }
                      .width('20%')
                      .margin({right: 10})
                      .onClick(() => {
                        this.itemSelect = [];
                        this.itemSelectCnt = [];
                        this.compSearch = [];
                      })
                    }
                    .width('100%')
                    .justifyContent(FlexAlign.SpaceBetween)
                    .alignItems(VerticalAlign.Center)
                    .backgroundColor(Color.White)
                    .margin({bottom: this.itemSelectCnt.length != 0 ? 5 : 10})

                    Grid() {
                      ForEach(this.itemSelect, (item: string) => {
                        GridItem() {
                          Stack({alignContent: Alignment.End}) {
                            Column() {
                              // 删除当前
                              Image($r('app.media.deleteOne'))
                                .height(13)
                                .width(13)
                                .offset({x: -3, y: -10})
                              Row() {
                                Text(String(this.itemSelectCnt[this.itemSelect.indexOf(item)]))
                                  .fontSize(this.itemSelectCnt[this.itemSelect.indexOf(item)] > 10 ? 10 : 11)
                                  .fontColor(Color.White)
                              }
                              .height(11)
                              .width(11)
                              .offset({x: -34, y: 7})
                              .justifyContent(FlexAlign.Center)
                              .backgroundColor(Color.Black)
                            }
                            .zIndex(1)
                            Image(items[item].icon)
                              .height(35)
                              .width(35)
                              .margin(10)
                              .borderRadius(3)
                              .onClick(() => {
                                // 只剩一个
                                if (this.itemSelectCnt[this.itemSelect.indexOf(item)] === 1) {
                                  let delIndex = this.itemSelect.indexOf(item);
                                  this.itemSelectCnt.splice(delIndex, 1);
                                  this.itemSelect.splice(delIndex, 1);
                                }
                                else {
                                  this.itemSelectCnt[this.itemSelect.indexOf(item)]--;
                                }
                                if (this.itemSelect.length === 0)
                                  this.compSearch = [];
                                else
                                  this.searchComp(0);
                              })
                          }
                        }
                      })
                    }
                    .height(this.itemSelect.length != 0 ? '8%' : '0%')
                    .rowsTemplate('1fr')

                    Divider()
                      .width('100%')
                      .color('#D3D3D3')
                      .strokeWidth(0.5)
                    Row() {
                      Text('推荐阵容')
                        .fontSize(19)
                        .fontWeight(400)
                        .margin({top: 10, bottom: 5, left: 15})
                    }
                    .width('100%')
                  }
                  .width('100%')
                  .justifyContent(FlexAlign.Start)
                }
                .backgroundColor(Color.White)
                .margin({bottom: 10})

                if (this.compSearch.length > 0) {
                  // 显示查询阵容
                  ForEach(this.compSearch, (compT: comp) => {
                    ListItem() {
                      Column() {
                        Row() {
                          Text('【' + compT.name + '】')
                            .fontSize(16)
                            .margin({left: 10, right: 5})
                          Text(compT.traitsShow)
                            .fontSize(16)
                        }
                        .width('100%')
                        .margin({top: 15, bottom: 10})
                        .justifyContent(FlexAlign.Start)

                        Stack({ alignContent: Alignment.Start }) {
                          Column() {
                            Image($r('app.media.carry'))
                              .height(15)
                              .width(15)

                            Image($r('app.media.star'))
                              .height(13)
                              .width(13)
                          }
                          .width('100%')
                          .height('8%')
                          .justifyContent(FlexAlign.Start)
                          .alignItems(HorizontalAlign.Start)
                          .margin({left: 3})
                          .offset({x: 0, y: -3})
                          .zIndex(1)

                          Grid() {
                            ForEach(compT.units, (unitT: string, index) => {
                              GridItem() {
                                Column() {
                                  Image(unitIcons[unitT])
                                    .width(33)
                                    .height(33)
                                    .borderWidth(2)
                                    .margin({bottom: compT.unitItem.length > index ? 0 : 10})
                                    .borderColor(index === 0 ? this.unitBorder[0] : this.unitBorder[unitsAll[unitT].cost])

                                  if (compT.unitItem.length > index) {
                                    Row() {
                                      ForEach(compT.unitItem[index], (item: string) => {
                                        Image(items[item].icon)
                                          .width(12)
                                          .height(12)
                                      })
                                    }
                                    .justifyContent(FlexAlign.Center)
                                  }
                                }
                                .margin({left: 7})
                                .zIndex(2)
                              }
                            })
                          }
                          .height('8%')
                          .rowsTemplate('1fr')
                          .margin({bottom: 10})
                        }
                      }
                      .backgroundColor(Color.White)
                      .borderRadius(5)
                      .width('100%')
                      .justifyContent(FlexAlign.Start)
                    }
                    .width('100%')
                    .margin({bottom: 10})
                    .padding({left: 10, right: 10})
                  })
                }
                else if (this.itemSelect.length === 0){
                  ListItem() {
                    Column() {
                      Image($r('app.media.pleaseAddItem'))
                        .objectFit(ImageFit.Fill)
                        .height(100)
                        .width(150)
                    }
                    .width('100%')
                    .height('40%')
                    .justifyContent(FlexAlign.Center)
                    .alignItems(HorizontalAlign.Center)
                  }
                }
                else {
                  ListItem() {
                    Column() {
                      Image($r('app.media.noResult'))
                        .objectFit(ImageFit.Fill)
                        .height(100)
                        .width(175)
                    }
                    .height('40%')
                    .width('100%')
                    .justifyContent(FlexAlign.Center)
                    .alignItems(HorizontalAlign.Center)
                  }
                }

              }
              .height('100%')
              .backgroundColor('#F1F2F7')
            }
            .height('100%')
          }
          .tabBar(this.tabBuilder(0, '基于装备'))
          TabContent() {
            Column() {
              Divider()
                .width('100%')
                .color('#D3D3D3')
                .strokeWidth(0.5)

              List() {
                // 英雄tabBar
                ListItem() {
                  Column() {
                    Row() {
                      Text('添加英雄')
                        .fontSize(19)
                        .fontWeight(400)
                        .margin({top: 10, bottom: 5, left: 15})

                      Row() {
                        Button('消耗')
                          .width(65)
                          .height(25)
                          .fontSize(12)
                          .fontColor(this.unitTypeIndex === 0 ? '#FFFFFF' : '#182431')
                          .opacity(this.unitTypeIndex === 0 ? 1 : 0.8)
                          .backgroundColor(this.unitTypeIndex === 0 ? '#182431' : '#FFFFFF')
                          .border({width: 1, color: '#A9A9A9', radius: 12, style: BorderStyle.Solid})
                          .margin({left: 12, right: 3})
                          .onClick(() => {
                            this.unitTypeIndex = 0;
                            this.unitSelected = [];
                            for (let i = 0; i < units.length; i++) {
                              if (units[i].cost === this.unitCostIndex + 1)
                                this.unitSelected.push(units[i].name);
                            }
                          })
                        Button('种族')
                          .width(65)
                          .height(25)
                          .fontSize(12)
                          .fontColor(this.unitTypeIndex === 1 ? '#FFFFFF' : '#182431')
                          .opacity(this.unitTypeIndex === 1 ? 1 : 0.8)
                          .backgroundColor(this.unitTypeIndex === 1 ? '#182431' : '#FFFFFF')
                          .border({width: 1, color: '#A9A9A9', radius: 12, style: BorderStyle.Solid})
                          .margin({right: 3})
                          .onClick(() => {
                            this.unitTypeIndex = 1;
                            this.unitSelected = [];
                            for (let i = 0; i < units.length; i++) {
                              if (units[i].race === race[this.unitRaceIndex])
                                this.unitSelected.push(units[i].name);
                            }
                          })
                        Button('职业')
                          .width(65)
                          .height(25)
                          .fontSize(12)
                          .fontColor(this.unitTypeIndex === 2 ? '#FFFFFF' : '#182431')
                          .backgroundColor(this.unitTypeIndex === 2 ? '#182431' : '#FFFFFF')
                          .border({width: 1, color: '#A9A9A9', radius: 12, style: BorderStyle.Solid})
                          .opacity(this.unitTypeIndex === 2 ? 1 : 0.8)
                          .onClick(() => {
                            this.unitTypeIndex = 2;
                            this.unitSelected = [];
                            for (let i = 0; i < units.length; i++) {
                              if (units[i].pro.includes(pro[this.unitProIndex]))
                                this.unitSelected.push(units[i].name);
                            }
                          })
                      }
                      .height(40)
                      .width('55%')
                      .backgroundColor(Color.White)
                      .justifyContent(FlexAlign.Start)
                      .alignItems(VerticalAlign.Center)
                    }
                    .width('100%')
                    .justifyContent(FlexAlign.SpaceBetween)
                    .alignItems(VerticalAlign.Center)
                    .backgroundColor(Color.White)

                    Divider()
                      .width('100%')
                      .color('#D3D3D3')
                      .strokeWidth(0.5)

                    if (this.unitTypeIndex === 0) {
                      Tabs({ barPosition: BarPosition.Start, controller: this.unitCostTabsController }) {
                        ForEach(['1','2','3','4','5'], (item: string, index) => {
                          TabContent()
                            .tabBar(this.unitCostTabBuilder(index, item))
                        })
                      }
                      .width('100%')
                      .height('5%')
                      .backgroundColor(Color.White)
                      .barMode(BarMode.Fixed)
                    }
                    else if (this.unitTypeIndex === 1) {
                      Tabs({ barPosition: BarPosition.Start, controller: this.unitRaceTabsController }) {
                        ForEach(race, (item: string, index) => {
                          TabContent()
                            .tabBar(this.unitRaceTabBuilder(index, item))
                        })
                      }
                      .width('100%')
                      .height('7%')
                      .backgroundColor(Color.White)
                      .barMode(BarMode.Scrollable)
                    }
                    else if (this.unitTypeIndex === 2) {
                      Tabs({ barPosition: BarPosition.Start, controller: this.unitProTabsController }) {
                        ForEach(pro, (item: string, index) => {
                          TabContent()
                            .tabBar(this.unitProTabBuilder(index, item))
                        })
                      }
                      .width('100%')
                      .height('7%')
                      .backgroundColor(Color.White)
                      .barMode(BarMode.Scrollable)
                    }

                    Flex({ justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
                      ForEach(this.unitSelected, (unit: string) => {
                        Column() {
                          Image(unitIcons[unit])
                            .height(45)
                            .width(45)
                            .margin(10)
                            .borderRadius(3)
                            .borderWidth(1)
                            .borderColor('#778899')
                            .renderMode(this.unitSelect.includes(unit) ? ImageRenderMode.Template : ImageRenderMode.Original)
                            .onClick(() => {
                              if (!this.unitSelect.includes(unit)) {
                                console.log('添加'+ unit + '成功')
                                this.unitSelect.push(unit);
                              }
                              this.searchComp(1);
                            })
                          Text(unit)
                            .fontSize(12)
                        }
                      })
                    }
                    .width('100%')
                    .backgroundColor(Color.White)
                    .margin({top: 10})
                  }
                  .width('100%')
                  .justifyContent(FlexAlign.Start)
                }
                // 已选英雄 + 推荐阵容栏
                ListItem() {
                  Column() {
                    Row() {
                      Row() {
                        Text('已选英雄')
                          .fontSize(19)
                          .fontWeight(400)
                          .margin({ top: 10, bottom: 5, left: 15 })
                        Text('点击删除英雄')
                          .fontSize(14)
                          .opacity(0.7)
                          .margin({ top: 10, bottom: 5, left: 15 })
                      }
                      .width('30%')

                      Row() {
                        Image($r('app.media.deleteAll'))
                          .height(15)
                          .width(15)
                          .margin({ top: 10, bottom: 5, right: 5 })
                        Text('全部删除')
                          .fontSize(15)
                          .fontColor('#9370DB')
                          .margin({ top: 10, bottom: 5})
                      }
                      .width('20%')
                      .margin({right: 10})
                      .onClick(() => {
                        this.unitSelect = [];
                        this.compSearch = [];
                      })
                    }
                    .width('100%')
                    .justifyContent(FlexAlign.SpaceBetween)
                    .alignItems(VerticalAlign.Center)
                    .backgroundColor(Color.White)
                    .margin({bottom: this.itemSelectCnt.length != 0 ? 5 : 10})

                    Grid() {
                      ForEach(this.unitSelect, (item: string) => {
                        GridItem() {
                          Stack({alignContent: Alignment.End}) {
                            Column() {
                              // 删除当前
                              Image($r('app.media.deleteOne'))
                                .height(13)
                                .width(13)
                                .offset({x: -3, y: -12})
                            }
                            .zIndex(1)
                            Image(unitIcons[item])
                              .height(40)
                              .width(40)
                              .margin(10)
                              .borderRadius(3)
                              .onClick(() => {
                                let delIndex = this.unitSelect.indexOf(item);
                                this.unitSelect.splice(delIndex, 1);
                                this.searchComp(1);
                              })
                          }
                        }
                      })
                    }
                    .height(this.unitSelect.length != 0 ? '8%' : '0%')
                    .rowsTemplate('1fr')

                    Divider()
                      .width('100%')
                      .color('#D3D3D3')
                      .strokeWidth(0.5)
                    Row() {
                      Text('推荐阵容')
                        .fontSize(19)
                        .fontWeight(400)
                        .margin({top: 10, bottom: 5, left: 15})
                    }
                    .width('100%')
                  }
                  .width('100%')
                  .justifyContent(FlexAlign.Start)
                }
                .backgroundColor(Color.White)
                .margin({bottom: 10})

                if (this.compSearch.length > 0) {
                  // 显示查询阵容
                  ForEach(this.compSearch, (compT: comp) => {
                    ListItem() {
                      Column() {
                        Row() {
                          Text('【' + compT.name + '】')
                            .fontSize(16)
                            .margin({left: 10, right: 5})
                          Text(compT.traitsShow)
                            .fontSize(16)
                        }
                        .width('100%')
                        .margin({top: 15, bottom: 10})
                        .justifyContent(FlexAlign.Start)

                        Stack({ alignContent: Alignment.Start }) {
                          Column() {
                            Image($r('app.media.carry'))
                              .height(15)
                              .width(15)

                            Image($r('app.media.star'))
                              .height(13)
                              .width(13)
                          }
                          .width('100%')
                          .height('8%')
                          .justifyContent(FlexAlign.Start)
                          .alignItems(HorizontalAlign.Start)
                          .margin({left: 3})
                          .offset({x: 0, y: -3})
                          .zIndex(1)

                          Grid() {
                            ForEach(compT.units, (unitT: string, index) => {
                              GridItem() {
                                Column() {
                                  Image(unitIcons[unitT])
                                    .width(33)
                                    .height(33)
                                    .borderWidth(2)
                                    .margin({bottom: compT.unitItem.length > index ? 0 : 10})
                                    .borderColor(index === 0 ? this.unitBorder[0] : this.unitBorder[unitsAll[unitT].cost])

                                  if (compT.unitItem.length > index) {
                                    Row() {
                                      ForEach(compT.unitItem[index], (item: string) => {
                                        Image(items[item].icon)
                                          .width(12)
                                          .height(12)
                                      })
                                    }
                                    .justifyContent(FlexAlign.Center)
                                  }
                                }
                                .margin({left: 7})
                                .zIndex(2)
                              }
                            })
                          }
                          .height('8%')
                          .rowsTemplate('1fr')
                          .margin({bottom: 10})
                        }
                      }
                      .backgroundColor(Color.White)
                      .borderRadius(5)
                      .width('100%')
                      .justifyContent(FlexAlign.Start)
                    }
                    .width('100%')
                    .margin({bottom: 10})
                    .padding({left: 10, right: 10})
                  })
                }
                else if (this.itemSelect.length === 0){
                  ListItem() {
                    Column() {
                      Image($r('app.media.pleaseAddUnit'))
                        .objectFit(ImageFit.Fill)
                        .height(100)
                        .width(148)
                    }
                    .width('100%')
                    .height('40%')
                    .justifyContent(FlexAlign.Center)
                    .alignItems(HorizontalAlign.Center)
                  }
                }
                else {
                  ListItem() {
                    Column() {
                      Image($r('app.media.noResult'))
                        .objectFit(ImageFit.Fill)
                        .height(100)
                        .width(175)
                    }
                    .height('40%')
                    .width('100%')
                    .justifyContent(FlexAlign.Center)
                    .alignItems(HorizontalAlign.Center)
                  }
                }

              }
              .height('100%')
              .backgroundColor('#F1F2F7')
            }
            .height('100%')
          }
          .tabBar(this.tabBuilder(1, '基于英雄'))
          TabContent() {
            Column() {
              Divider()
                .width('100%')
                .color('#D3D3D3')
                .strokeWidth(0.5)

              List() {
                // 已选强化符文 + 推荐阵容栏
                ListItem() {
                  Column() {
                    Row() {
                      Row() {
                        Text('已选符文')
                          .fontSize(19)
                          .fontWeight(400)
                          .margin({ top: 10, bottom: 5, left: 15 })
                        Text('点击添加/删除符文')
                          .fontSize(13)
                          .opacity(0.7)
                          .margin({ top: 10, bottom: 5, left: 15 })
                      }
                      .width('32%')

                      Row() {
                        Image($r('app.media.deleteAll'))
                          .height(15)
                          .width(15)
                          .margin({ top: 10, bottom: 5, right: 5 })
                        Text('全部删除')
                          .fontSize(15)
                          .fontColor('#9370DB')
                          .margin({ top: 10, bottom: 5})
                      }
                      .width('20%')
                      .margin({right: 10})
                      .onClick(() => {
                        this.augmentSelect = [];
                        this.compSearch = [];
                      })
                    }
                    .width('100%')
                    .justifyContent(FlexAlign.SpaceBetween)
                    .alignItems(VerticalAlign.Center)
                    .backgroundColor(Color.White)
                    .margin({bottom: this.unitSelect.length != 0 ? 5 : 10})

                    Grid() {
                      ForEach([0,1,2], (id: number) => {
                        GridItem() {
                          Stack({alignContent: Alignment.End}) {
                            if (this.augmentSelect.length > id) {
                              Column() {
                                // 删除当前
                                Image($r('app.media.deleteOne'))
                                  .height(13)
                                  .width(13)
                                  .offset({ x: -3, y: -12 })
                              }
                              .zIndex(1)
                            }
                            Image(this.augmentSelect.length > id ? augs[this.augmentSelect[id]].icon : $r('app.media.addOne'))
                              .height(50)
                              .width(50)
                              .borderRadius(20)
                              .borderWidth(3)
                              .borderColor(this.augmentSelect.length > id ? '#ecbd47' : '#FFFFFF')
                              .margin({left: 15})
                              .backgroundColor(this.augmentSelect.length > id ? '#232341' : Color.White)
                              .onClick(() => {
                                if (this.augmentSelect.length > id) {
                                  this.augmentSelect.splice(id, 1);
                                  this.searchComp(2);
                                }
                                else {
                                  if (this.augChooseDialogController != undefined) {
                                    this.augChooseDialogController.open();
                                  }
                                }
                              })
                          }
                        }
                        .margin({bottom: 10})
                      })
                    }
                    .height('10%')
                    .rowsTemplate('1fr')

                    Divider()
                      .width('100%')
                      .color('#D3D3D3')
                      .strokeWidth(0.5)
                    Row() {
                      Text('推荐阵容')
                        .fontSize(19)
                        .fontWeight(400)
                        .margin({top: 10, bottom: 5, left: 15})
                    }
                    .width('100%')
                  }
                  .width('100%')
                  .justifyContent(FlexAlign.Start)
                }
                .backgroundColor(Color.White)
                .margin({bottom: 10})

                if (this.compSearch.length > 0) {
                  // 显示查询阵容
                  ForEach(this.compSearch, (compT: comp) => {
                    ListItem() {
                      Column() {
                        Row() {
                          Text('【' + compT.name + '】')
                            .fontSize(16)
                            .margin({left: 10, right: 5})
                          Text(compT.traitsShow)
                            .fontSize(16)
                        }
                        .width('100%')
                        .margin({top: 15, bottom: 10})
                        .justifyContent(FlexAlign.Start)

                        Stack({ alignContent: Alignment.Start }) {
                          Column() {
                            Image($r('app.media.carry'))
                              .height(15)
                              .width(15)

                            Image($r('app.media.star'))
                              .height(13)
                              .width(13)
                          }
                          .width('100%')
                          .height('8%')
                          .justifyContent(FlexAlign.Start)
                          .alignItems(HorizontalAlign.Start)
                          .margin({left: 3})
                          .offset({x: 0, y: -3})
                          .zIndex(1)

                          Grid() {
                            ForEach(compT.units, (unitT: string, index) => {
                              GridItem() {
                                Column() {
                                  Image(unitIcons[unitT])
                                    .width(33)
                                    .height(33)
                                    .borderWidth(2)
                                    .margin({bottom: compT.unitItem.length > index ? 0 : 10})
                                    .borderColor(index === 0 ? this.unitBorder[0] : this.unitBorder[unitsAll[unitT].cost])

                                  if (compT.unitItem.length > index) {
                                    Row() {
                                      ForEach(compT.unitItem[index], (item: string) => {
                                        Image(items[item].icon)
                                          .width(12)
                                          .height(12)
                                      })
                                    }
                                    .justifyContent(FlexAlign.Center)
                                  }
                                }
                                .margin({left: 7})
                                .zIndex(2)
                              }
                            })
                          }
                          .height('8%')
                          .rowsTemplate('1fr')
                          .margin({bottom: 10})
                        }
                      }
                      .backgroundColor(Color.White)
                      .borderRadius(5)
                      .width('100%')
                      .justifyContent(FlexAlign.Start)
                    }
                    .width('100%')
                    .margin({bottom: 10})
                    .padding({left: 10, right: 10})
                  })
                }
                else if (this.itemSelect.length === 0){
                  ListItem() {
                    Column() {
                      Image($r('app.media.pleaseAddAug'))
                        .objectFit(ImageFit.Fill)
                        .height(100)
                        .width(175)
                    }
                    .width('100%')
                    .height('40%')
                    .justifyContent(FlexAlign.Center)
                    .alignItems(HorizontalAlign.Center)
                  }
                }
                else {
                  ListItem() {
                    Column() {
                      Image($r('app.media.noResult'))
                        .objectFit(ImageFit.Fill)
                        .height(100)
                        .width(175)
                    }
                    .height('40%')
                    .width('100%')
                    .justifyContent(FlexAlign.Center)
                    .alignItems(HorizontalAlign.Center)
                  }
                }

              }
              .height('100%')
              .backgroundColor('#F1F2F7')
            }
            .height('100%')
          }
          .tabBar(this.tabBuilder(2, '基于强化符文'))
        }
        .scrollable(false)
        .width('100%')
        .height('100%')
        .barWidth('94%')
        .barMode(BarMode.Fixed)
        .vertical(false)

        Row() {
          Button('清除数据')
            .fontSize(16)
            .fontWeight(400)
            .width('50%')
            .backgroundColor(Color.Black)
            .fontColor(Color.White)
            .type(ButtonType.Normal)
            .borderRadius(3)
            .onClick(() => {
              this.compSearch = [];
              this.itemSelect = [];
              this.itemSelectCnt = [];
              this.unitSelect = [];
              this.augmentSelect = [];
            })
        }
        .backgroundColor(Color.White)
        .height('8%')
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .height('88%')
      .justifyContent(FlexAlign.SpaceBetween)
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#E6E6FA')
  }
}