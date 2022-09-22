--[[
-- File: RaidDebuffs_WotLK.lua
-- Author: enderneko (enderneko-dev@outlook.com)
-- File Created: 2022/08/05 16:11:18 +0800
-- Last Modified: 2022/09/22 16:04:25 +0800
--]]

local _, Cell = ...
local F = Cell.funcs

local debuffs = {
    [753] = { -- 阿尔卡冯的宝库
        ["general"] = {
            60899, -- 护盾碾压
            "72120", -- 冰霜撕咬
            60923, -- 岩石雨
        },
        [1597] = { -- 岩石看守者阿尔卡冯
            60880, -- 践踏
        },
        [1598] = { -- 风暴看守者埃玛尔隆
        },
        [1599] = { -- 火焰看守者科拉隆
            66684, -- 余烬
        },
        [1600] = { -- 寒冰看守者图拉旺
            72090, -- 大地冰封
            "72004", -- 冰霜撕咬
            -72034, -- 霜至
        },
    },

    [754] = { -- 纳克萨玛斯
        ["general"] = {
            59899, -- 毒性充能
            54708, -- 撕裂
            54709, -- 血肉腐烂
            54769, -- 黏液爆炸
            54772, -- 腐烂撕咬
            54805, -- 精神鞭笞
            56538, -- 疫病喷溅
            16856, -- 致死打击
            "29849", -- 冰霜新星
            "30094", -- 冰霜新星
            33661, -- 碾碎护甲
            55318, -- 穿刺护甲
            55322, -- 血之疫病
            55331, -- 冰冷触摸
            55334, -- 绞袭
            6713, -- 缴械
            -54714, -- 酸性箭雨
            -28440, -- 暗影迷雾
            -28801, -- 软泥
        },
        [1601] = { -- 阿努布雷坎
            56098, -- 酸液喷射
            -54022, -- 虫群风暴
        },
        [1602] = { -- 黑女巫法琳娜
            54099, -- 火焰之雨
            -54098, -- 毒液箭雨
        },
        [1603] = { -- 迈克斯纳
            28622, -- 蛛网裹体
            28776, -- 死灵之毒
            54125, -- 蛛网喷射
        },
        [1604] = { -- 药剂师诺斯
            54835, -- 药剂师诅咒
            54836, -- 药剂师的怒火
            29212, -- 残废术
            54814, -- 残废
            32736, -- 致死打击
        },
        [1605] = { -- 肮脏的希尔盖
            -55011, -- 衰老热疫
            -29310, -- 法术瓦解
        },
        [1606] = { -- 洛欧塞布
            55052, -- 必然的厄运
            55053, -- 死亡之花
            -55593, -- 死灵光环
            -29232, -- 蘑菇花
        },
        [1607] = { -- 教官拉苏维奥斯
            55470, -- 紊乱打击
        },
        [1608] = { -- 收割者戈提克
            55645, -- 死亡疫病
            27825, -- 暗影遮罩
            -- 28679, -- 收割灵魂
            -- 27993, -- 践踏
        },
        [1609] = { -- 天启四骑士
            57369, -- 邪恶之影
            -28832, -- 库尔塔兹印记
            -28833, -- 布劳缪克丝印记
            -28834, -- 瑞文戴尔印记
            -28835, -- 瑟里耶克印记
        },
        [1610] = { -- 帕奇维克
        },
        [1611] = { -- 格罗布鲁斯
        },
        [1612] = { -- 格拉斯
            54378, -- 致命伤
            29306, -- 感染之伤
        },
        [1613] = { -- 塔迪乌斯
            -28059, -- 正能量电荷
            -28084, -- 负能量电荷
        },
        [1614] = { -- 萨菲隆
            "28522", -- 寒冰箭
            55665, -- 生命吸取
            28547, -- 寒冷
            55699, -- 寒冷
            -55799, -- 冰霜光环
        },
        [1615] = { -- 克尔苏加德
            27819, -- 自爆法力
            "55802", -- 寒冰箭
            "55807", -- 寒冰箭
        },
    },

    [755] = { -- 黑曜石圣殿
        ["general"] = {
            39647, -- 治疗诅咒
            13737, -- 致死打击
            58947, -- 震荡波
            58940, -- 烈焰震击
            57759, -- 落锤
        },
        [1616] = { -- 萨塔里奥
            57491, -- 烈焰之啸
            60708, -- 护甲衰减
            -58105, -- 沙德隆之力
            -61248, -- 塔尼布隆之力
            -61251, -- 维斯匹隆之力
        },
    },

    [756] = { -- 永恒之眼
        ["general"] = {
        },
        [1617] = { -- 玛里苟斯
            60072, -- 奥术吐息
            60936, -- 能量涌动
            57429, -- 静电力场
            -56438, -- 奥术过载
            -55849, -- 能量火花
            -61071, -- 漩涡
        },
    },

    [759] = { -- 奥杜尔
        ["general"] = {
            "64847", -- 符文烈焰喷射
            64766, -- 激光弹幕
            62845, -- 断筋
            50370, -- 破甲攻击
            -------
            64698, -- 炎爆术
            64697, -- 地震术
            -------
            65102, -- 锯刃
            -------
            64967, -- 符文击打
            64942, -- 毁灭飞跃
            64971, -- 电击
            "64988", -- 符文烈焰喷射
            -------
            63615, -- 破坏护甲
            63673, -- 闪电烙印
            -------
            64638, -- 酸性撕咬
            64649, -- 冰冻吐息
            -64653, -- 暴风雪
            -64655, -- 冰锥术
            -------
            63551, -- 毒性吐息
            63568, -- 活体海啸
            63272, -- 飓风
            63548, -- 大地裂隙
            63549, -- 石化联结
            -------
            64740, -- 能量分流
            64919, -- 寒冰新星
            -------
            13704, -- 心灵尖啸
            63755, -- 致命毒药
            52719, -- 震荡猛击
            57807, -- 破甲
            63775, -- 烈焰风暴
            -63757, -- 雷霆一击
            -38064, -- 冲击波
        },
        [1637] = { -- 烈焰巨兽
            62297, -- 霍迪尔之怒
            62376, -- 撞锤
        },
        [1638] = { -- 掌炉者伊格尼斯
            63472, -- 烈焰喷射
        },
        [1639] = { -- 锋鳞
            64757, -- 风暴打击
            64774, -- 护甲熔化
            64771, -- 熔化护甲
            64021, -- 烈焰龙息
        },
        [1640] = { -- XT-002拆解者
            65121, -- 灼热之光
            64236, -- 静电充能
            -62775, -- 发脾气
        },
        [1641] = { -- 钢铁议会
            61878, -- 过载
            61888, -- 压倒能量
            63493, -- 熔化冲压
            63494, -- 静电瓦解
            63490, -- 死亡符文
        },
        [1642] = { -- 科隆加恩
            63978, -- 岩石新星
            62055, -- 脆弱皮肤
            62030, -- 石化吐息
            64002, -- 压碎护甲
        },
        [1643] = { -- 欧尔莉亚
            64666, -- 野蛮突袭
            64669, -- 野性突袭
            64667, -- 撕扯
            -64679, -- 警戒冲击
            -64386, -- 惊骇尖啸
        },
        [1644] = { -- 霍迪尔
            62469, -- 冰冻
            61969, -- 快速冻结
            62038, -- 刺骨之寒
        },
        [1645] = { -- 托里姆
            62526, -- 符文爆裂
            62605, -- 冰霜新星
            62130, -- 重压打击
            62042, -- 风暴之锤
            62470, -- 震耳雷霆
            62418, -- 穿刺
            62420, -- 盾牌重击
            64151, -- 横扫摔绊
            32323, -- 冲锋
            62602, -- 暴风雪
            63540, -- 瘫痪力场
            -35054, -- 致死打击
            -62601, -- 寒冰箭
            -62326, -- 卑鄙攻击
            -62604, -- 寒冰箭雨
        },
        [1646] = { -- 弗蕾亚
            62865, -- 不稳定的能量
            62619, -- 信息素
            62532, -- 监护者之握
        },
        [1647] = { -- 米米尔隆
            65026, -- 凝固汽油炸弹
            64529, -- 等离子冲击
            65192, -- 烈焰遏制
            64616, -- 震耳警报
            -64533, -- 热浪
        },
        [1648] = { -- 维扎克斯将军
            63276, -- 无面者的印记
            -63277, -- 暗影撞击
            -63420, -- 极度黑暗
            -62692, -- 绝望光环
            -62661, -- 灼热烈焰
        },
        [1649] = { -- 尤格-萨隆
            63134, -- 萨拉的祝福
            63038, -- 黑暗箭雨
            63138, -- 萨拉的热情
            63120, -- 疯狂
            63830, -- 心灵疾病
            64126, -- 挤压
            64153, -- 黑色热疫
            64157, -- 厄运诅咒
            64152, -- 脱水毒药
            64156, -- 冷漠
            64160, -- 吸取生命
            -64189, -- 震耳咆哮
            -64145, -- 能量衰减
            -63050, -- 理智
        },
        [1650] = { -- 观察者奥尔加隆
            62169, -- 黑洞
            64412, -- 相位冲压
        },
    },

    [757] = { -- 十字军的试炼
        ["general"] = {
        },
        [1618] = { -- 诺森德猛兽
            66407, -- 裂颅
            66406, -- 狗头人上身
            66331, -- 穿刺
            66830, -- 麻痹
            66869, -- 灼热胆汁
            66823, -- 麻痹毒素
            66689, -- 极寒吐息
            66770, -- 野蛮头冲
            -66683, -- 重型撞击
        },
        [1619] = { -- 加拉克苏斯大王
            66532, -- 魔能火球
        },
        [1620] = { -- 联盟的冠军
            65542, -- 沉默
            66018, -- 绞袭
            65930, -- 破胆怒吼
            65960, -- 致盲
            66613, -- 制裁之锤
        },
        [1621] = { -- 部落的冠军
            65542, -- 沉默
            66018, -- 绞袭
            65930, -- 破胆怒吼
            65960, -- 致盲
            66613, -- 制裁之锤
        },
        [1622] = { -- 瓦格里双子
            66069, -- 双生之刺
            66075, -- 双生之刺
        },
        [1623] = { -- 阿努巴拉克
            67574, -- 被阿努巴拉克追逐
            66012, -- 寒冰打击
            67721, -- 破甲虚弱
            65775, -- 酸腺撕咬
            66193, -- 永冻
            -66118, -- 吸血虫群
        },
    },

    [760] = { -- 奥妮克希亚的巢穴
        ["general"] = {
            18958, -- 烈焰鞭笞
            12097, -- 穿刺护甲
        },
        [1651] = { -- 奥妮克希亚
            -18431, -- 低吼
        },
    },

    [758] = { -- 冰冠堡垒
        ["general"] = {
            70980, -- 蛛网裹体
            70964, -- 盾击
            -------
            69483, -- 黑暗清算
            -------
            69903, -- 盾牌猛击
            -69911, -- 血之疫病
            -69917, -- 冰霜疫病
            -69930, -- 奉献
            -69975, -- 爆炸射击
            -------
            70189, -- 毒液喷吐
            -70362, -- 暴风雪
            -------
            71089, -- 毒脓
            71127, -- 致命之伤
            -------
            70426, -- 堕落之血
            70423, -- 吸血诅咒
            70435, -- 撕裂肉体
            70408, -- 魔法增效
            70451, -- 鲜血镜像
            70409, -- 火球术
            -------
            71647, -- 寒冰陷阱
            71257, -- 野蛮打击
            -------
            71316, -- 冰川打击
            71330, -- 寒冰坟墓
            71320, -- 冰霜新星
            71327, -- 蛛网
            "71318", -- 寒冰箭
            -------
            71386, -- 寒冰吐息
            71380, -- 寒冰冲击
            -36922, -- 低吼
            -- 71387, -- 冰霜光环
        },
        [1624] = { -- 玛洛加尔领主
            69065, -- 穿刺
            -- 69146, -- 冷焰
        },
        [1625] = { -- 亡语者女士
            71237, -- 麻痹诅咒
            70659, -- 死疽打击
            71204, -- 蔑视之触
            71001, -- 死亡凋零
            -71420, -- 寒冰箭
            -72905, -- 寒冰箭雨
        },
        [1627] = { -- 冰冠冰川炮舰战
        },
        [1628] = { -- 死亡使者萨鲁法尔
            72385, -- 沸腾之血
            72410, -- 符文之血
            72769, -- 血之气息
        },
        [1629] = { -- 烂肠
            69240, -- 邪恶毒气
            69278, -- 毒气孢子
            69290, -- 枯萎的孢子
            72297, -- 可延展黏液
            72219, -- 毒肿
            -69291, -- 播种疫苗
            -- "69279", -- 毒气孢子
        },
        [1630] = { -- 腐面
            72272, -- 邪恶毒气
            69789, -- 软泥洪流
        },
        [1631] = { -- 普崔塞德教授
            70911, -- 肆虐毒疫
            70672, -- 毒肿
            70447, -- 不稳定的软泥怪黏合剂
            71278, -- 窒息毒气
            70853, -- 可延展黏液
            72451, -- 畸变瘟疫
            -70353, -- 异变毒气
            -70308, -- 畸变
        },
        [1632] = { -- 鲜血王子议会
            71807, -- 闪耀火花
            71822, -- 暗影共鸣
            -73001, -- 暗影牢笼
        },
        [1633] = { -- 鲜血女王兰娜瑟尔
            70867, -- 鲜血女王的精华
            70877, -- 疯狂嗜血
            "71264", -- 蜂拥之影
            "71265", -- 蜂拥之影
            70923, -- 失心疯
        },
        [1634] = { -- 踏梦者瓦莉瑟瑞娅
            70744, -- 酸性爆炸
            70751, -- 腐蚀
            72963, -- 血肉腐烂
            -70759, -- 寒冰箭雨
        },
        [1635] = { -- 辛达苟萨
            69766, -- 动荡
            69762, -- 狂咒
            70127, -- 秘法打击
            70106, -- 寒霜刺骨
            69649, -- 冰霜吐息
            70157, -- 寒冰坟墓
            "-70084", -- 冰霜光环
        },
        [1636] = { -- 巫妖王
            70338, -- 死疽
            70541, -- 寄生
            69409, -- 灵魂收割
            72133, -- 饱受折磨
            "73654", -- 收割灵魂
            69242, -- 灵魂尖啸
            "-73655", -- 收割灵魂
            -72350, -- 霜之哀伤的怒火
            -- 72754, -- 污染
        },
    },

    [761] = { -- 红玉圣殿
        ["general"] = {
            74453, -- 烈焰道标
            74456, -- 燃烧
            74509, -- 奥术冲击波
            74367, -- 破甲斩
            74384, -- 破胆咆哮
            13737, -- 致死打击
            15621, -- 颅骨爆裂
            75417, -- 震荡波
        },
        [1652] = { -- 海里昂
            74567, -- 燃烧印记
            74562, -- 炽焰燃烧
            74795, -- 吞噬印记
            74792, -- 灵魂吞噬
            74531, -- 尾击
        },
    },

    [286] = { -- 乌特加德之巅
        ["general"] = {
            56785, -- 快速传染
            59079, -- 墓穴打击
            -------
            59239, -- 撕裂
            -- 49026, -- 凝视 (invisible)
            -------
            49106, -- 恐吓
            61549, -- 撕碎
            -------
        },
        [641] = { -- 席瓦拉·索格蕾
            -- 48267, -- 准备仪式
            48278, -- 麻痹
            48277, -- 仪祭打击
        },
        [642] = { -- 戈托克·苍蹄
            59263, -- 重伤
            59264, -- 刺伤
            48131, -- 践踏
            -------
            59271, -- 毒息
            48132, -- 酸液喷射
            -------
            59265, -- 致命伤
            -------
            48144, -- 恐惧咆哮
            -------
            59268, -- 穿刺
            -59267, -- 枯萎咆哮
        },
        [643] = { -- 残忍的斯卡迪
            59330, -- 重压
            59334, -- 淬毒长矛
            49092, -- 结网
            48639, -- 断筋
            60020, -- 冰冻之云
            59247, -- 缩小
        },
        [644] = { -- 伊米隆国王
            59300, -- 恶臭溃烂
            59304, -- 灵魂打击
            51750, -- 亡者嚎叫
            -48585, -- 枯萎
        },
    },

    [285] = { -- 乌特加德城堡
        ["general"] = {
            22427, -- 震荡猛击
            59601, -- 燃烧之烙
            43887, -- 极度燥热
            -------
            59608, -- 破甲
            59691, -- 撕裂
            -37578, -- 衰弱打击
            -------
            "59611", -- 冲锋
            -59613, -- 挫志怒吼
            "-42702", -- 衰老
            -------
            -- 40414, -- 凝视 (invisible)
            -------
            42972, -- 致盲
            -------
            43936, -- 锐不可挡
            59605, -- 刺骨戳刺
            -59599, -- 裂颅
            -------
            59686, -- 定时炸弹
        },
        [638] = { -- 凯雷塞斯王子
            48400, -- 冰霜之墓
            "59397", -- 衰老
        },
        [639] = { -- 斯卡瓦尔德和达尔隆
            43650, -- 衰弱
            43651, -- 冲锋
        },
        [640] = { -- 掠夺者因格瓦尔
            59735, -- 悲哀攻击
            42723, -- 黑暗打击
            -61485, -- 恐怖咆哮
        },
    },

    [284] = { -- 冠军的试炼
        ["general"] = {
            67868, -- 被践踏
            34942, -- 暗言术：痛
            67237, -- 紊乱打击
            67255, -- 最终冥想
        },
        [834] = { -- 总冠军
            66043, -- 变形术
            67534, -- 妖术治愈
            67710, -- 夺命药膏
            67542, -- 致死打击
            67594, -- 毒药瓶
            -66044, -- 冲击波
        },
        [635] = { -- 纯洁者耶德瑞克
            66940, -- 制裁之锤
            66862, -- 光芒耀眼
        },
        [636] = { -- 银色神官帕尔崔丝
            66538, -- 神圣之火
            66619, -- 昔日阴影
            66552, -- 梦魇乍醒
            66620, -- 旧患
            -66547, -- 忏悔
        },
        [637] = { -- 黑骑士
            67781, -- 亵渎
            67823, -- 死亡标记
            -67808, -- 死亡撕咬
            -67719, -- 冰霜疫病
            -67722, -- 血之疫病
        },
    },

    [279] = { -- 净化斯坦索姆
        ["general"] = {
            58811, -- 腐蚀术
            46190, -- 痛苦诅咒
            58782, -- 血毒素
            52491, -- 蛛网爆炸
            58758, -- 吞噬血肉
            -15244, -- 冰锥术
            -20812, -- 残废术
            -------
            58816, -- 时间漩涡
        },
        [611] = { -- 肉钩
            58823, -- 束缚之链
        },
        [612] = { -- 塑血者沙尔拉姆
            58845, -- 扭曲血肉诅咒
            52711, -- 窃取血肉
        },
        [613] = { -- 时光领主埃博克
            58830, -- 致伤打击
            52772, -- 耗能诅咒
            -52766, -- 时间扭曲
            -58848, -- 时间停止
        },
        [614] = { -- 玛尔加尼斯
            58849, -- 沉睡
            58852, -- 腐臭蜂群
        },
    },

    [274] = { -- 古达克
        ["general"] = {
            59019, -- 毒性喷吐
            59023, -- 穿透打击
            58977, -- 震荡波
            58993, -- 魔精之波
            "58994", -- 魔精泥浆
            58975, -- 雷霆一击
            58971, -- 烈焰震击
            58978, -- 穿刺
            61362, -- 冲击波
            55643, -- 回吐
            58967, -- 淬毒长矛
            58992, -- 震耳咆哮
        },
        [592] = { -- 斯拉德兰
            55126, -- 毒蛇裹体
            59842, -- 毒性新星
            58996, -- 毒性撕咬
            59840, -- 强力撕咬
            -55093, -- 斯拉德兰之握
        },
        [593] = { -- 达卡莱巨像
            59455, -- 致死打击
            54819, -- 被魔精浸湿
            "59451", -- 魔精泥浆
        },
        [594] = { -- 莫拉比
            59444, -- 决断突刺
            55101, -- 地震
            55142, -- 大地震颤
            -55100, -- 麻痹怒吼
            -55106, -- 麻痹嚎叫
        },
        [595] = { -- 凶残的伊克
            55814, -- 伊克之秽
        },
        [596] = { -- 迦尔达拉
            59827, -- 穿刺冲锋
            59825, -- 旋风劈砍
            59826, -- 刺破
        },
    },

    [271] = { -- 安卡赫特：古代王国
        ["general"] = {
            56707, -- 腐化传染
            59108, -- 粘性毒药
            19134, -- 破胆怒吼
            56728, -- 黑暗中的眼睛
            56632, -- 混乱之网
            61462, -- 冰霜新星
            13338, -- 语言诅咒
            61563, -- 腐蚀术
            34322, -- 心灵尖啸
            -61460, -- 失落希望光环
            -61461, -- 寒冰箭
            -59116, -- 毒云
        },
        [580] = { -- 纳多克斯长老
            59467, -- 蜘蛛疫病
            59482, -- 致命毒药
        },
        [581] = { -- 塔达拉姆王子
            59513, -- 吸血鬼的拥抱
        },
        [582] = { -- 耶戈达·觅影者
        },
        [583] = { -- 埃曼尼塔
            57095, -- 纠缠根须
            57061, -- 毒云
            57055, -- 迷你
            -56648, -- 高能蘑菇
        },
        [584] = { -- 传令官沃拉兹
            59978, -- 碎裂
            59974, -- 精神鞭笞
        },
    },

    [277] = { -- 岩石大厅
        ["general"] = {
            59039, -- 无情打击
            -------
            59034, -- 凿击辐射
            43104, -- 重伤
            46202, -- 穿刺护甲
        },
        [604] = { -- 克莱斯塔卢斯
            50812, -- 石化之握
            50836, -- 石化之握
            -50833, -- 砸击地面
        },
        [605] = { -- 悲伤圣女
            59726, -- 悲伤震荡
            59727, -- 哀伤之柱
        },
        [606] = { -- 远古法庭
            59868, -- 黑暗物质
            59864, -- 暗言术-痛
            59865, -- 大地冲撞
            58461, -- 破甲
        },
        [607] = { -- 塑铁者斯约尼尔
            59846, -- 静电充能
            59849, -- 闪电之环
        },
    },

    [276] = { -- 映像大厅
        ["general"] = {
            72335, -- 肾击
            72222, -- 诅咒之箭
            72318, -- 暗言术：痛
            72329, -- 致命毒药
            72171, -- 寒冰锁链
            69222, -- 投掷盾牌
        },
        [601] = { -- 法瑞克
            72426, -- 绝望降临
            72435, -- 亵渎尖啸
            72428, -- 绝望一击
            72422, -- 震荡打击
            -- 72395, -- 绝望
            -- 72396, -- 绝望
            -- 72397, -- 绝望
        },
        [602] = { -- 玛维恩
            72383, -- 腐蚀之触
            72362, -- 腐蚀之井
            72363, -- 腐化血肉
        },
        [603] = { -- 逃离阿尔萨斯
            70176, -- 呕吐
            70144, -- 厄运诅咒
        },
    },

    [280] = { -- 灵魂洪炉
        ["general"] = {
            69131, -- 灵魂虚弱
            69060, -- 冰霜新星
            69133, -- 昏睡
            69633, -- 暗影之幕
            -- 69130, -- 灵魂虹吸
        },
        [615] = { -- 布隆亚姆
            68950, -- 恐惧
            68921, -- 灵魂风暴
        },
        [616] = { -- 噬魂者
        },
    },

    [283] = { -- 紫罗兰监狱
        ["general"] = {
            52719, -- 震荡猛击
            58504, -- 痛苦打击
            59256, -- 穿刺
            59253, -- 冰霜新星
            60204, -- 奥术之流
            32736, -- 致死打击
            59258, -- 冰锥术
        },
        [626] = { -- 埃雷克姆
        },
        [627] = { -- 摩拉格
            54396, -- 旋光链接
            54417, -- 受难射线
            59525, -- 痛苦射线
            54527, -- 腐蚀唾液
        },
        [628] = { -- 艾库隆
        },
        [629] = { -- 谢沃兹
            59485, -- 奥术冲击
        },
        [630] = { -- 拉文索尔
        },
        [631] = { -- 湮灭者祖拉玛特
        },
        [632] = { -- 塞安妮苟萨
            59374, -- 法力毁灭
            59281, -- 无法控制的能量
            59369, -- 暴风雪
        },
    },

    [272] = { -- 艾卓-尼鲁布
        ["general"] = {
            52086, -- 蛛网裹体
            59348, -- 感染之伤
            59343, -- 撕裂
            59347, -- 镇压之网
            59352, -- 黑暗印记
            -59354, -- 吸取能量
            -59362, -- 蛛网射击
        },
        [585] = { -- 看门者克里克希尔
            59364, -- 感染撕咬
            59365, -- 致盲之网
            59367, -- 精神鞭笞
            59368, -- 疲倦诅咒
            59366, -- 毒药喷洒
            59363, -- 酸液溅射
        },
        [586] = { -- 哈多诺克斯
            59417, -- 吸血毒药
            53418, -- 穿刺护甲
            59419, -- 酸性之云
        },
        [587] = { -- 阿努巴拉克
            59433, -- 重击
            59359, -- 毒箭
            59349, -- 投掷
            59350, -- 破甲
            -59431, -- 吸血虫群
        },
    },

    [278] = { -- 萨隆矿坑
        ["general"] = {
            50661, -- 动摇的决心
            69578, -- 转化射线
            70278, -- 穿刺之伤
            70292, -- 冰川打击
            70388, -- 腐蚀之种
            70391, -- 痛苦诅咒
            70392, -- 黑暗烙印
            70393, -- 吞噬血肉
            69581, -- 血肉化脓
            69603, -- 凋零
            69579, -- 弧光切割
            34779, -- 冰冻之环
        },
        [608] = { -- 熔炉之主加弗斯特
            -68786, -- 永冻
            -68771, -- 雷霆践踏
        },
        [609] = { -- 伊克和科瑞克
            68987, -- 扑杀
            68989, -- 毒性新星
            69024, -- 剧毒废渣
        },
        [610] = { -- 天灾领主泰兰努斯
            69275, -- 霜牙印记
            69245, -- 霜降
            69238, -- 寒冰冲击
        },
    },

    [273] = { -- 达克萨隆要塞
        ["general"] = {
            50379, -- 残废
            -------
            59018, -- 腐蚀喷吐
            59007, -- 血肉腐烂
            46202, -- 穿刺护甲
            -------
            32330, -- 毒液喷吐
            49704, -- 罩网
            -------
            59009, -- 血之诅咒
            -------
            6253, -- 反手一击
            49711, -- 钩网
            -------
            35011, -- 击倒
            51240, -- 恐惧
            16856, -- 致死打击
            36094, -- 幽灵打击
            33661, -- 碾碎护甲
            59011, -- 冰冷触摸
            59010, -- 震耳咆哮
            -9080, -- 断筋
        },
        [588] = { -- 托尔戈
            49637, -- 感染之伤
        },
        [589] = { -- 召唤者诺沃斯
            59856, -- 痛苦之怒
            47346, -- 奥术力场
            59854, -- 暴风雪
            8147, -- REVIEW: 雷霆一击 
        },
        [590] = { -- 暴龙之王爵德
            48920, -- 凶残撕咬
            48878, -- 刺骨挥砍
            48873, -- 裂伤挥砍
            13738, -- 撕裂
            22686, -- 低吼
            -59422, -- 恐惧咆哮
            -49710, -- 重击
        },
        [591] = { -- 先知萨隆亚
            59972, -- 生命诅咒
            49544, -- 眼棱
            59969, -- 毒云
            59971, -- 火焰之雨
            -49356, -- 腐烂
            -53463, -- 恢复常态
        },
    },

    [275] = { -- 闪电大厅
        ["general"] = {
            59165, -- 沉睡
            -------
            59085, -- 焊接
            59142, -- 盾牌猛击
            59166, -- 烧灼电流
            -52773, -- 锤击
            -------
            61510, -- 熔化护甲
            -22424, -- 冲击波
            -------
            19134, -- 破胆怒吼
            -23600, -- 刺耳怒吼
            -------
            59168, -- 电击
            -------
            59178, -- 毒尖长矛
            -59151, -- 符文冲击
            -------
            32315, -- 灵魂打击
        },
        [597] = { -- 比亚格里将军
            58747, -- 拦截
            16856, -- 致死打击
        },
        [598] = { -- 沃尔坎
            59530, -- 献祭打击
        },
        [599] = { -- 艾欧纳尔
            59795, -- 静电过载
            59834, -- 弧光灼烧
        },
        [600] = { -- 洛肯
        },
    },

    [281] = { -- 魔枢
        ["general"] = {
            56777, -- 沉默
            47779, -- 奥术洪流
            56776, -- 奥术震击
            56933, -- 燃烧射击
            50132, -- 吸取魔法
            56860, -- 魔法燃烧
            47700, -- 水晶冻结
            -56837, -- 寒冰箭
            -38384, -- 冰锥术
            -48053, -- 诱捕
            -30633, -- 雷霆一击
        },
        [617] = { -- 指挥官斯托比德
            19134, -- 破胆怒吼
            60067, -- 冲锋
        },
        [833] = { -- 指挥官库鲁尔格
            19134, -- 破胆怒吼
            60067, -- 冲锋
        },
        [618] = { -- 大魔导师泰蕾丝塔
            47731, -- 家畜
            56935, -- 寒冰新星
            47736, -- 时间停止
            -56936, -- 暴风雪
        },
        [619] = { -- 阿诺玛鲁斯
            57063, -- 奥术吸引
        },
        [620] = { -- 塑树者奥莫洛克
            61556, -- 混乱
        },
        [621] = { -- 克莉斯塔萨
            48179, -- 晶化
            57091, -- 水晶烈焰吐息
            48095, -- 极度冰寒
        },
    },

    [282] = { -- 魔环
        ["general"] = {
            50690, -- 大地静止
            38047, -- 精神扭曲
            50731, -- 锤击
            59260, -- 钩网
            54074, -- 致伤药膏
            59269, -- 血肉撕咬
            59211, -- 寒冰之光
            -50535, -- 吸取能量
            -59278, -- 暴风雪
        },
        [622] = { -- 审讯者达库斯
        },
        [623] = { -- 瓦尔洛斯·云击
            59371, -- 魔法增效
        },
        [624] = { -- 法师领主伊洛姆
            59376, -- 定时炸弹
            58025, -- 冰霜打击
            -51103, -- 寒冰炸弹
        },
        [625] = { -- 魔网守护者埃雷苟斯
        },
    },
}

F:LoadBuiltInDebuffs(debuffs)