import { unit } from '../model/unit';
import { augComp } from '../view/augComp';
import { itemComp } from '../view/itemComp';
import { traitComp } from '../view/traitComp';
import { unitComp } from '../view/unitComp';
import { units } from '../viewmodel/unitData';
import { baseItems } from '../viewmodel/itemData';
import { race } from '../viewmodel/traitData';
import { silverAug } from '../viewmodel/augmentData';

@Component
export default struct ziIndex {
  private tabController = new TabsController();
  @State currentIndex: number = 0; // tab的下标
  // 棋子
  @State unitsShow: Array<unit> = []; // 显示的棋子
  @State sort: number = 0; // 0是消耗升序，1是消耗降序，2是英雄首字母升序，3是英雄首字母降序
  @State unitChangeValue: string = ""; // 棋子搜索
  @State unitSubmitValue: string = ""; // 棋子搜索
  @Provide unitSearch: string | number = "全部"; // 由于是在子组件里使用，所以是要用provide

  // 装备
  @State itemCurrentIndex: number = 0; // 装备tab的下标
  @State baseIndex: string = ''; // 基础装备中tab的下标
  @State baseItemShow: Array<string> = []; // 基础装备的显示
  @State itemShow: Array<string> = []; // 基础装备之外的显示
  @State itemChangeValue: string = ""; // 装备搜索
  @State itemSubmitValue: string = ""; // 装备搜索

  // 羁绊
  @State traitIndex: number = 0; // 下标
  @State traitShow: Array<string> = []; // 显示的羁绊

  // 强化符文
  @State augIndex: number = 0; // 下标
  @State augShow: Array<string> = []; // 显示的强化符文

  aboutToAppear() {
  }

  // tabBar 自定义类型
  @Builder tabBuilder(index: number, name: string) {
    Column() {
      Text(name)
        .fontColor('#182431')
        .fontSize(this.currentIndex === index ? 17 : 16)
        .opacity(this.currentIndex === index ? 1 : 0.5)
        .fontWeight(this.currentIndex === index ? 600 : 500)
        .lineHeight(18)
      Divider()
        .strokeWidth(2)
        .width(10)
        .color('#182431')
        .opacity(this.currentIndex === index ? 1 : 0)
    }
    .width('100%')
    .onClick(() => {
      this.currentIndex = index;
      this.tabController.changeIndex(this.currentIndex);
      // 棋子
      this.unitsShow = units;
      this.sort = 0;
      this.unitChangeValue = "";
      this.unitSubmitValue = "";
      this.unitSearch = "全部";
      // 装备
      this.itemCurrentIndex = 0;
      this.baseIndex = '';
      this.baseItemShow = baseItems;
      this.itemShow = [];
      this.itemChangeValue = "";
      this.itemSubmitValue = "";
      // 羁绊
      this.traitIndex = 0;
      this.traitShow = race;
      // 强化符文
      this.augIndex = 0;
      this.augShow = silverAug;
    })
  }

  build() {
    Column() {
      Row() {
        Text('资料库')
          .fontSize(17)
          .fontFamily('HarmonyHeiTi-Bold')
          .fontWeight(600)
      }
      .height(40)
      .backgroundColor('#E6E6FA')
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .width('100%')
      Divider()
        .width('100%')
        .color('#D3D3D3')
        .strokeWidth(0.5)
      Column() {
        Tabs({ barPosition: BarPosition.Start, controller: this.tabController }) {
          TabContent() {
            unitComp({
              sort: $sort,
              unitsShow: $unitsShow,
              unitChangeValue: $unitChangeValue,
              unitSubmitValue: $unitSubmitValue
            })
          }
          .tabBar(this.tabBuilder(0, '英雄'))
          TabContent() {
            itemComp({
              itemCurrentIndex: $itemCurrentIndex,
              baseIndex: $baseIndex,
              baseItemShow: $baseItemShow,
              itemShow: $itemShow,
              itemChangeValue: $itemChangeValue,
              itemSubmitValue: $itemSubmitValue
            })
          }
          .tabBar(this.tabBuilder(1, '装备'))
          TabContent() {
            traitComp({
              traitIndex: $traitIndex,
              traitShow: $traitShow
            })
          }
          .tabBar(this.tabBuilder(2, '羁绊'))
          TabContent() {
            augComp({
              augIndex: $augIndex,
              augShow: $augShow
            })
          }
          .tabBar(this.tabBuilder(3, '强化符文'))
        }
        .scrollable(false)
        .width('100%')
        .height('100%')
        .barWidth('94%')
        .barMode(BarMode.Fixed)
        .vertical(false)
      }
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#E6E6FA')
  }
}