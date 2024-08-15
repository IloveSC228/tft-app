import HashMap from '@ohos.util.HashMap';
import prompt from '@ohos.promptAction';
import { comp } from '../model/comp';
import { augs } from '../viewmodel/augmentData';
import { craftableItems, items } from '../viewmodel/itemData';
import { pro, race, traitCntLevel1234, traitCntLevel234, traitCntLevel2345, traitCntLevel246, traitCntLevel345, traitCntLevel3456, traitCntLevel357, traitIcons, traitIconsB, traitLevel, traits} from '../viewmodel/traitData';
import { unitIcons, units, unitsAll } from '../viewmodel/unitData';
import { augChooseDialog } from './augChooseDialog';
import { extraDialog } from './extraDialog';
import { opUnitDialog } from './opUnitDialog';
@CustomDialog
export struct addCompDialog {
  @Link newComp: comp;
  confirm?: (newComp: comp) => void;
  @State input: string = "";
  // 英雄边框颜色
  private unitBorder: Record<number, string> = {0: '#31d8e2', 1:'#666666',2:'#779462',3:'#536fae',4:'#a5438c',5:'#f5cc5e'};
  // 英雄
  @State unitSelect: Array<string> = []; // 选择的英雄
  @State unitTypeIndex: number = 0; // 0是消耗，1是种族，2是职业
  @State unitSelected: Array<string> = []; // 等待被选的英雄
  @State unitCostIndex: number = 0;
  @State unitRaceIndex: number = 0;
  @State unitProIndex: number = 0;
  private unitCostTabsController : TabsController = new TabsController()
  private unitRaceTabsController : TabsController = new TabsController()
  private unitProTabsController : TabsController = new TabsController()
  @State unitEdit: boolean = false;
  @State opUnit: string = ''; // 操作的弈子
  @State unitExtra: string = ''; // 天选弈子
  @State traitExtra: string = ''; // 天选羁绊
  @Provide itemSelect: Array<string> = [] // 每个弈子的装备
  @State map: HashMap<string, Array<string>> = new HashMap<string, Array<string>>();
  opUnitDialogController: CustomDialogController = new CustomDialogController({
    builder: opUnitDialog({
      opUnit: $opUnit,
      confirm: (name: string, itemSelect: Array<string>) => {
        if (itemSelect.length > 0) {
          if (this.map.hasKey(name))
            this.map.replace(name, itemSelect);
          else
            this.map.set(name, itemSelect);
        }
      },
    }),
    alignment: DialogAlignment.Center,
    customStyle: true,
  })
  // 天选
  extraDialogController: CustomDialogController = new CustomDialogController({
    builder: extraDialog({
      unitSelect: $unitSelect,
      unitExtra: $unitExtra,
      confirm: (unitExtra: string) => {
        this.unitExtra = unitExtra;
        this.traitExtra = unitsAll[unitExtra].race;
        this.newComp.traitExtra = this.traitExtra;
      }
    }),
    alignment: DialogAlignment.Center,
    customStyle: true,
  })
  // 强化符文
  @State augmentSelect: Array<string> = []; // 优选
  augChooseDialogController: CustomDialogController = new CustomDialogController({
    builder: augChooseDialog({
      maxCnt: 7,
      augmentSelect: $augmentSelect,
      confirm: () => {
        this.newComp.augments = this.augmentSelect;
      }
    }),
    alignment: DialogAlignment.Center,
    customStyle: true,
  })
  controller?: CustomDialogController;
  aboutToAppear() {
    // 装备
    this.itemSelect = [];
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
      Column() {
        Divider()
          .width('100%')
          .color('#D3D3D3')
          .strokeWidth(0.5)
        List() {
          // 阵容名称
          ListItem() {
            Column() {
              Text('阵容名称')
              .width('100%')
              .fontSize(20)
              .fontColor(Color.Black)
              .margin({left: 30})
              TextInput({
                placeholder: '请输入阵容名称',
                text: this.newComp.name === '' ? this.input : this.newComp.name
              })
                .borderRadius(24)
                .backgroundColor('#F5F5F5')
                .padding({left: 10})
                .type(InputType.Normal)
                .onChange((value: string) => {
                  this.input = value;
                  this.newComp.name = value;
                })
            }
            .height(80)
            .padding({top: 15, bottom: 11})
          }
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
                .height('6%')
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
                          this.newComp.units = this.unitSelect;
                        }
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
                    .margin({ top: 10, bottom: 5, left: 15, right: 15 })
                  Image($r('app.media.deleteMode'))
                    .width(20)
                    .height(20)
                    .onClick(() => {
                      this.unitEdit = !this.unitEdit;
                    })
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
                  this.map.clear();
                  this.newComp.units = this.unitSelect;
                  this.newComp.traitExtra = "";
                  this.unitExtra = "";
                  this.traitExtra = "";
                })
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
              .backgroundColor(Color.White)
              .margin({bottom: this.unitSelect.length != 0 ? 5 : 10})

