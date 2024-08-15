import { traitIconsB } from '../viewmodel/traitData';
import { unit } from '../model/unit';
import { units } from '../viewmodel/unitData';
import { unitDialog } from './unitDialog';

@Component
export struct unitComp {
  // 棋子搜索
  @Link unitChangeValue: string;
  @Link unitSubmitValue: string;
  private unitSearchController: SearchController = new SearchController();
  @Consume unitSearch: string | number;
  // 棋子排序
  @Link sort: number; // 0是消耗升序，1是消耗降序，2是英雄首字母升序，3是英雄首字母降序
  // 用于展示棋子，会因为查询而变动
  @Link unitsShow: unit[];

  unitDialogController: CustomDialogController = new CustomDialogController({
    builder: unitDialog({
      confirm: (unitSearch: string | number) => {
        if (unitSearch === '全部')
          this.unitsShow = units;
        else {
          this.unitsShow = [];
          for (let i = 0; i < units.length; i++) {
            if (units[i].race === unitSearch ||
            (typeof unitSearch === 'string' && units[i].pro.includes(unitSearch))
            || units[i].cost === unitSearch)
              this.unitsShow.push(units[i]);
          }
        }
      }
    }),
    alignment: DialogAlignment.CenterEnd,
    customStyle: true,
  })

  aboutToAppear() {
    // 棋子初始化
    this.unitsShow = units;
  }

  // 棋子排序
  sortUnits(units: Array<unit>) {
    if (this.sort === 0) {
      this.unitsShow = units.slice().sort((unitA, unitB) => unitA.cost - unitB.cost);
    }
    else if (this.sort === 1) {
      this.unitsShow = units.slice().sort((unitA, unitB) => unitB.cost - unitA.cost);
    }
    else if (this.sort === 2) {
      this.unitsShow = units.slice().sort((unitA, unitB) => unitA.namePin.localeCompare(unitB.namePin));
    }
    else if (this.sort === 3) {
      this.unitsShow = units.slice().sort((unitA, unitB) => unitB.namePin.localeCompare(unitA.namePin));
    }
  }

  build() {
    Column() {
      Row() {
        Search({ value: this.unitChangeValue, placeholder: '搜索英雄姓名', controller: this.unitSearchController })
          .searchButton('搜索')
          .width('85%')
          .height(40)
          .backgroundColor('#F1F2F7')
          .placeholderColor(Color.Grey)
          .placeholderFont({ size: 14, weight: 400 })
          .textFont({ size: 14, weight: 400 })
          .onSubmit((value: string) => {
            this.unitSubmitValue = value;
            this.unitsShow = [];
            for (let i = 0; i < units.length; i++) {
              if (units[i].name.includes(this.unitSubmitValue))
                this.unitsShow.push(units[i]);
            }
          })
          .onChange((value: string) => {
            this.unitChangeValue = value;
          })
          .margin(5)
        Button() {
          Image($r("app.media.filter"))
            .opacity(0.7)
        }
        .width(25)
        .height(25)
        .margin({right: 10})
        .backgroundColor(Color.White)
        .onClick(() => {
          if (this.unitDialogController != undefined)
            this.unitDialogController.open();
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      Grid() {
        GridItem() {
          Row() {
            Text('英雄')
              .fontSize(14)
              .fontWeight(400)
              .opacity(0.5)
            Button() {
              Image(this.sort === 2 ? $r('app.media.sortAsc') : (this.sort === 3 ? $r('app.media.sortDesc') : $r('app.media.sortN')))
                .width(17)
                .height(14)
                .backgroundColor('#F1F2F7')
            }
            .onClick(() => {
              if (this.sort === 0 || this.sort === 1)
                this.sort = 2;
              else if (this.sort === 2)
                this.sort = 3;
              else if (this.sort === 3)
                this.sort = 2;
              this.sortUnits(this.unitsShow);
            })
          }
          .width('100%')
          .margin({top: 5, left: 10})
          .justifyContent(FlexAlign.Start)
        }
        GridItem() {
          Row() {
            Text('种族')
              .fontSize(14)
              .fontWeight(400)
              .opacity(0.5)
          }
          .width('100%')
          .margin({top: 5})
          .justifyContent(FlexAlign.Start)
        }
        GridItem() {
          Row() {
            Text('职业')
              .fontSize(14)
              .fontWeight(400)
              .opacity(0.5)
          }
          .width('100%')
          .margin({top: 5})
          .justifyContent(FlexAlign.Start)
        }
        GridItem() {
          Row() {
            Text('消耗')
              .fontSize(14)
              .fontWeight(400)
              .opacity(0.5)
            Button() {
              Image(this.sort === 0 ? $r('app.media.sortAsc') : (this.sort === 1 ? $r('app.media.sortDesc') : $r('app.media.sortN')))
                .width(17)
                .height(14)
                .backgroundColor('#F1F2F7')
            }
            .onClick(() => {
              if (this.sort === 2 || this.sort === 3)
                this.sort = 0;
              else if (this.sort === 0)
                this.sort = 1;
              else if (this.sort === 1)
                this.sort = 0;
              this.sortUnits(this.unitsShow);
            })
          }
          .width('100%')
          .margin({top: 5})
          .justifyContent(FlexAlign.Start)
        }
      }
      .height(28)
      .columnsTemplate('8fr 5fr 5fr 3fr')
      .margin({top: 10})
      .backgroundColor('#F1F2F7')
      Grid() {
        ForEach(this.unitsShow, (item: unit) => {
          GridItem() {
            Row() {
              Image(item.icon)
                .width(45)
                .height(45)
              Text(item.name)
                .fontSize(13)
                .margin({left: 10})
            }
            .width('100%')
            .margin({top: 15, bottom: 15, left: 10})
            .justifyContent(FlexAlign.Start)
            .alignItems(VerticalAlign.Center)
          }
          GridItem() {
            Row() {
              Image(traitIconsB[item.race])
                .width(20)
                .height(20)
              Text(item.race)
                .fontSize(13)
                .margin({left: 5})
            }
            .width('100%')
            .justifyContent(FlexAlign.Start)
            .alignItems(VerticalAlign.Center)
          }
          GridItem() {
            Column() {
              ForEach(item.pro, (item: string) => {
                Row() {
                  Image(traitIconsB[item])
                    .width(20)
                    .height(20)
                  Text(item)
                    .fontSize(13)
                    .margin({left: 5})
                }
              })
            }
            .width('100%')
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Start)
          }
          GridItem() {
            Row() {
              Text(String(item.cost))
                .fontSize(13)
            }
            .width('100%')
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)
          }
        })
      }
      .height('82%')
      .columnsTemplate('8fr 5fr 5fr 3fr')
    }
    .height('100%')
    .width('100%')
    .justifyContent(FlexAlign.Start)
  }
}