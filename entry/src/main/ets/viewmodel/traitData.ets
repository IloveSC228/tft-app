import { expect } from '@ohos/hypium'
import { trait } from '../model/trait'
// 白色
export const traitIcons: Record<string, Resource> = {
  '真实伤害': $r('app.media.TrueDamage'),
  '8比特': $r('app.media.8Bit'),
  'K/DA': $r('app.media.KDA'),
  'EMO': $r('app.media.Emo'),
  '电子舞曲': $r('app.media.EDM'),
  '五杀摇滚': $r('app.media.Pentakill'),
  '爵士乐': $r('app.media.Jazz'),
  '心之钢': $r('app.media.PopBand'),
  '朋克': $r('app.media.PunkRock'),
  '秘术护卫': $r('app.media.Sentinel'),
  '超级粉丝': $r('app.media.Superfan'),
  '法师': $r('app.media.Spellweaver'),
  '疾射枪手': $r('app.media.Quickshot'),
  '舞者': $r('app.media.Fighter'),
  '护卫': $r('app.media.Guardian'),
  '高能流行': $r('app.media.Hyperpop'),
  '裁决使': $r('app.media.Executioner'),
  '刀锋领主': $r('app.media.Edgelord'),
  '迪斯科': $r('app.media.Funk'),
  '乡村音乐': $r('app.media.Country'),
  '耀光使': $r('app.media.Dazzler'),
  '音浪刺客': $r('app.media.CrowdDive'),
  '格斗家': $r('app.media.Brawler'),
  '大腕射手': $r('app.media.Deadeye'),
  '双修出道': $r('app.media.Breakout'),
  'DJ娑娜': $r('app.media.DJ'),
  '戏命师': $r('app.media.Classical'),
  '大触打击乐': $r('app.media.IllBeats'),
  '影流之镰': $r('app.media.TwoSides'),
}
// 黑色
export const traitIconsB: Record<string, Resource> = {
  '真实伤害': $r('app.media.TrueDamageB'),
  '8比特': $r('app.media.8BitB'),
  'K/DA': $r('app.media.KDAB'),
  'EMO': $r('app.media.EmoB'),
  '电子舞曲': $r('app.media.EDMB'),
  '五杀摇滚': $r('app.media.PentakillB'),
  '爵士乐': $r('app.media.JazzB'),
  '心之钢': $r('app.media.PopBandB'),
  '朋克': $r('app.media.PunkRockB'),
  '秘术护卫': $r('app.media.SentinelB'),
  '超级粉丝': $r('app.media.SuperfanB'),
  '法师': $r('app.media.SpellweaverB'),
  '疾射枪手': $r('app.media.QuickshotB'),
  '舞者': $r('app.media.FighterB'),
  '护卫': $r('app.media.GuardianB'),
  '高能流行': $r('app.media.HyperpopB'),
  '裁决使': $r('app.media.ExecutionerB'),
  '刀锋领主': $r('app.media.EdgelordB'),
  '迪斯科': $r('app.media.FunkB'),
  '乡村音乐': $r('app.media.CountryB'),
  '耀光使': $r('app.media.DazzlerB'),
  '音浪刺客': $r('app.media.CrowdDiveB'),
  '格斗家': $r('app.media.BrawlerB'),
  '大腕射手': $r('app.media.DeadeyeB'),
  '双修出道': $r('app.media.BreakoutB'),
  'DJ娑娜': $r('app.media.DJB'),
  '戏命师': $r('app.media.ClassicalB'),
  '大触打击乐': $r('app.media.IllBeatsB'),
  '影流之镰': $r('app.media.TwoSidesB'),
}
export const traits: Record<string, trait> = {
  '8比特': {name: '8比特', sEffect: '将你队伍的已造成伤害记录成分数。你每突破一个高分，【8比特】弈子们就会获得攻击力。', units: ['库奇','盖伦','锐雯','凯特琳'], cnt: [2,4,6], effect: {2:'4.5%攻击力',4:'7.5%攻击力',6:'12%攻击力'} },
  '真实伤害': {name: '真实伤害', sEffect: '【真实伤害】弈子们造成额外真实伤害。如果【真实伤害】弈子携带了一件装备，那么会使其技能获得一个独特的【闪亮加成】。', units: ['凯南','亚索','赛娜','艾克','阿卡丽(真实伤害)','奇亚娜'], cnt: [2,4,6,9], effect: {2:'15%伤害',4:'30%伤害',6:'45%伤害',9:'125%伤害，闪亮加成变为白金级!'} },
  'K/DA': {name: 'K/DA', sEffect: '己方处于灯光格内的弈子们都会获得最大生命值、法术强度和攻击力。【K/DA】弈子们则双倍此加成！', units: ['伊芙琳','莉莉娅','卡莎','萨勒芬妮','妮蔻','阿狸','阿卡丽(K/DA)'], cnt: [3,5,7,10], effect: {3:'10%额外最大生命值，10%双强',5:'15%额外最大生命值，15%双强',7:'22%额外最大生命值，22%双强',10:'50%额外最大生命值，50%双强，每秒10法力值'} },
  'EMO': {name: 'EMO', sEffect: '【EMO】弈子们的技能的法力消耗更低，并且他们会在一名己方弈子阵亡时获得法力值。', units: ['安妮','阿木木','薇古丝','波比'], cnt: [2,4,6], effect: {2:'-20%最大蓝量，+10蓝量获取',4:'-25%最大蓝量，+20蓝量获取',6:'-30%最大蓝量，+25蓝量获取。EMO弈子们获得20法强'} },
  '电子舞曲': {name: '电子舞曲', sEffect: '使用【电子舞曲选择器】来选出一个【电子舞曲】弈子和查看每个弈子的频率。你的【电子舞曲】弈子们会以获选弈子的频率和修正过的效能来施放获选弈子的技能。', units: ['贾克斯','拉克丝','扎克','劫'], cnt: [2,3,4,5], effect: {2:'80%效能',3:'90%效能',4:'100%效能，频率-1秒',5:'120%效能，频率-2秒'} },
  '五杀摇滚': {name: '五杀摇滚', sEffect: '【五杀摇滚】弈子们获得15%伤害减免并造成额外伤害。每击杀一个英雄，一个【五杀摇滚】弈子就会摇滚起来，使其伤害加成提升25%。第5次击杀会强化所有【五杀摇滚】弈子并且你的队伍会获得50%攻击速度。', units: ['奥拉夫','凯尔','纳尔','莫德凯撒','卡尔萨斯','佛耶戈','约里克'], cnt: [3,5,7,10], effect: {3:'15%额外伤害',5:'30%额外伤害',7:'45%额外伤害',10:'110%额外伤害，50%伤害减免'} },
  '爵士乐': {name: '爵士乐', sEffect: '每拥有一个处于激活状态的非独特羁绊，你的队伍就会获得额外生命值并造成额外伤害。', units: ['巴德','厄运小姐','卢锡安'], cnt: [2,3,4], effect: {2:'1.5%额外最大生命值与1%伤害',3:'2%额外最大生命值与1.5%伤害',4:'3%额外最大生命值与2%伤害'} },
  '心之钢': {name: '心之钢', sEffect: '通过击杀敌人来获得心能。输掉玩家战斗回合会获得更多心能。每经过4场玩家战斗回合，就会将心能转化为强力奖励！', units: ['奎桑提','厄斐琉斯','瑟提','永恩','伊泽瑞尔','凯隐'], cnt: [3,5,7,10], effect: {3:'1×心能数',5:'2.5×心能数',7:'6×心能数',10:'10×心能数，每回合获得奖励并保留你的80%心能！'} },
  '朋克': {name: '朋克', sEffect: '【朋克】们获得额外生命值和攻击力。在你每次将金币花在刷新商店时，这个加成都会提升1%。在【朋克】们参与战斗之后，你的第一次商店刷新花费1金币并转而提供3%加成！', units: ['金克丝','蔚','潘森','图奇'], cnt: [2,4,6], effect: {2:'+160生命值和+16%攻击力',4:'+260生命值和+26%攻击力',6:'+420生命值和+42%攻击力'} },
  'DJ娑娜': {name: 'DJ娑娜', sEffect: '(唯一) 选择一个模式来修改【DJ娑娜】的攻击和技能。', units: ['娑娜'], cnt: [1], effect: {1:'(唯一) 选择一个模式来修改【DJ娑娜】的攻击和技能。'} },
  '乡村音乐': {name: '乡村音乐', sEffect: '当你的队伍损失30%总生命值时，一匹【恐惧战马】就会冲入战场并强化你的队伍。【乡村乐】弈子的每个星级都会提升【恐惧战马】的生命值和攻击力。', units: ['塔姆','卡特琳娜','莎弥拉','厄加特','锤石'], cnt: [3,5,7], effect: {3:'召唤恐惧战马',5:'召唤午夜恐惧战马',7:'召唤炼狱祈灵恐惧战马'} },
  '戏命师': {name: '戏命师', sEffect: '(唯一) 【戏命师】总会以一个固定的频率进行攻击，并且会将1%额外攻击速度转化为0.7%攻击力。', units: ['烬'], cnt: [1], effect: {1: '(唯一) 【戏命师】总会以一个固定的频率进行攻击，并且会将1%额外攻击速度转化为0.7%攻击力。'} },
  '迪斯科': {name: '迪斯科', sEffect: '召唤一个可移动的【迪斯科灯球】。战斗开始时：紧挨着灯球的弈子们每3秒获得攻击速度和即时治疗效果。', units: ['娜美','塔里克','古拉加斯','布里茨','崔斯特'], cnt: [3,4,5,6], effect: {3:'5%攻击速度，2%生命回复',4:'10%攻击速度，3%生命回复',5:'额外获得一个迪斯科灯球15%攻击速度，3%生命回复',6:'20%攻击速度，5%生命回复'} },
  '大触打击乐': {name: '大触打击乐', sEffect: '(唯一) 获得2/2/8个可放置的灵体触手，取决于俄洛伊的星级。触手们拥有俄洛伊的额外护甲和魔抗。', units: ['俄洛伊'], cnt: [1], effect: {1:'(唯一) 获得2/2/8个可放置的灵体触手，取决于俄洛伊的星级。触手们拥有俄洛伊的额外护甲和魔抗。'} },
  '高能流行': {name: '高能流行', sEffect: '在【高能流行】弈子们施放技能时，会为其相距最近的2个友军提供法力值和持续4秒的攻击速度。', units: ['璐璐','吉格斯'], cnt: [1,2,3,4], effect: {1:'10%攻击速度与3法力值',2:'20%攻击速度与5法力值',3:'35%攻击速度与7法力值',4:'60%攻击速度与10法力值'} },
  '秘术护卫': {name: '秘术护卫', sEffect: '你的队伍获得护甲与魔抗。【秘术护卫】们获得双倍此加成。', units: ['奎桑提','莉莉娅','盖伦','艾克','莫德凯撒','布里茨'], cnt: [2,4,6,8], effect: {2:'16护甲和魔抗',4:'35护甲和魔抗',6:'60护甲和魔抗',8:'125护甲和魔抗'} },
  '超级粉丝': {name: '超级粉丝', sEffect: '【超级粉丝】们会增强你的【赛季之星】！', units: ['莉莉娅','凯南','纳尔','妮蔻'], cnt: [3,4,5], effect: {3:'【赛季之星】获得一件成装',4:'【赛季之星】获得250生命值和15%全能吸血',5:'装备升级至光明武器'} },
  '法师': {name: '法师', sEffect: '你的弈子们获得15法术强度。【法师】们获得更多法术强度，并在每个【法师】施法时进一步获得法术强度。', units: ['安妮','古拉加斯','萨勒芬妮','艾克','璐璐','阿狸','娑娜'], cnt: [3,5,7,10], effect: {3:'20法强，每次释放技能1法强',5:'35法强，每次释放技能1法强',7:'50法强，每次释放技能2法强',10:'120法强，每次释放技能10法强'} },
  '疾射枪手': {name: '疾射枪手', sEffect: '你的弈子们获得10%攻击速度。【疾射枪手】们在每次攻击时获得更多攻击速度。(至多至10层)', units: ['金克丝','厄斐琉斯','赛娜','凯特琳','卢锡安'], cnt: [2,4,6], effect: {2:'4%攻击速度',4:'7%攻击速度',6:'12%攻击速度'} },
  '舞者': {name: '舞者', sEffect: '【舞者】们获得攻击速度和全能吸血，这些加成基于已损失生命值至多提升100%。', units: ['蔚','纳尔','贾克斯','瑟提','厄加特','波比','约里克'], cnt: [2,4,6], effect: {2:'20%攻击速度，10%全能吸血',4:'30%攻击速度，15%全能吸血',6:'50%攻击速度，20%全能吸血'} },
  '护卫': {name: '护卫', sEffect: '每场战斗一次：【护卫】们在降至50%生命值时，会为自身和相距最近的那名友军提供基于自身最大生命值的护盾值。', units: ['凯南','塔里克','潘森','阿木木','妮蔻','锤石','约里克'], cnt: [2,4,6], effect: {2:'25%最大生命值的护盾值',4:'40%最大生命值的护盾值',6:'60%最大生命值的护盾值'} },
  '裁决使': {name: '裁决使', sEffect: '【裁决使】们的技能可以暴击，并且他们会获得额外的暴击伤害。他们的暴击几率会基于目标的已损失生命值而获得提升。', units: ['图奇','莎弥拉','薇古丝','阿卡丽(K/DA)','阿卡丽(真实伤害)','卡尔萨斯'], cnt: [2,4,6], effect: {2:'5%暴击伤害，至多至15%暴击概率',4:'25%暴击伤害，至多至35%暴击概率',6:'45%暴击伤害，至多至55%暴击概率'} },
  '刀锋领主': {name: '刀锋领主', sEffect: '【刀锋领主】们获得攻击速度，这个攻速加成会在其目标跌下50%生命值时翻倍。攻击距离为1格的【刀锋领主】的下次攻击还会冲刺并斩击穿过其目标。', units: ['亚索','凯尔','锐雯','永恩','佛耶戈','凯隐'], cnt: [3,5,7], effect: {3:'30%攻击速度',5:'45%攻击速度',7:'70%攻击速度'} },
  '耀光使': {name: '耀光使', sEffect: '【耀光使】的技能会使目标的伤害降低25%，并持续造成额外魔法伤害，持续2秒。', units: ['娜美','巴德','拉克丝','崔斯特','吉格斯'], cnt: [2,4,6], effect: {2:'20%魔法伤害',4:'60%魔法伤害',6:'100%魔法伤害'} },
  '音浪刺客': {name: '音浪刺客', sEffect: '【音浪刺客】们造成额外伤害，这个额外伤害每秒提升1%。在阵亡后会跳到相距最远的敌人身上，对其造成300魔法伤害。1格内的敌人们会被晕眩1.5秒。', units: ['伊芙琳','卡特琳娜','永恩','劫','奇亚娜'], cnt: [2,4,6], effect: {2:'5%额外伤害',4:'30%额外伤害',6:'60%额外伤害'} },
  '格斗家': {name: '格斗家', sEffect: '你的弈子们获得100生命值。【格斗家】们获得额外的最大生命值。', units: ['奥拉夫','塔姆','古拉加斯','瑟提','扎克','俄洛伊'], cnt: [2,4,6], effect: {2:'+20%最大生命值',4:'+45%最大生命值',6:'+85%最大生命值'} },
  '大腕射手': {name: '大腕射手', sEffect: '【大腕射手】们获得攻击力。这个加成会在【大腕射手】们每次施放技能时获得持续3秒的提升。', units: ['库奇','卡莎','厄运小姐','伊泽瑞尔','烬'], cnt: [2,4,6], effect: {2:'10%攻击力，施法后40%',4:'15%攻击力，施法后60%',6:'25%攻击力，施法100%'} },
  '双修出道': {name: '双修出道', sEffect: '(唯一) 【阿卡丽】可以是【K/DA】或【真实伤害】的一名成员，取决于哪个羁绊登场了更多弈子。她会基于所处的乐队获得一个相应的技能。', units: ['阿卡丽(K/DA)','阿卡丽(真实伤害)'], cnt: [1], effect: {1:'(唯一) 【阿卡丽】可以是【K/DA】或【真实伤害】的一名成员，取决于哪个羁绊登场了更多弈子。她会基于所处的乐队获得一个相应的技能。'} },
  '影流之镰': {name: '影流之镰', sEffect: '(唯一) 如果你赢下了玩家战斗回合，那么【凯隐】就会变成【影流刺客】。如果没有，则他会变成【拉亚斯特】。每当他击杀2个敌方弈子时，你就会获得一次基于他形态的奖励。影流刺客：3金币；拉亚斯特：1玩家生命值', units: ['凯隐'], cnt: [1], effect: {1:'(唯一) 如果你赢下了玩家战斗回合，那么【凯隐】就会变成【影流刺客】。如果没有，则他会变成【拉亚斯特】。每当他击杀2个敌方弈子时，你就会获得一次基于他形态的奖励。影流刺客：3金币；拉亚斯特：1玩家生命值'} },
}
// 种族
export const race: Array<string> = [
  '8比特',
  '真实伤害',
  'K/DA',
  'EMO',
  '电子舞曲',
  '五杀摇滚',
  '爵士乐',
  '心之钢',
  '朋克',
  'DJ娑娜',
  '乡村音乐',
  '戏命师',
  '迪斯科',
  '大触打击乐',
  '高能流行'
]
// 职业
export const pro: Array<string> = [
  '秘术护卫',
  '超级粉丝',
  '法师',
  '疾射枪手',
  '舞者',
  '护卫',
  '裁决使',
  '刀锋领主',
  '耀光使',
  '音浪刺客',
  '格斗家',
  '大腕射手',
  '双修出道',
  '影流之镰'
]

