import { pro, race } from '../viewmodel/traitData';
@CustomDialog
export struct unitDialog {
  controller?:CustomDialogController;
  @Consume unitSearch: string | number;
  confirm?: (unitSearch: string | number) => void;

  build() {
    Column() {
      Row() {
        Text('种族')
          .fontSize(15)
          .opacity(0.7)
      }
      .justifyContent(FlexAlign.Start)
      .width('100%')
      .margin({bottom: 20})
      Grid() {
        GridItem() {
          Row() {
            Text('全部')
              .fontSize(13)
              .fontColor(this.unitSearch === '全部' ? Color.White : Color.Black)
          }
        }
        .borderRadius(2)
        .borderWidth(1)
        .borderColor('#778899')
        .backgroundColor(this.unitSearch === '全部' ? Color.Black : Color.White)
        .onClick(() => {
          this.unitSearch = '全部';
        })

        ForEach(race, (item: string) => {
          GridItem() {
            Row() {
              Text(item)
                .fontSize(13)
                .fontColor(this.unitSearch === item ? Color.White : Color.Black)
            }
          }
          .borderRadius(2)
          .borderWidth(1)
          .borderColor('#778899')
          .backgroundColor(this.unitSearch === item ? Color.Black : Color.White)
          .onClick(() => {
            this.unitSearch = item;
          })
        })
      }
      .height('30%')
      .margin({bottom: 40})
      .columnsTemplate('1fr 1fr 1fr')
      .rowsTemplate('1fr 1fr 1fr 1fr 1fr 1fr')
      .columnsGap(10)
      .rowsGap(15)

      Row() {
        Text('职业')
          .fontSize(15)
          .opacity(0.7)
      }
      .justifyContent(FlexAlign.Start)
      .width('100%')
      .margin({bottom: 20})
      Grid() {
        GridItem() {
          Row() {
            Text('全部')
              .fontSize(13)
              .fontColor(this.unitSearch === '全部' ? Color.White : Color.Black)
          }
        }
        .borderRadius(2)
        .borderWidth(1)
        .borderColor('#778899')
        .backgroundColor(this.unitSearch === '全部' ? Color.Black : Color.White)
        .onClick(() => {
          this.unitSearch = '全部';
        })
        ForEach(pro, (item: string) => {
          GridItem() {
            Row() {
              Text(item)
                .fontSize(13)
                .fontColor(this.unitSearch === item ? Color.White : Color.Black)
            }
          }
          .borderRadius(2)
          .borderWidth(1)
          .borderColor('#778899')
          .backgroundColor(this.unitSearch === item ? Color.Black : Color.White)
          .onClick(() => {
            this.unitSearch = item;
          })
        })
      }
      .height('25%')
      .margin({bottom: 40})
      .columnsTemplate('1fr 1fr 1fr')
      .rowsTemplate('1fr 1fr 1fr 1fr 1fr')
      .columnsGap(10)
      .rowsGap(15)

      Row() {
        Text('价格')
          .fontSize(15)
          .opacity(0.7)
      }
      .justifyContent(FlexAlign.Start)
      .width('100%')
      .margin({bottom: 20})
      Grid() {
        GridItem() {
          Row() {
            Text('全部')
              .fontSize(13)
              .fontColor(this.unitSearch === '全部' ? Color.White : Color.Black)
          }
        }
        .borderRadius(2)
        .borderWidth(1)
        .borderColor('#778899')
        .backgroundColor(this.unitSearch === '全部' ? Color.Black : Color.White)
        .onClick(() => {
          this.unitSearch = '全部';
        })
        ForEach([1, 2, 3, 4, 5], (item: number) => {
          GridItem() {
            Row() {
              Text(String(item))
                .fontSize(13)
                .fontColor(this.unitSearch === item ? Color.White : Color.Black)
            }
          }
          .borderRadius(2)
          .borderWidth(1)
          .borderColor('#778899')
          .backgroundColor(this.unitSearch === item ? Color.Black : Color.White)
          .onClick(() => {
            this.unitSearch = item;
          })
        })
      }
      .height('9%')
      .columnsTemplate('1fr 1fr 1fr')
      .rowsTemplate('1fr 1fr')
      .columnsGap(10)
      .rowsGap(15)
      .margin({bottom: 40})
      Row() {
        Button('重置')
          .width('45%')
          .fontColor(Color.White)
          .backgroundColor('#A9A9A9')
          .borderRadius(2)
          .type(ButtonType.Normal)
          .onClick(() => {
            this.unitSearch = '全部'
          })
        Button('确定')
          .width('45%')
          .fontColor(Color.White)
          .backgroundColor(Color.Black)
          .type(ButtonType.Normal)
          .borderRadius(2)
          .onClick(() => {
            this.confirm && this.confirm(this.unitSearch);
            this.controller?.close();
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .height('100%')
    .width('80%')
    .padding({top: 50, left: 20, right: 20})
    .backgroundColor(Color.White)
  }
}