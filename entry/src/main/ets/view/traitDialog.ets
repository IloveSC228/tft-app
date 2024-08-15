import { traitIconsB, traits } from '../viewmodel/traitData';
@CustomDialog
export struct traitDialog {
  controller?: CustomDialogController;
  @Link trait: string;

  build(){
    Column() {
      Row() {
        Image(traitIconsB[this.trait])
          .height(40)
          .width(40)
          .margin({right: 15})
        Text(this.trait)
          .fontSize(25)
          .fontWeight(350)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      Row() {
        Text(traits[this.trait].sEffect)
          .fontSize(16)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .margin({top: 15, bottom: 10})
      ForEach(traits[this.trait].cnt, (item: number) => {
        Row() {
          Row() {
            Text(String(item))
              .fontSize(item < 10 ? 16 : 14)
              .fontColor(Color.White)
          }
          .width(17)
          .height(17)
          .margin({right: 10})
          .backgroundColor(Color.Black)
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)

          Text(traits[this.trait].effect[item])
            .fontSize(17)
        }
        .width('100%')
        .margin({bottom: 15})
        .justifyContent(FlexAlign.Start)
      })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
    .padding(40)
    .justifyContent(FlexAlign.Start)
    .backgroundColor(Color.White)
    .borderRadius(12)
  }
}