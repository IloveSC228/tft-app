import { baseItems, items, craftableItems, emblems, radiantItems, artifacts, supportItems, itemForSearch } from '../viewmodel/itemData';

import { itemDialog } from './itemDialog';
@Component
export struct itemComp {
  private itemTabController = new TabsController();
  @Link itemCurrentIndex: number; // 装备tab的下标
  @State preIndex: number = 0;
  // 基础装备
  @Link baseIndex: string;
  @Link baseItemShow: Array<string>;
  @State itemClick: string = '';
  itemDialogController: CustomDialogController = new CustomDialogController({
    builder: itemDialog({
      itemClick: $itemClick,
    }),
    cancel: () => {
      this.itemClick = '';
    },
    alignment: DialogAlignment.CenterStart,
    customStyle: true
  })

  // 其他装备
  @Link itemShow: Array<string>;
  @Link itemChangeValue: string;
  @Link itemSubmitValue: string;
  private itemSearchController: SearchController = new SearchController();


  aboutToAppear() {
    this.baseItemShow = baseItems;
  }

  @Builder itemTabBuilder(index: number, name: string) {
    Row() {
      Text(name)
        .fontColor(this.itemCurrentIndex === index ? '#FFFFFF' : '#182431')
        .fontSize(12)
        .opacity(this.itemCurrentIndex === index ? 1 : 0.7)
        .margin({top: 3, bottom: 3})
    }
    .width(85)
    .justifyContent(FlexAlign.Center)
    .border({width: 1, color: '#DCDCDC', radius: 12, style: BorderStyle.Solid})
    .backgroundColor(this.itemCurrentIndex === index ? '#182431' : '#FFFFFF')
    .margin({left: 5, right: 5})
  }

  @Builder itemEach(name: string) {
    Column() {
      Divider()
        .width('100%')
        .color('#D3D3D3')
        .strokeWidth(1)
      Column() {
        Row() {
          Row() {
            Image(items[name].icon)
              .width(37)
              .height(37)
              .margin({left: 15})
            Text(name)
              .fontSize(16)
              .fontWeight(350)
              .margin({left: 10})
          }
          if ('compA' in items[name]) {
            Row() {
              Image(items[items[name].compA].icon)
                .width(26)
                .height(26)
              Text('+')
                .fontSize(16)
                .fontWeight(350)
                .margin({left: 5, right: 5})
              Image(items[items[name].compB].icon)
                .width(26)
                .height(26)
            }
            .margin({right: 10})
          }
          if (baseItems.includes(name)) {
            Row() {
              Text('合成装备')
                .fontSize(14)
                .fontWeight(350)
                .opacity(0.7)
                .margin({left: 5, right: 3})
              Image(this.itemClick === name ? $r('app.media.left') : $r('app.media.right'))
                .width(16)
                .height(16)
            }
            .onClick(() => {
              this.itemClick = name;
              if (this.itemDialogController != undefined)
                this.itemDialogController.open();
            })
          }
        }
        .width('100%')
        .margin({top: 15})
        .justifyContent('compA' in items[name] || baseItems.includes(name) ? FlexAlign.SpaceBetween : FlexAlign.Start)
        .alignItems(VerticalAlign.Center)
        Row() {
          Column() {
            Text('效果')
              .fontSize(13)
            Text(items[name].effect)
              .fontSize(13)
              .opacity(0.6)
          }
          .width('82%')
          .alignItems(HorizontalAlign.Start)
          .margin({ top: 10, right: 5, bottom: 15 })
        }
        .justifyContent(FlexAlign.End)
        .width('100%')
      }
      .width('100%')
    }
  }