              Grid() {
                ForEach(this.unitSelect, (itemT: string) => {
                  GridItem() {
                    Stack({alignContent: Alignment.TopEnd}) {
                      // 删除英雄
                      if (this.unitEdit) {
                        Column() {
                          // 删除当前
                          Image($r('app.media.deleteOne'))
                            .height(13)
                            .width(13)
                        }
                        .zIndex(1)
                        Image(unitIcons[itemT])
                          .height(40)
                          .width(40)
                          .margin(10)
                          .borderRadius(3)
                          .margin({bottom: 10})
                          .onClick(() => {
                            let delIndex = this.unitSelect.indexOf(itemT);
                            this.unitSelect.splice(delIndex, 1);
                            if (this.map.hasKey(itemT))
                              this.map.remove(itemT);
                            if (this.unitSelect.length == 0)
                              this.unitEdit = false;
                            this.newComp.units = this.unitSelect;
                            if (this.unitExtra == itemT) {
                              this.unitExtra = "";
                              this.traitExtra = "";
                              this.newComp.traitExtra = "";
                            }
                          })
                      }
                      else { // 为已选添加装备和天选
                        Column() {
                          // 删除当前
                          Image($r('app.media.deleteOne'))
                            .height(13)
                            .width(13)
                        }
                        .visibility(Visibility.Hidden)
                        Image(unitIcons[itemT])
                          .height(40)
                          .width(40)
                          .margin(10)
                          .borderRadius(3)
                          .margin({bottom: 10})
                          .onClick(() => {
                            this.opUnit = itemT;
                            if (this.map.hasKey(itemT))
                              this.itemSelect = this.map.get(itemT);
                            else
                              this.itemSelect = [];
                            this.opUnitDialogController.open();
                          })
                      }
                    }
                  }
                  .margin({left: 10})
                })
              }
              .height(this.unitSelect.length != 0 ? '10%' : '0%')
              .rowsTemplate('1fr')

