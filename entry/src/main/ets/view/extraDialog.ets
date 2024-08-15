import { unitIcons } from '../viewmodel/unitData';
@CustomDialog
export struct extraDialog {
  @Link unitSelect: Array<string>;
  @Link unitExtra: string;
  controller?: CustomDialogController;
  confirm?: (unitExtra: string) => void;
  @State preExtra: string = "";

  aboutToAppear() {
    this.preExtra = this.unitExtra;
  }

  build() {
    Column() {
      Grid() {
        ForEach(this.unitSelect, (item: string) => {
          GridItem() {
            Image(unitIcons[item])
              .height(40)
              .width(40)
              .margin(10)
              .borderRadius(3)
              .borderColor(this.unitExtra == item ? '#9370DB' : Color.White)
              .margin({bottom: 10})
              .onClick(() => {
                this.unitExtra = item;
              })
          }
          .margin({left: 10})
        })
      }
      .columnsTemplate('1fr 1fr 1fr 1fr 1fr')
      Column() {
        Divider()
          .width('100%')
          .color('#D3D3D3')
          .strokeWidth(0.5)
        Row() {
          Button('取消')
            .width("50%")
            .fontSize(15)
            .fontColor(Color.Black)
            .backgroundColor(Color.White)
            .type(ButtonType.Normal)
            .onClick(() => {
              this.unitExtra = this.preExtra;
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
              this.confirm && this.confirm(this.unitExtra);
              this.controller?.close();
            })
        }
        .width('100%')
      }
      .width('100%')
    }
    .width('65%')
    .height('20%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({ top: 10 })
    .backgroundColor(Color.White)
  }
}