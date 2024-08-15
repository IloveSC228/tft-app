import { baseToCraft, items } from '../viewmodel/itemData';
@CustomDialog
export struct itemDialog {
  controller?: CustomDialogController;
  @Link itemClick: string;

  build(){
    Column() {
      List() {
        ForEach(baseToCraft[this.itemClick], (name: string) => {
          ListItem() {
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
                }
                .width('100%')
                .margin({top: 15})
                .justifyContent(FlexAlign.Start)
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
        })
      }
      .height('100%')
      .width('100%')
    }
    .height('100%')
    .width('77%')
    .alignItems(HorizontalAlign.Center)
    .padding({top: 10, bottom: 10, left: 5, right: 5})
    .justifyContent(FlexAlign.Start)
    .backgroundColor(Color.White)
    .borderRadius(12)
  }
}