              Divider()
                .width('100%')
                .color('#D3D3D3')
                .strokeWidth(0.5)

            }
            .width('100%')
            .justifyContent(FlexAlign.Start)
          }
          .backgroundColor(Color.White)
          // 选择天选
          ListItem() {
            Column() {
              Divider()
                .width('100%')
                .color('#D3D3D3')
                .strokeWidth(0.5)
              Column() {
                Row() {
                  Text()
                    .width(4)
                    .height(17)
                    .backgroundColor('#9370DB')
                    .margin({left: 10, right: 5})
                  Text('赛季之星')
                    .fontSize(17)
                }
                .width('100%')
                .margin({bottom: 10})
                Row() {
                  if (this.unitExtra == "") {
                    Image($r('app.media.addSquare'))
                      .width(35)
                      .height(35)
                      .margin({left: 20})
                      .onClick(() => {
                        this.extraDialogController.open();
                      })
                  }
                  else {
                    Image(unitIcons[this.unitExtra])
                      .width(30)
                      .height(30)
                      .margin({left: 20})
                    Image($r('app.media.right'))
                      .width(30)
                      .height(30)
                      .margin({left: 20})
                    Image(this.traitExtra == unitsAll[this.unitExtra].race ? traitIcons[this.traitExtra] : traitIconsB[unitsAll[this.unitExtra].race])
                      .width(30)
                      .height(30)
                      .margin({left: 20})
                      .backgroundColor(this.traitExtra == unitsAll[this.unitExtra].race ? Color.Black : Color.White)
                      .onClick(() => {
                        this.traitExtra = unitsAll[this.unitExtra].race;
                        this.newComp.traitExtra = this.traitExtra;
                      })
                    Image(this.traitExtra == unitsAll[this.unitExtra].pro[0] ? traitIcons[this.traitExtra] : traitIconsB[unitsAll[this.unitExtra].pro[0]])
                      .width(30)
                      .height(30)
                      .margin({left: 20})
                      .backgroundColor(this.traitExtra == unitsAll[this.unitExtra].pro[0] ? Color.Black : Color.White)
                      .onClick(() => {
                        this.traitExtra = unitsAll[this.unitExtra].pro[0];
                        this.newComp.traitExtra = this.traitExtra;
                      })
                    if (unitsAll[this.unitExtra].pro.length == 2) {
                      Image(this.traitExtra == unitsAll[this.unitExtra].pro[1] ? traitIcons[this.traitExtra] : traitIconsB[unitsAll[this.unitExtra].pro[1]])
                        .width(30)
                        .height(30)
                        .backgroundColor(this.traitExtra == unitsAll[this.unitExtra].pro[1] ? Color.Black : Color.White)
                        .margin({left: 20})
                        .onClick(() => {
                          this.traitExtra = unitsAll[this.unitExtra].pro[1];
                          this.newComp.traitExtra = this.traitExtra;
                        })
                    }

                  }
                }
              }
              .width('100%')
              .padding(10)
              .backgroundColor(Color.White)
              .alignItems(HorizontalAlign.Start)
            }

          }
          // 选择强化符文
          ListItem() {
            Column() {
              Divider()
                .width('100%')
                .color('#D3D3D3')
                .strokeWidth(0.5)
              Column() {
                Row() {
                  Text()
                    .width(4)
                    .height(17)
                    .backgroundColor('#9370DB')
                    .margin({left: 10, right: 5})
                  Text('强化符文')
                    .fontSize(17)
                }
                .width('100%')
                .margin({bottom: 5})
                Row() {
                  Grid() {
                    ForEach([0,1,2,3,4,5,6], (id: number) => {
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
                          Image(this.augmentSelect.length > id ? augs[this.augmentSelect[id]].icon : $r('app.media.addOneG'))
                            .height(45)
                            .width(45)
                            .borderRadius(20)
                            .borderWidth(3)
                            .borderColor(this.augmentSelect.length > id ? '#ecbd47' : '#F1F2F7')
                            .backgroundColor(this.augmentSelect.length > id ? '#232341' : Color.White)
                            .margin({top: 10, bottom: 5})
                            .onClick(() => {
                              if (this.augmentSelect.length > id) {
                                this.augmentSelect.splice(id, 1);
                                this.newComp.augments = this.augmentSelect;
                              }
                              else {
                                if (this.augChooseDialogController != undefined) {
                                  this.augChooseDialogController.open();
                                }
                              }
                            })
                        }
                      }
                    })
                  }
                  .height('22%')
                  .columnsTemplate('1fr 1fr 1fr 1fr')
                }
                .backgroundColor("#F1F2F7")
              }
              .width('100%')
              .padding(10)
              .backgroundColor(Color.White)
              .alignItems(HorizontalAlign.Start)
            }

          }
        }
        .height('100%')
      }
      .width('100%')
      .height('95%')
      .justifyContent(FlexAlign.Start)

      Column() {
        Divider()
          .width('100%')
          .color('#D3D3D3')
          .strokeWidth(0.5)
        Row() {
          Button('全部移除')
            .width("50%")
            .fontSize(15)
            .fontColor(Color.Black)
            .backgroundColor(Color.White)
            .type(ButtonType.Normal)
            .onClick(() => {
              this.controller?.close();
            })
          Divider()
            .height(32)
            .color('#D3D3D3')
            .strokeWidth(0.5)
            .vertical(true)

          Button('确认')
            .width("50%")
            .fontSize(15)
            .type(ButtonType.Normal)
            .fontColor(Color.Black)
            .backgroundColor(Color.White)
            .onClick(() => {
              if (!this.map.hasKey(this.unitExtra)) {
                prompt.showToast({ message: '赛季之星必须携带装备', bottom: 70 });
              }
              else {
                // 调换英雄顺序，将赛季之星放置在第一个位置,有装备的紧跟后面
                let unitsTmp: Array<string> = this.newComp.units;
                this.newComp.units = [];
                this.newComp.units.push(this.unitExtra);
                this.newComp.unitItem.push(this.map.get(this.unitExtra));
                this.map.forEach((value, key) => {
                  if (key != this.unitExtra) {
                    this.newComp.units.push(key);
                    this.newComp.unitItem.push(value);
                  }
                })
                for (let i = 0; i < unitsTmp.length; i++) {
                  if (this.map.hasKey(unitsTmp[i]))
                    continue
                  else
                    this.newComp.units.push(unitsTmp[i]);
                }
                // 装备
                for (let i = 0; i < this.newComp.unitItem.length; i++) {
                  if (this.newComp.unitItem[i] != undefined) {
                    for (let j = 0; j < this.newComp.unitItem[i].length; j++) {
                      if (this.newComp.unitItem[i][j] in this.newComp.items)
                        continue;
                      else
                        this.newComp.items.push(this.newComp.unitItem[i][j]);
                      // 计算基本装备数量
                      if (craftableItems.includes(this.newComp.unitItem[i][j])) {
                        this.newComp.baseItems[items[this.newComp.unitItem[i][j]].compA]++;
                        this.newComp.baseItems[items[this.newComp.unitItem[i][j]].compB]++;
                      }
                      // 纹章让羁绊+1
                      if (this.newComp.unitItem[i][j].includes('纹章')) {
                        let trait = this.newComp.unitItem[i][j].substr(0, this.newComp.unitItem[i][j].length - 2);
                        console.log(trait + "+1")
                        if (this.newComp.traits.includes(trait))
                          this.newComp.traitsCnt[this.newComp.traits.indexOf(trait)] += 1;
                        else {
                          this.newComp.traits.push(trait);
                          this.newComp.traitsCnt.push(1);
                        }
                      }
                    }
                  }
                }
                console.log("基础装备:" + this.newComp.baseItems);
                // 羁绊
                // 先将所有成型的羁绊计算出来
                for (let i = 0; i < this.newComp.units.length; i++) {
                  // 种族
                  let race: string = unitsAll[this.newComp.units[i]].race
                  if (this.newComp.traits.includes(race))
                    this.newComp.traitsCnt[this.newComp.traits.indexOf(race)]++
                  else {
                    this.newComp.traits.push(race);
                    this.newComp.traitsCnt.push(1);
                  }
                  // 职业
                  let pro: Array<string> = unitsAll[this.newComp.units[i]].pro
                  for (let j = 0; j < pro.length; j++) {
                    if (this.newComp.traits.includes(pro[j]))
                      this.newComp.traitsCnt[this.newComp.traits.indexOf(pro[j])]++
                    else {
                      this.newComp.traits.push(pro[j]);
                      this.newComp.traitsCnt.push(1);
                    }
                  }
                }
                console.log("羁绊:" + this.newComp.traits);
                console.log("羁绊数量:" + this.newComp.traitsCnt);
                // 天选羁绊加1
                this.newComp.traitsCnt[this.newComp.traits.indexOf(this.traitExtra)]++
                // 将未达到最低要求的羁绊删除掉
                let map: HashMap<string, number> = new HashMap<string, number>();
                for (let i = this.newComp.traits.length - 1; i >= 0; i--) {
                  if (this.newComp.traitsCnt[i] < traits[this.newComp.traits[i]].cnt[0]) {
                    this.newComp.traits.splice(i, 1);
                    this.newComp.traitsCnt.splice(i, 1);
                  }
                  else
                    map.set(this.newComp.traits[i], this.newComp.traitsCnt[i]);
                }
                let spTrait: number = 0;
                for (let i = this.newComp.traits.length - 1; i >= 0; i--) {
                  if (['大触打击乐', 'DJ娑娜', '戏命师', '影流之镰'].includes(this.newComp.traits[i])) {
                    let trait: string = this.newComp.traits[i];
                    console.log("lll123修改的"+trait);
                    this.newComp.traits.splice(i, 1);
                    this.newComp.traits.splice(0,0,trait);
                    this.newComp.traitsCnt.splice(i, 1);
                    this.newComp.traitsCnt.splice(0,0,1);
                    spTrait += 1;
                    console.log("lll123排序前"+this.newComp.traits);
                    console.log("lll123排序前" + spTrait)
                  }
                }
                // 对达到要求的羁绊进行排序
                let sorta = this.newComp.traits.slice(0, spTrait).sort((a: string, b: string) => traitLevel[a] - traitLevel[b]);
                let sortb = this.newComp.traits.slice(spTrait, this.newComp.traits.length).sort((a: string, b: string) => {
                  let traitCntLevelA: number = 0;
                  let traitCntLevelB: number = 0;
                  if (a == '电子舞曲')
                    traitCntLevelA = traitCntLevel2345[map.get(a)];
                  else if (a == '爵士乐')
                    traitCntLevelA = traitCntLevel234[map.get(a)];
                  else if (a == '迪斯科')
                    traitCntLevelA = traitCntLevel3456[map.get(a)];
                  else if (a == '超级粉丝')
                    traitCntLevelA = traitCntLevel345[map.get(a)];
                  else if (a == '高能流行')
                    traitCntLevelA = traitCntLevel1234[map.get(a)];
                  else if (a == '双修出道')
                    traitCntLevelA = 4;
                  else if (['乡村音乐', '刀锋领主', 'k/DA', '五杀摇滚', '心之钢'].includes(a)) {
                    if ([4, 6, 8].includes(map.get(a)))
                      traitCntLevelA = traitCntLevel357[map.get(a)-1];
                    else if (map.get(a) == 9)
                      traitCntLevelA = traitCntLevel357[7];
                    else
                      traitCntLevelA = traitCntLevel357[10];
                  }
                  else {
                    if (map.get(a) < 9 && map.get(a) % 2 != 0)
                      traitCntLevelA = traitCntLevel246[map.get(a) - 1];
                    else
                      traitCntLevelA = traitCntLevel246[map.get(a)];
                  }
                  if (b == '电子舞曲')
                    traitCntLevelB = traitCntLevel2345[map.get(b)];
                  else if (b == '爵士乐')
                    traitCntLevelB = traitCntLevel234[map.get(b)];
                  else if (b == '迪斯科')
                    traitCntLevelB = traitCntLevel3456[map.get(b)];
                  else if (b == '超级粉丝')
                    traitCntLevelB = traitCntLevel345[map.get(b)];
                  else if (b == '高能流行')
                    traitCntLevelB = traitCntLevel1234[map.get(b)];
                  else if (b == '双修出道')
                    traitCntLevelB = 4;
                  else if (['乡村音乐', '刀锋领主', 'k/DA', '五杀摇滚', '心之钢'].includes(b)) {
                    if ([4, 6, 8].includes(map.get(b)))
                      traitCntLevelB = traitCntLevel357[map.get(b)-1];
                    else if (map.get(b) == 9)
                      traitCntLevelB = traitCntLevel357[7];
                    else
                      traitCntLevelB = traitCntLevel357[10];
                  }
                  else {
                    if (map.get(b) < 9 && map.get(b) % 2 != 0)
                      traitCntLevelB = traitCntLevel246[map.get(b) - 1];
                    else
                      traitCntLevelB = traitCntLevel246[map.get(b)];
                  }
                  if (traitCntLevelA === traitCntLevelB)
                    return traitLevel[a] - traitLevel[b];
                  else
                    return traitCntLevelA - traitCntLevelB;
                })
                console.log("lll123排序后" + sorta)
                console.log("lll123排序后" + sortb)
                // 对排序后的数量也重排序
                this.newComp.traitsCnt = [];
                for (let i = 0; i < this.newComp.traits.length; i++) {
                  this.newComp.traitsCnt.push(map.get(this.newComp.traits[i]))
                }
                // traitshow
                let cnt = 0;
                this.newComp.traitsShow = "";
                for (let i = 0; i < this.newComp.traits.length; i++) {
                  if (['大触打击乐', 'DJ娑娜', '戏命师', '双修出道', '影流之镰'].includes(this.newComp.traits[i])) {
                    continue
                  }
                  else if (cnt < 3) {
                    this.newComp.traitsShow += String(map.get(this.newComp.traits[i]));
                    this.newComp.traitsShow += this.newComp.traits[i];
                    cnt++;
                  }
                  else
                    break;
                }
                console.log("lll123traitShow:" + this.newComp.traitsShow)
                // musicshow
                this.newComp.musicShow = "";
                cnt = 0;
                for (let i = 0; i < this.newComp.traits.length; i++) {
                  if (cnt == 2)
                    break;
                  else if (cnt == 1 && race.includes(this.newComp.traits[i])) {
                    this.newComp.musicShow += "/";
                    this.newComp.musicShow += this.newComp.traits[i];
                    cnt++;
                  }
                  else if (cnt == 0 && race.includes(this.newComp.traits[i])) {
                    this.newComp.musicShow += this.newComp.traits[i];
                    cnt++;
                  }
                }
                console.log("lll123musicShow:" + this.newComp.musicShow)

                this.confirm && this.confirm(this.newComp);
                this.controller?.close();
              }
            })
        }
        .width('100%')
      }
      .width('100%')
    }
    .height('80%')
    .backgroundColor(Color.White)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}