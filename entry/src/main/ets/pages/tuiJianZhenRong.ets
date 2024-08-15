import router from '@ohos.router';
import { comp } from '../model/comp';
import { tuiJianDialog } from '../view/tuiJianDialog';
import { tuiJianComp } from '../viewmodel/compData';
import { items } from '../viewmodel/itemData';
import { race, traitIcons } from '../viewmodel/traitData';
import { unitIcons, units, unitsAll } from '../viewmodel/unitData';

@Component
export default struct tuiIndex {
  // 轮播控制器
  private swiperController: SwiperController = new SwiperController()
  // 筛选器
  @State chooseText: string = '筛选';
  @Link compShow: Array<comp>;
  // 英雄边框颜色
  private unitBorder: Record<number, string> = {0: '#31d8e2', 1:'#666666',2:'#779462',3:'#536fae',4:'#a5438c',5:'#f5cc5e'};

  // 筛选推荐阵容
  tuiJianDialogController: CustomDialogController = new CustomDialogController({
    builder: tuiJianDialog({
      chooseText: $chooseText,
      confirm: (chooseText: string) => {
        if (chooseText === '筛选' || chooseText.includes('全部')) {
          this.compShow = tuiJianComp;
        }
        else {
          this.compShow = [];
          for (let i = 0; i < tuiJianComp.length; i++) {
            if (tuiJianComp[i].traits.includes(chooseText))
              this.compShow.push(tuiJianComp[i]);
          }
          this.chooseText = chooseText;
        }
      }
    }),
    alignment: DialogAlignment.CenterEnd,
    customStyle: true,
  })

  aboutToAppear() {
    this.compShow = tuiJianComp;
  }

  build() {
    Column() {
      Row() {
        Text('推荐阵容')
          .fontSize(17)
          .fontFamily('HarmonyHeiTi-Bold')
          .fontWeight(600)
      }
      .height(40)
      .backgroundColor('#E6E6FA')
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .width('100%')
      .zIndex(1)

      Divider()
        .width('100%')
        .color('#D3D3D3')
        .strokeWidth(0.5)

      Column() {
        List(){
          ListItem() {
            Column() {
              Swiper(this.swiperController) {
                Image($r('app.media.swiper1'))
                  .width(382)
                  .height(120)
                  .backgroundColor(Color.White)
                Image($r('app.media.swiper2'))
                  .width(382)
                  .height(120)
                  .backgroundColor(Color.White)
                Image($r('app.media.swiper3'))
                  .width(382)
                  .height(120)
                  .backgroundColor(Color.White)
                Image($r('app.media.swiper4'))
                  .width(382)
                  .height(120)
                  .backgroundColor(Color.White)
                Image($r('app.media.swiper5'))
                  .width(382)
                  .height(120)
                  .backgroundColor(Color.White)
              }
              .loop(true)
              .autoPlay(true)
              .interval(3000)
              .margin({top: 15, bottom: 20})

              Divider()
                .width('100%')
                .color('#D3D3D3')
                .strokeWidth(0.5)

              Row() {
                Row() {
                  Text()
                    .width(3)
                    .height(15)
                    .backgroundColor('#9370DB')
                    .margin({left: 10, right: 17})

                  Text('版本号 13.23')
                    .fontSize(13)
                }
                Row() {
                  Image($r('app.media.filter'))
                    .width(15)
                    .height(15)
                    .backgroundColor(Color.White)
                  if (typeof this.chooseText === 'number') {
                    Text('赛季之星 | ' + String(this.chooseText) + '金币')
                      .fontSize(13)
                      .margin({left: 10, right: 15})
                  }
                  else if (this.chooseText === '筛选' || this.chooseText.includes('全部')) {
                    Text(this.chooseText)
                      .fontSize(13)
                      .margin({left: 10, right: 15})
                  }
                  else {
                    Text((race.includes(this.chooseText) ? '种族 | ' : '职业 | ') + this.chooseText)
                      .fontSize(13)
                      .margin({left: 10, right: 15})
                  }
                }
                .onClick(() => {
                  if (this.tuiJianDialogController != undefined)
                    this.tuiJianDialogController.open();
                })
              }
              .height(30)
              .width('100%')
              .alignItems(VerticalAlign.Center)
              .justifyContent(FlexAlign.SpaceBetween)
            }
            .width('100%')
          }
          .width('100%')
          .backgroundColor(Color.White)

          ListItem() {
            Row() {
              Image($r('app.media.shiZhan'))
                .width(20)
                .height(20)
                .backgroundColor('#9370DB')
                .borderRadius(20)
                .margin({left: 10, right: 5})
              Text('实战助手')
                .fontSize(15)
                .fontWeight(350)
                .margin({right: 5})
              Divider()
                .vertical(true)
                .strokeWidth(1)
                .height(20)
                .color('#D3D3D3')
                .margin({right: 5})
              Text('基于游戏实战 推荐合适的阵容')
                .fontSize(12)
                .opacity(0.6)
                .margin({right: 47})
              Button('前往使用')
                .height(25)
                .fontSize(11)
                .fontColor(Color.White)
                .backgroundColor('#9370DB')
                .type(ButtonType.Normal)
                .borderRadius(3)
                .onClick(() => {
                  router.pushUrl({
                    url: 'pages/shiZhanZhuShou',
                  });
                })
            }
            .height(40)
            .width('100%')
            .borderRadius(5)
            .alignItems(VerticalAlign.Center)
            .backgroundColor(Color.White)
          }
          .width('100%')
          .margin({top: 10, bottom: 10})
          .padding({left: 10, right: 10})

          ForEach(this.compShow, (compT: comp) => {
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
                  // 阵容棋子
                  Grid() {
                    ForEach(compT.units, (unitT: string, index) => {
                      GridItem() {
                        Column() {
                          Image(unitIcons[unitT])
                            .width(33)
                            .height(33)
                            .borderWidth(2)
                            .margin({bottom: compT.unitItem.length > compT.units.indexOf(unitT) ? 0 : 10})
                            .borderColor(index === 0 ? this.unitBorder[0] : this.unitBorder[unitsAll[unitT].cost])

                          if (compT.unitItem.length >= compT.units.indexOf(unitT)) {
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
            .width('100%')
            .margin({bottom: 10})
            .padding({left: 10, right: 10})
          })
        }
        .backgroundColor('#F1F2F7')
      }
      .width('100%')
      .height('92%')
    }
    .width('100%')
    .height('100%')
  }
}