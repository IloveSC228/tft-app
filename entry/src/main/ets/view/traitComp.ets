import { pro, race, traitIconsB, traits } from '../viewmodel/traitData';
import { unitIcons } from '../viewmodel/unitData';
import { traitDialog } from './traitDialog';

@Component
export struct traitComp {
  @Link traitIndex: number;
  @Link traitShow: Array<string>;
  @State traitClick: string = '';
  traitDialogController: CustomDialogController = new CustomDialogController({
    builder: traitDialog({
      trait: $traitClick
    }),
    alignment: DialogAlignment.Bottom,
    offset: { dx: 0, dy: 0 },
    gridCount: 4,
    customStyle: true
  })

  aboutToAppear() {
    this.traitShow = race;
  }

  build() {
    Column() {
      Row() {
        Button('种族')
          .width(65)
          .height(25)
          .fontSize(12)
          .fontColor(this.traitIndex === 0 ? '#FFFFFF' : '#182431')
          .opacity(this.traitIndex === 0 ? 1 : 0.8)
          .backgroundColor(this.traitIndex === 0 ? '#182431' : '#FFFFFF')
          .border({width: 1, color: '#A9A9A9', radius: 12, style: BorderStyle.Solid})
          .margin({left: 12, right: 3})
          .onClick(() => {
            this.traitIndex = 0;
            this.traitShow = race;
          })
        Button('职业')
          .width(65)
          .height(25)
          .fontSize(12)
          .fontColor(this.traitIndex === 1 ? '#FFFFFF' : '#182431')
          .opacity(this.traitIndex === 1 ? 1 : 0.8)
          .backgroundColor(this.traitIndex === 1 ? '#182431' : '#FFFFFF')
          .border({width: 1, color: '#A9A9A9', radius: 12, style: BorderStyle.Solid})
          .margin({right: 3})
          .onClick(() => {
            this.traitIndex = 1;
            this.traitShow = pro;
          })
      }
      .height(40)
      .width('100%')
      .backgroundColor(Color.White)
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)

      List() {
        ForEach(this.traitShow, (item: string) => {
          ListItem() {
            Column() {
              Row() {
                Column() {
                  Row() {
                    Image(traitIconsB[item])
                      .width(35)
                      .height(35)
                      .margin({right: 5})
                    Text(item)
                      .fontSize(18)
                  }
                  .margin({bottom: 8})
                  Row() {
                    Text(traits[item].sEffect)
                      .fontSize(13)
                      .opacity(0.7)
                  }
                  .padding({left: 10, right: 10})
                }
                .width('55%')
                .alignItems(HorizontalAlign.Start)
                Flex({justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap}) {
                  ForEach(traits[item].units, (item: string) => {
                    Image(unitIcons[item])
                      .width(30)
                      .height(30)
                      .borderRadius(20)
                      .margin(5)
                  })
                }
                .width('45%')
              }
              .width('100%')
              .padding({bottom: 10})
              .justifyContent(FlexAlign.Start)
              .alignItems(VerticalAlign.Center)
              .onClick(() => {
                this.traitClick = item;
                if (this.traitDialogController != undefined) {
                  this.traitDialogController.open();
                }
              })
              Divider()
                .width('100%')
                .color('#D3D3D3')
                .strokeWidth(0.5)
            }
            .width('100%')
          }
          .margin({bottom: 10})
        })
      }
      .height('85%')
      .margin({top: 10})
    }
    .height('100%')
    .width('100%')
    .justifyContent(FlexAlign.Start)
  }
}