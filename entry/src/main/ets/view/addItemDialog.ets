import { baseItems, craftableItems, radiantItems, emblems, artifacts, supportItems, items } from '../viewmodel/itemData';
@CustomDialog
export struct addItemDialog {
  controller?: CustomDialogController;
  @Consume itemSelect: Array<string>;
  @State itemShow: Array<string> = [];
  private tabsController: TabsController = new TabsController();
  @State currentIndex: number = 1;

  aboutToAppear() {
    this.itemShow = craftableItems;
  }

  @Builder tabBuilder(index: number, name: string) {
    Row() {
      Text(name)
        .fontColor(this.currentIndex === index ? '#FFFFFF' : '#182431')
        .fontSize(12)
        .opacity(this.currentIndex === index ? 1 : 0.7)
        .margin({top: 3, bottom: 3})
    }
    .width(85)
    .justifyContent(FlexAlign.Center)
    .border({width: 1, color: '#DCDCDC', radius: 12, style: BorderStyle.Solid})
    .backgroundColor(this.currentIndex === index ? '#182431' : '#FFFFFF')
    .margin({left: 5, right: 5})
    .onClick(() => {
      this.currentIndex = index;
      this.tabsController.changeIndex(this.currentIndex);
      if (this.currentIndex === 0)
        this.itemShow = baseItems;
      else if (this.currentIndex === 1)
        this.itemShow = craftableItems;
      else if (this.currentIndex === 2)
        this.itemShow = radiantItems;
      else if (this.currentIndex === 3)
        this.itemShow = emblems;
      else if (this.currentIndex === 4)
        this.itemShow = artifacts;
      else if (this.currentIndex === 5)
        this.itemShow = supportItems;
    })
  }

  build() {
    Column() {
      Column() {
        Row() {
          Text('强化符文')
            .fontSize(19)
            .fontWeight(400)
            .margin({ top: 10, bottom: 5 })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)

        Divider()
          .width('100%')
          .color('#D3D3D3')
          .strokeWidth(0.5)

        Tabs({ barPosition: BarPosition.Start, controller: this.tabsController }) {
          ForEach(['基础装备', '合成装备', '光明装备', '转职纹章', '奥恩神器', '辅助装备'], (name: string, index) => {
            TabContent() {
              Column() {
                Grid() {
                  ForEach(this.itemShow, (item: string) => {
                    GridItem() {
                      Column() {
                        Stack({alignContent: Alignment.BottomEnd}) {
                          if (this.itemSelect.includes(item)) {
                            Row() {
                              Text(String((this.itemSelect[0] == item ? 1:0)+(this.itemSelect[1] == item ? 1:0)+(this.itemSelect[2] == item ? 1:0)))
                                .fontSize(11)
                                .fontColor(Color.White)
                            }
                            .height(11)
                            .width(11)
                            .justifyContent(FlexAlign.Center)
                            .backgroundColor(Color.Black)
                            .zIndex(1)
                          }
                          Image(items[item].icon)
                            .height(30)
                            .width(30)
                            .backgroundColor('#232341')
                        }
                        .margin(5)
                        .padding(1)
                        .borderRadius(3)
                        .borderWidth(2)
                        .borderColor(this.itemSelect.includes(item) ? '#9370DB' : '#778899')
                        .onClick(() => {
                          if (this.itemSelect.length === 3) {
                            this.itemSelect.splice(0, 1)
                          }
                          this.itemSelect.push(item);
                        })
                      }
                    }
                  })
                }
                .columnsTemplate('1fr 1fr 1fr 1fr 1fr 1fr')
                Divider()
                  .width('100%')
                  .color('#D3D3D3')
                  .strokeWidth(0.5)
              }

            }
            .tabBar(this.tabBuilder(index, name))
          })
        }
        .barMode(BarMode.Scrollable)

        Divider()
          .width('100%')
          .color('#D3D3D3')
          .strokeWidth(0.5)
      }
      .height('82%')

      Row() {
        Button('全部移除')
          .width("50%")
          .fontSize(15)
          .fontColor(Color.Black)
          .backgroundColor(Color.White)
          .type(ButtonType.Normal)
          .onClick(() => {
            this.itemSelect = [];
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
            this.controller?.close();
          })
      }
      .width('100%')
    }
    .height('55%')
    .width('90%')
    .borderRadius(3)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(Color.White)
  }
}