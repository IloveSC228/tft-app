import { pro, race } from '../viewmodel/traitData';
@CustomDialog
export struct tuiJianDialog {
  controller?: CustomDialogController;
  @Link chooseText: string;
  confirm?: (unitSearch: string) => void;

  build() {
    Column() {
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
                .fontColor(this.chooseText === '筛选' || this.chooseText.includes('全部') ? Color.White : Color.Black)
            }
          }
          .borderRadius(2)
          .borderWidth(1)
          .borderColor('#778899')
          .backgroundColor(this.chooseText === '筛选' || this.chooseText.includes('全部') ? Color.Black : Color.White)
          .onClick(() => {
            this.chooseText = '种族 | 全部';
          })

          ForEach(race, (item: string) => {
            GridItem() {
              Row() {
                Text(item)
                  .fontSize(13)
                  .fontColor(this.chooseText == item ? Color.White : Color.Black)
              }
            }
            .borderRadius(2)
            .borderWidth(1)
            .borderColor('#778899')
            .backgroundColor(this.chooseText == item ? Color.Black : Color.White)
            .onClick(() => {
              this.chooseText = item;
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
                .fontColor(this.chooseText === '筛选' || this.chooseText.includes('全部') ? Color.White : Color.Black)
            }
          }
          .borderRadius(2)
          .borderWidth(1)
          .borderColor('#778899')
          .backgroundColor(this.chooseText === '筛选' || this.chooseText.includes('全部') ? Color.Black : Color.White)
          .onClick(() => {
            this.chooseText = '职业 | 全部';
          })
          ForEach(pro, (item: string) => {
            GridItem() {
              Row() {
                Text(item)
                  .fontSize(13)
                  .fontColor(this.chooseText == item ? Color.White : Color.Black)
              }
            }
            .borderRadius(2)
            .borderWidth(1)
            .borderColor('#778899')
            .backgroundColor(this.chooseText == item ? Color.Black : Color.White)
            .onClick(() => {
              this.chooseText = item;
            })
          })
        }
        .height('25%')
        .margin({bottom: 40})
        .columnsTemplate('1fr 1fr 1fr')
        .rowsTemplate('1fr 1fr 1fr 1fr 1fr')
        .columnsGap(10)
        .rowsGap(15)
      }

      Row() {
        Button('重置')
          .width('45%')
          .fontColor(Color.White)
          .backgroundColor('#A9A9A9')
          .borderRadius(2)
          .type(ButtonType.Normal)
          .onClick(() => {
            this.chooseText = '筛选'
          })
        Button('确定')
          .width('45%')
          .fontColor(Color.White)
          .backgroundColor(Color.Black)
          .type(ButtonType.Normal)
          .borderRadius(2)
          .onClick(() => {
            this.confirm && this.confirm(this.chooseText);
            this.controller?.close();
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .height('100%')
    .width('80%')
    .padding({top: 50, left: 20, right: 20})
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(Color.White)
  }
}