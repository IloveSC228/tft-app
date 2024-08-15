import { augs, goldAug, prismaticAug, silverAug } from '../viewmodel/augmentData';
@Component
export struct augComp {
  @Link augIndex: number;
  @Link augShow: Array<string>;

  aboutToAppear() {
    this.augShow = silverAug;
  }

  build() {
    Column() {
      Row() {
        Button('白银')
          .width(65)
          .height(25)
          .fontSize(12)
          .fontColor(this.augIndex === 0 ? '#FFFFFF' : '#182431')
          .opacity(this.augIndex === 0 ? 1 : 0.8)
          .backgroundColor(this.augIndex === 0 ? '#182431' : '#FFFFFF')
          .border({width: 1, color: '#A9A9A9', radius: 12, style: BorderStyle.Solid})
          .margin({left: 12, right: 3})
          .onClick(() => {
            this.augIndex = 0;
            this.augShow = silverAug;
          })
        Button('黄金')
          .width(65)
          .height(25)
          .fontSize(12)
          .fontColor(this.augIndex === 1 ? '#FFFFFF' : '#182431')
          .opacity(this.augIndex === 1 ? 1 : 0.8)
          .backgroundColor(this.augIndex === 1 ? '#182431' : '#FFFFFF')
          .border({width: 1, color: '#A9A9A9', radius: 12, style: BorderStyle.Solid})
          .margin({right: 3})
          .onClick(() => {
            this.augIndex = 1;
            this.augShow = goldAug;
          })
        Button('棱彩')
          .width(65)
          .height(25)
          .fontSize(12)
          .fontColor(this.augIndex === 2 ? '#FFFFFF' : '#182431')
          .backgroundColor(this.augIndex === 2 ? '#182431' : '#FFFFFF')
          .border({width: 1, color: '#A9A9A9', radius: 12, style: BorderStyle.Solid})
          .opacity(this.augIndex === 2 ? 1 : 0.8)
          .onClick(() => {
            this.augIndex = 2;
            this.augShow = prismaticAug;
          })
      }
      .height(40)
      .width('100%')
      .backgroundColor(Color.White)
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)

      List() {
        ForEach(this.augShow, (item: string) => {
          ListItem() {
            Column() {
              Row() {
                Image(augs[item].icon)
                  .width(37)
                  .height(37)
                  .backgroundColor(Color.Black)
                  .margin({left: 15})
                  .borderRadius(3)
                Text(item)
                  .fontSize(16)
                  .fontWeight(350)
                  .margin({left: 10})
              }
              .width('100%')
              .margin({top: 15})
              .justifyContent(FlexAlign.Start)
              .alignItems(VerticalAlign.Center)
              Row() {
                Column() {
                  Text('效果')
                    .fontSize(13)
                  Text(augs[item].effect)
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
          .backgroundColor(Color.White)
          .margin({bottom: 10})

        })
      }
      .height('85%')
      .backgroundColor('#F1F2F7')
      .margin({top: 10})
    }
    .height('100%')
    .width('100%')
    .justifyContent(FlexAlign.Start)
  }
}