import tuiIndex from './tuiJianZhenRong';
import ziIndex from './ziLiaoKu';
import woIndex from './woDeZhenRong';
import { tabId, tabList } from '../model/tabItem';
import { comp } from '../model/comp';
import { tuiJianComp } from '../viewmodel/compData';
@Entry
@Component
struct mainPage {
  @State currentPage: number = 0;
  private tabController: TabsController = new TabsController();

  @State compShow: Array<comp> = [];

  aboutToAppear() {
    this.compShow = tuiJianComp;
  }

  onPageShow() {}

  @Builder TabBuilder(index: number) {
    Column() {
      Image(tabList[index].icon)
        .width(this.currentPage === index ? 35 : 30)
        .height(this.currentPage === index ? 35 : 30)
        .objectFit(ImageFit.Contain);
      Text(tabList[index].text)
        .fontSize(10)
        .fontWeight(500)
        .fontColor(this.currentPage === index ? "#007DFF" : "#999")
        .margin({top: 4})
    }
    .justifyContent(FlexAlign.Start)
    .width('100%')
    .height('100%')
    .onClick(() => {
      this.currentPage = index;
      this.tabController.changeIndex(this.currentPage);
    })
  }

  build() {
    Tabs({ barPosition: BarPosition.End, controller: this.tabController }) {
      TabContent() {
        tuiIndex({compShow: $compShow})
          .borderWidth({ bottom: 1 })
          .borderColor("#F1F3F5")
      }
      .tabBar(this.TabBuilder(tabId.tuiJianZhenRong))
      .align(Alignment.Start)

      TabContent() {
        ziIndex()
      }
      .tabBar(this.TabBuilder(tabId.ziLiaoKu))
      .align(Alignment.Start)

      TabContent() {
        woIndex()
          .borderWidth({ bottom: 1 })
          .borderColor("#F1F3F5")
      }
      .tabBar(this.TabBuilder(tabId.woDeZhenRong))
    }
    .scrollable(false)
    .width('100%')
    .height('100%')
    .barWidth('94%')
    .barMode(BarMode.Fixed)
    .vertical(false)
  }
}