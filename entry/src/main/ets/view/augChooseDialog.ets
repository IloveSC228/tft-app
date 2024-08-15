import { augs, goldAug, prismaticAug, silverAug } from '../viewmodel/augmentData';
@CustomDialog
export struct augChooseDialog {
  controller?: CustomDialogController;
  maxCnt: number; // 最大可选符文数
  @Link augmentSelect: Array<string>;
  confirm?: () => void;
  private searchController: SearchController = new SearchController();
  @State changeValue: string = "";
  @State submitValue: string = "";
  @State augShow: Array<string> = [];
  private tabsController: TabsController = new TabsController();
  @State currentIndex: number = 0;

  aboutToAppear() {
    this.augShow = silverAug;
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
        this.augShow = silverAug;
      else if (this.currentIndex === 1)
        this.augShow = goldAug;
      else if (this.currentIndex === 2)
        this.augShow = prismaticAug;
    })
  }

  build() {
    Column() {
      Column() {
        Row() {
          Text('强化符文')
            .fontSize(19)
            .fontWeight(400)
            .margin({ top: 10, bottom: 5})
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        Divider()
          .width('100%')
          .color('#D3D3D3')
          .strokeWidth(0.5)

        Search({ value: this.changeValue, placeholder: '搜索', controller: this.searchController })
          .searchButton('搜索')
          .width('100%')
          .height(40)
          .backgroundColor('#F1F2F7')
          .placeholderColor(Color.Grey)
          .placeholderFont({ size: 14, weight: 400 })
          .textFont({ size: 14, weight: 400 })
          .onChange((value: string) => {
            this.changeValue = value;
            if (this.submitValue != "" && this.changeValue == "") {
              this.submitValue = "";
              if (this.currentIndex === 0)
                this.augShow = silverAug;
              else if (this.currentIndex === 1)
                this.augShow = goldAug;
              else if (this.currentIndex === 2)
                this.augShow = prismaticAug;
            }
          })
          .onSubmit((value: string) => {
            this.submitValue = value;
            if (this.submitValue != '') {
              this.augShow = [];
              for (let i = 0; i < silverAug.length; i++) {
                if (silverAug[i].includes(this.submitValue))
                  this.augShow.push(silverAug[i]);
              }
              for (let i = 0; i < goldAug.length; i++) {
                if (goldAug[i].includes(this.submitValue))
                  this.augShow.push(goldAug[i]);
              }
              for (let i = 0; i < prismaticAug.length; i++) {
                if (prismaticAug[i].includes(this.submitValue))
                  this.augShow.push(prismaticAug[i]);
              }
            }
            else {
              if (this.currentIndex === 0)
                this.augShow = silverAug;
              else if (this.currentIndex === 1)
                this.augShow = goldAug;
              else if (this.currentIndex === 2)
                this.augShow = prismaticAug;
            }
          })
          .onChange((value: string) => {
            this.changeValue = value;
          })
          .margin(5)

        if (this.submitValue == "") {
          Tabs({ barPosition: BarPosition.Start, controller: this.tabsController }) {
            ForEach(['白银','黄金','棱彩'], (name: string, index) => {
              TabContent() {
                Grid() {
                  ForEach(this.augShow, (aug: string) => {
                    GridItem() {
                      Column() {
                        Column() {
                          Image(augs[aug].icon)
                            .height(27)
                            .width(27)
                            .borderRadius(20)
                            .backgroundColor('#232341')
                        }
                        .margin(5)
                        .padding(1)
                        .borderRadius(20)
                        .borderWidth(2)
                        .borderColor(this.augmentSelect.includes(aug) ? '#9370DB' : '#778899')
                        .onClick(() => {
                          if (!this.augmentSelect.includes(aug)) {
                            if (this.augmentSelect.length === this.maxCnt) {
                              this.augmentSelect.splice(0, 1)
                            }
                            this.augmentSelect.push(aug);
                          }
                        })
                        Text(aug)
                          .fontSize(11)
                      }
                    }
                  })
                }
                .columnsTemplate('1fr 1fr 1fr 1fr 1fr')
              }
              .tabBar(this.tabBuilder(index, name))
            })
          }
        }
        else {
          Grid() {
            ForEach(this.augShow, (aug: string) => {
              GridItem() {
                Column() {
                  Column() {
                    Image(augs[aug].icon)
                      .height(27)
                      .width(27)
                      .backgroundColor('#232341')
                      .borderRadius(20)
                  }
                  .margin(5)
                  .padding(2)
                  .borderRadius(20)
                  .borderWidth(2)
                  .borderColor(this.augmentSelect.includes(aug) ? '#F1F2F7' : '#778899')
                  .onClick(() => {
                    if (!this.augmentSelect.includes(aug)) {
                      this.augmentSelect.push(aug);
                    }
                  })
                  Text(aug)
                    .fontSize(11)
                }
              }
            })
          }
          .columnsTemplate('1fr 1fr 1fr 1fr 1fr')
        }
        Divider()
          .width('100%')
          .color('#D3D3D3')
          .strokeWidth(0.5)
      }
      .height('74%')
      .justifyContent(FlexAlign.Start)
      Row() {
        Button('全部移除')
          .width("50%")
          .fontSize(15)
          .fontColor(Color.Black)
          .backgroundColor(Color.White)
          .type(ButtonType.Normal)
          .onClick(() => {
            this.augmentSelect = [];
            this.confirm && this.confirm();
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
            this.confirm && this.confirm();
            this.controller?.close();
          })
      }
      .width('100%')
    }
    .height('60%')
    .width('90%')
    .borderRadius(3)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(Color.White)
  }
}