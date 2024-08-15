import HashMap from '@ohos.util.HashMap';
import { comp } from '../model/comp';
import { addCompDialog } from '../view/addCompDialog';
import { items } from '../viewmodel/itemData';
import { traitIcons } from '../viewmodel/traitData';
import { unitIcons, unitsAll } from '../viewmodel/unitData';
@Component
export default struct woIndex {
  @StorageLink('myComp') myComp: Array<comp> = [];
  @State isEdit: boolean = false;

  @State newComp: comp = {
    name: '',
    traits: [],
    traitsCnt: [],
    traitsShow: '',
    traitExtra: '',
    units: [],
    unitItem: [],
    items: [],
    baseItems: {'暴风大剑':0,'反曲之弓':0,'无用大棒':0,'女神之泪':0,'锁子甲':0,'负极斗篷':0,'巨人腰带':0,'拳套':0,'金铲铲':0},
    augments: [],
    musicShow: ''
  };
  // 英雄边框颜色
  private unitBorder: Record<number, string> = {0: '#31d8e2', 1:'#666666',2:'#779462',3:'#536fae',4:'#a5438c',5:'#f5cc5e'};

  addCompDialogController: CustomDialogController = new CustomDialogController({
    builder: addCompDialog({
      newComp: $newComp,
      confirm: (newComp: comp) => {
        this.myComp.push(newComp);
      }
    }),
    customStyle: true,
    alignment: DialogAlignment.Bottom
  })

  aboutToAppear() {
    this.myComp = [{
      name: '爵士ez',
      traits: ['大触打击乐','EMO','舞者','爵士乐','心之钢','大腕射手','疾射枪手','格斗家','护卫'],
      traitsCnt: [1,2,2,2,3,2,2,2,2],
      traitsShow: '3心之钢2大腕射手2舞者',
      traitExtra: '心之钢',
      units: ['伊泽瑞尔','俄洛伊','阿木木','瑟提','波比','锤石','凯特琳','厄运小姐','卢锡安'],
      unitItem: [['红霸符','无尽之刃','正义之手'],['棘刺背心','巨龙之爪','救赎']],
      items: ['红霸符','无尽之刃','正义之手','棘刺背心','巨龙之爪','救赎'],
      baseItems: {'暴风大剑':1,'反曲之弓':2,'无用大棒':0,'女神之泪':2,'锁子甲':2,'负极斗篷':2,'巨人腰带':1,'拳套':2,'金铲铲':0},
      augments: ['升级咯！','二进制空投','生日礼物','多变锻炉','源计划巨块 II','吾弓听命于您','吾剑听命于您','利滚利加强版'],
      musicShow: '大触打击乐/EMO'
    }];
  }