  build() {
    Tabs({barPosition: BarPosition.Start, controller: this.itemTabController}) {
      TabContent() {
        Column() {
          Grid() {
            ForEach(baseItems, (item: string) => {
              GridItem() {
                Image(items[item].icon)
                  .height(30)
                  .width(30)
                  .borderWidth(2)
                  .margin({left: 10})
                  .borderColor(this.baseIndex === item ? '#800080' : '#778899')
                  .onClick(() => {
                    if (this.baseIndex === item) {
                      this.baseIndex = '';
                      this.baseItemShow = baseItems;
                    }
                    else {
                      this.baseIndex = item;
                      this.baseItemShow = [item];
                    }

                  })
              }
            })
          }
          .rowsTemplate('1fr')
          .height('7%')

          Divider()
            .width('100%')
            .color('#D3D3D3')
            .strokeWidth(0.5)
          List() {
            ForEach(this.baseItemShow, (item: string) => {
              ListItem() {
                this.itemEach(item)
              }
              .backgroundColor(Color.White)
              .margin({bottom: 10})
            })
          }
          .height('85%')
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Start)
      }
      .tabBar(this.itemTabBuilder(0, '基础装备'))
      TabContent() {
        Column() {
          Row() {
            Search({ value: this.itemChangeValue, placeholder: '搜索', controller: this.itemSearchController })
              .searchButton('搜索')
              .width('100%')
              .height(40)
              .backgroundColor('#F1F2F7')
              .placeholderColor(Color.Grey)
              .placeholderFont({ size: 14, weight: 400 })
              .textFont({ size: 14, weight: 400 })
              .onSubmit((value: string) => {
                this.itemSubmitValue = value;
                if (this.itemSubmitValue != '') {
                  this.itemShow = [];
                  for (let i = 0; i < itemForSearch.length; i++) {
                    if (itemForSearch[i].includes(this.itemSubmitValue))
                      this.itemShow.push(itemForSearch[i]);
                  }
                  this.itemSubmitValue = '';
                }
              })
              .onChange((value: string) => {
                this.itemChangeValue = value;
              })
              .margin(5)
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          List() {
            ForEach(this.itemShow, (item: string) => {
              ListItem() {
                this.itemEach(item)
              }
              .backgroundColor(Color.White)
              .margin({bottom: 10})
            })
          }
          .height('85%')
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Start)
      }
      .tabBar(this.itemTabBuilder(1, '合成装备'))
      TabContent() {
        Column() {
          Row() {
            Search({ value: this.itemChangeValue, placeholder: '搜索', controller: this.itemSearchController })
              .searchButton('搜索')
              .width('100%')
              .height(40)
              .backgroundColor('#F1F2F7')
              .placeholderColor(Color.Grey)
              .placeholderFont({ size: 14, weight: 400 })
              .textFont({ size: 14, weight: 400 })
              .onSubmit((value: string) => {
                this.itemSubmitValue = value;
                if (this.itemSubmitValue != '') {
                  this.itemShow = [];
                  for (let i = 0; i < itemForSearch.length; i++) {
                    if (itemForSearch[i].includes(this.itemSubmitValue))
                      this.itemShow.push(itemForSearch[i]);
                  }
                }
              })
              .onChange((value: string) => {
                this.itemChangeValue = value;
              })
              .margin(5)
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          List() {
            ForEach(this.itemShow, (item: string) => {
              ListItem() {
                this.itemEach(item)
              }
              .backgroundColor(Color.White)
              .margin({bottom: 10})
            })
          }
          .height('85%')
        }
        .width('100%')
        .height('100%')
      }
      .tabBar(this.itemTabBuilder(2, '光明装备'))
      TabContent() {
        Column() {
          Row() {
            Search({ value: this.itemChangeValue, placeholder: '搜索', controller: this.itemSearchController })
              .searchButton('搜索')
              .width('100%')
              .height(40)
              .backgroundColor('#F1F2F7')
              .placeholderColor(Color.Grey)
              .placeholderFont({ size: 14, weight: 400 })
              .textFont({ size: 14, weight: 400 })
              .onSubmit((value: string) => {
                this.itemSubmitValue = value;
                if (this.itemSubmitValue != '') {
                  this.itemShow = [];
                  for (let i = 0; i < itemForSearch.length; i++) {
                    if (itemForSearch[i].includes(this.itemSubmitValue))
                      this.itemShow.push(itemForSearch[i]);
                  }
                }
              })
              .onChange((value: string) => {
                this.itemChangeValue = value;
              })
              .margin(5)
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          List() {
            ForEach(this.itemShow, (item: string) => {
              ListItem() {
                this.itemEach(item)
              }
              .backgroundColor(Color.White)
              .margin({bottom: 10})
            })
          }
          .height('85%')
        }
        .width('100%')
        .height('100%')
      }
      .tabBar(this.itemTabBuilder(3, '转职纹章'))
      TabContent() {
        Column() {
          Row() {
            Search({ value: this.itemChangeValue, placeholder: '搜索', controller: this.itemSearchController })
              .searchButton('搜索')
              .width('100%')
              .height(40)
              .backgroundColor('#F1F2F7')
              .placeholderColor(Color.Grey)
              .placeholderFont({ size: 14, weight: 400 })
              .textFont({ size: 14, weight: 400 })
              .onSubmit((value: string) => {
                this.itemSubmitValue = value;
                if (this.itemSubmitValue != '') {
                  this.itemShow = [];
                  for (let i = 0; i < itemForSearch.length; i++) {
                    if (itemForSearch[i].includes(this.itemSubmitValue))
                      this.itemShow.push(itemForSearch[i]);
                  }
                }
              })
              .onChange((value: string) => {
                this.itemChangeValue = value;
              })
              .margin(5)
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          List() {
            ForEach(this.itemShow, (item: string) => {
              ListItem() {
                this.itemEach(item)
              }
              .backgroundColor(Color.White)
              .margin({bottom: 10})
            })
          }
          .height('85%')
        }
        .width('100%')
        .height('100%')
      }
      .tabBar(this.itemTabBuilder(4, '奥恩神器'))
      TabContent() {
        Column() {
          Row() {
            Search({ value: this.itemChangeValue, placeholder: '搜索', controller: this.itemSearchController })
              .searchButton('搜索')
              .width('100%')
              .height(40)
              .backgroundColor('#F1F2F7')
              .placeholderColor(Color.Grey)
              .placeholderFont({ size: 14, weight: 400 })
              .textFont({ size: 14, weight: 400 })
              .onSubmit((value: string) => {
                this.itemSubmitValue = value;
                if (this.itemSubmitValue != '') {
                  this.itemShow = [];
                  for (let i = 0; i < itemForSearch.length; i++) {
                    if (itemForSearch[i].includes(this.itemSubmitValue))
                      this.itemShow.push(itemForSearch[i]);
                  }
                }
              })
              .onChange((value: string) => {
                this.itemChangeValue = value;
              })
              .margin(5)
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          List() {
            ForEach(this.itemShow, (item: string) => {
              ListItem() {
                this.itemEach(item)
              }
              .backgroundColor(Color.White)
              .margin({bottom: 10})
            })
          }
          .height('85%')
        }
        .width('100%')
        .height('100%')
      }
      .tabBar(this.itemTabBuilder(5, '辅助装备'))
    }
    .vertical(false)
    .scrollable(true)
    .barMode(BarMode.Scrollable)
    .onChange((index: number) => {
      this.itemCurrentIndex = index;
      if (this.preIndex != index) {
        this.itemChangeValue = '';
        this.itemSubmitValue = '';
        this.preIndex = index;
      }
      if (this.itemChangeValue == '') {
        if (index == 0)
          this.baseItemShow = baseItems;
        else if (index == 1)
          this.itemShow = craftableItems;
        else if (index == 2)
          this.itemShow = radiantItems;
        else if (index == 3)
          this.itemShow = emblems;
        else if (index == 4)
          this.itemShow = artifacts;
        else if (index == 5)
          this.itemShow = supportItems;
      }
    })
  }
}