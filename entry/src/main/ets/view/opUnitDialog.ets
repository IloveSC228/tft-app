import { items } from '../viewmodel/itemData';
import { unitIcons, units, unitsAll } from '../viewmodel/unitData';
import { addItemDialog } from './addItemDialog';
@CustomDialog
export struct opUnitDialog {
  confirm?: (name: string, itemSelect: Array<string>) => void;
  @Link opUnit: string;
  @Consume itemSelect: Array<string>;
  addItemDialogController: CustomDialogController = new CustomDialogController({
    builder: addItemDialog({}),
    alignment: DialogAlignment.Center,
    customStyle: true,
  })
  controller?: CustomDialogController;

  build() {
    Column() {
      Column() {
        Row() {
          Image(unitIcons[this.opUnit])
            .width(40)
            .height(40)
            .margin({left: 15, right: 15})
          Text(this.opUnit)
            .fontSize(19)
            .fontWeight(400)
            .margin({ top: 10, bottom: 5 })
        }
        .width('100%')
        .margin(10)
        .justifyContent(FlexAlign.Start)

        Row() {
          Text('选择装备')
            .fontSize(17)
        }
        .width('100%')
        .margin({left: 10})
        .justifyContent(FlexAlign.Start)

        Grid() {
          ForEach([0,1,2], (id: number) => {
            GridItem() {
              Stack({alignContent: Alignment.TopEnd}) {
                if (this.itemSelect.length > id) {
                  Column() {
                    // 删除当前
                    Image($r('app.media.deleteOne'))
                      .height(13)
                      .width(13)
                      .offset({ x: 5, y: -5 })
                  }
                  .zIndex(1)
                }
                Image(this.itemSelect.length > id ? items[this.itemSelect[id]].icon : $r('app.media.addSquare'))
                  .height(35)
                  .width(35)
                  .borderRadius(3)
                  .margin({left: 15})
                  .onClick(() => {
                    if (this.itemSelect.length > id) {
                      this.itemSelect.splice(id, 1);
                    }
                    else {
                      if (this.addItemDialogController != undefined) {
                        this.addItemDialogController.open();
                      }
                    }
                  })
              }
            }
            .margin({bottom: 10})
          })
        }
        .height('49%')
        .rowsTemplate('1fr')

        Divider()
          .width('100%')
          .color('#D3D3D3')
          .strokeWidth(0.5)
      }
      .width('100%')
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
            this.itemSelect = [];
            this.confirm && this.confirm(this.opUnit, this.itemSelect);
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
            this.confirm && this.confirm(this.opUnit, this.itemSelect);
            this.controller?.close();
          })
      }
      .width('100%')
    }
    .height('23%')
    .width('70%')
    .borderRadius(8)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(Color.White)
  }
}