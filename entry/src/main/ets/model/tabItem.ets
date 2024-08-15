export interface tabItem {
  icon: Resource;
  text: string;
  id: number;
}

// tabId
export enum tabId {
  tuiJianZhenRong,
  ziLiaoKu,
  woDeZhenRong
}

export const tabList: tabItem[] = [
  {
    icon: $r('app.media.tuiJianZhenRong'),
    text: "推荐阵容",
    id: tabId.tuiJianZhenRong
  },
  {
    icon: $r('app.media.ziLiaoKu'),
    text: "资料库",
    id: tabId.ziLiaoKu
  },
  {
    icon: $r('app.media.woDeZhenRong'),
    text: "我的阵容",
    id: tabId.woDeZhenRong
  },
]