export const traitLevel: Record<string, number> = {
  '戏命师': 1,
  'DJ娑娜': 2,
  '大触打击乐': 3,
  '影流之镰': 4,
  '8比特': 5,
  '裁决使': 6,
  '乡村音乐': 7,
  '双修出道': 8,
  '音浪刺客': 9,
  '电子舞曲': 10,
  '刀锋领主': 11,
  'EMO': 12,
  '舞者': 13,
  '迪斯科': 14,
  '爵士乐': 15,
  'K/DA': 16,
  '法师': 17,
  '耀光使': 18,
  '五杀摇滚': 19,
  '心之钢': 20,
  '朋克': 21,
  '大腕射手': 22,
  '疾射枪手': 23,
  '超级粉丝': 24,
  '秘术护卫': 25,
  '格斗家': 26,
  '护卫': 27,
  '真实伤害': 28,
  '高能流行': 29,
}
export const traitCntLevel246: Record<number, number> = {
  9: 1,
  8: 2, // 8秘术<7五杀
  6: 3,
  4: 5,
  2: 7,
} // 适用于2，4，6的羁绊
export const traitCntLevel357: Record<number, number> = {
  10: 1,
  7: 2,
  5: 4,
  3: 6,
} // 适用于3，5，7，10的羁绊
export const traitCntLevel2345: Record<number, number> = {
  5: 2, // 7乡村 > 5电子 > 7五杀
  4: 4, // 5乡村 > 4电子
  3: 6,
  2: 7, // 3刀锋 > 2电子 > 2疾射
} // 电子舞曲2345
export const traitCntLevel234: Record<number, number> = {
  4: 4, // 5乡村 > 4爵士
  3: 5,
  2: 7,
} // 爵士乐234
export const traitCntLevel3456: Record<number, number> = {
  6: 3, // 7乡村 > 6迪斯科
  5: 4,
  4: 5, // 2高能流行 > 4迪斯科 > 3乡村
  3: 6,
} // 迪斯科3456
export const traitCntLevel345: Record<number, number> = {
  5: 3, // 5超粉 > 5迪斯科 > 5五杀
  4: 5, // 2高能流行 > 4迪斯科 > 3乡村
  3: 6,
} // 超级粉丝345
export const traitCntLevel1234: Record<number, number> = {
  4: 2,
  3: 3,
  2: 5,
  1: 7,
}// 高能流行1234
export const traiCntLevel1: Record<number, number> = {1: 4}