  build() {
    Column() {
      Row() {
        Text('我的阵容')
          .fontSize(17)
          .fontFamily('HarmonyHeiTi-Bold')
          .fontWeight(600)
        Image($r('app.media.deleteMode'))
          .width(25)
          .height(25)
          .position({x: 360, y: 7})
          .onClick(() => {
            this.isEdit = !this.isEdit;
          })
      }
      .height(40)
      .backgroundColor('#E6E6FA')
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .width('100%')
      Divider()
        .width('100%')
        .color('#D3D3D3')
        .strokeWidth(0.5)
      Column() {
        List() {
          ForEach(this.myComp, (compT: comp) => {
            ListItem() {
              Stack({ alignContent: Alignment.TopEnd }) {
                if (this.isEdit) {
                  // 删除当前
                  Image($r('app.media.deleteOne'))
                    .height(25)
                    .width(25)
                    .zIndex(1)
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
                      // 阵容棋子
                      Grid() {
                        ForEach(compT.units, (unitT: string, index) => {
                          GridItem() {
                            Column() {
                              Image(unitIcons[unitT])
                                .width(33)
                                .height(33)
                                .borderWidth(2)
                                .margin({bottom: (compT.unitItem.length > compT.units.indexOf(unitT) ? 0 : 10)})
                                .borderColor(index === 0 ? this.unitBorder[0] : this.unitBorder[unitsAll[unitT].cost])

                              if (compT.unitItem.length > compT.units.indexOf(unitT)) {
                                Row() {
                                  ForEach(compT.unitItem[compT.units.indexOf(unitT)], (item: string) => {
                                    Image(items[item].icon)
                                      .width(12)
                                      .height(12)
                                  })
                                }
                                .justifyContent(FlexAlign.Center)
                              }
                            }
                            .margin({left: 7})
                          }
                        })
                      }
                      .height('8%')
                      .rowsTemplate('1fr')
                      .margin({bottom: 10})
                    }
                    // 所有羁绊
                    Flex({wrap: FlexWrap.Wrap}) {
                      ForEach(compT.traits, (item: string) => {
                        Stack({alignContent: Alignment.End}) {
                          if (item === compT.traitExtra) {
                            Column() {
                              Image($r('app.media.star'))
                                .height(13)
                                .width(13)
                                .offset({x: 3, y: -10})
                            }
                            .zIndex(1)
                          }
                          Row() {
                            Row() {
                              Image(traitIcons[item])
                                .height(15)
                                .width(15)
                                .margin({right: 10, top: 1, bottom: 1, left: 3})
                              Text(String(compT.traitsCnt[compT.traits.indexOf(item)]))
                                .fontSize(11)
                                .fontColor(Color.White)
                                .margin({right: 5, top: 1, bottom: 1})
                              Text(item)
                                .fontSize(11)
                                .fontColor(Color.White)
                                .margin({right: 5, top: 1, bottom: 1})
                            }
                            .backgroundColor(Color.Black)
                            .borderRadius(3)
                            .justifyContent(FlexAlign.Center)
                            .alignItems(VerticalAlign.Center)
                          }
                          .backgroundColor(Color.White)
                          .padding(1)
                          .borderRadius(3)
                          .margin({left: 2, right: 2, top: 3, bottom: 3})
                          .borderWidth(2)
                          .borderColor(item === compT.traitExtra ? this.unitBorder[0] : Color.White)
                        }
                        .margin({right: item === compT.traitExtra ? 2 : 0})
                      })
                    }
                    .width('100%')
                    .margin({bottom: 8})
                    // 什么音乐
                    Row() {
                      Image($r('app.media.music'))
                        .width(20)
                        .height(20)
                        .margin({right: 10})
                      Text(compT.musicShow)
                        .fontSize(12)
                        .opacity(0.7)
                    }
                    .width('100%')
                    .justifyContent(FlexAlign.End)
                    .margin({bottom: 10, right: 10})
                  }
                  .backgroundColor(Color.White)
                  .borderRadius(5)
                  .width('100%')
                  .justifyContent(FlexAlign.Start)
                  .onClick(() => {
                    console.log('现在剩余' + this.myComp.length)
                    let delIndex = this.myComp.indexOf(compT);
                    this.myComp.splice(delIndex, 1);
                    console.log('现在剩余' + this.myComp.length);
                    if (this.myComp.length == 0)
                      this.isEdit = false;
                  })
                }
                else {
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
                      // 阵容棋子
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
                    // 所有羁绊
                    Flex({wrap: FlexWrap.Wrap}) {
                      ForEach(compT.traits, (item: string) => {
                        Stack({alignContent: Alignment.End}) {
                          if (item === compT.traitExtra) {
                            Column() {
                              Image($r('app.media.star'))
                                .height(13)
                                .width(13)
                                .offset({x: 3, y: -10})
                            }
                            .zIndex(1)
                          }
                          Row() {
                            Row() {
                              Image(traitIcons[item])
                                .height(15)
                                .width(15)
                                .margin({right: 10, top: 1, bottom: 1, left: 3})
                              Text(String(compT.traitsCnt[compT.traits.indexOf(item)]))
                                .fontSize(11)
                                .fontColor(Color.White)
                                .margin({right: 5, top: 1, bottom: 1})
                              Text(item)
                                .fontSize(11)
                                .fontColor(Color.White)
                                .margin({right: 5, top: 1, bottom: 1})
                            }
                            .backgroundColor(Color.Black)
                            .borderRadius(3)
                            .justifyContent(FlexAlign.Center)
                            .alignItems(VerticalAlign.Center)
                          }
                          .backgroundColor(Color.White)
                          .padding(1)
                          .borderRadius(3)
                          .margin({left: 2, right: 2, top: 3, bottom: 3})
                          .borderWidth(2)
                          .borderColor(item === compT.traitExtra ? this.unitBorder[0] : Color.White)
                        }
                        .margin({right: item === compT.traitExtra ? 2 : 0})
                      })
                    }
                    .width('100%')
                    .margin({bottom: 8})
                    // 什么音乐
                    Row() {
                      Image($r('app.media.music'))
                        .width(20)
                        .height(20)
                        .margin({right: 10})
                      Text(compT.musicShow)
                        .fontSize(12)
                        .opacity(0.7)
                    }
                    .width('100%')
                    .justifyContent(FlexAlign.End)
                    .margin({bottom: 10, right: 10})
                  }
                  .backgroundColor(Color.White)
                  .borderRadius(5)
                  .width('100%')
                  .justifyContent(FlexAlign.Start)
                }
              }
            }
            .width('100%')
            .margin({bottom: 10})
            .padding({left: 10, right: 10})
          })
        }
        .margin({top: 10})
        .backgroundColor('#F1F2F7')
        if (!this.isEdit) {
          // 添加按钮
          Button() {
            Image($r('app.media.addComp'))
          }
          .width(34)
          .height(34)
          .position({x: '85%', y: '85%'})
          .backgroundColor('#F1F2F7')
          .onClick(() => {
            this.newComp = {name: '', traits: [], traitsCnt: [], traitsShow: '', traitExtra: '',
              units: [], unitItem: [], items: [],
              baseItems: {'暴风大剑':0,'反曲之弓':0,'无用大棒':0,'女神之泪':0,'锁子甲':0,'负极斗篷':0,'巨人腰带':0,'拳套':0,'金铲铲':0},
              augments: [], musicShow: ''
            }
            this.addCompDialogController.open();
          })
        }
      }
      .width('100%')
      .height('95%')
      .backgroundColor('#F1F2F7')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#E6E6FA')
  }
}