export class comp {
  name: string;
  traits: Array<string>;
  traitsCnt: Array<number>; // 所有羁绊
  traitsShow: string; // 显示出来的羁绊
  traitExtra: string; // 天选羁绊
  units: Array<string>; // 阵容中的所有弈子
  unitItem: Array<Array<string>>; // 哪些弈子用那些装备
  items: Array<string>; // 所有的成型装备
  baseItems: Record<string, number>; // 所有基础装备
  augments: Array<string>; // 强化符文，不显示，但用于查询
  musicShow: string;
}