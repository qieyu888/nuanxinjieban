import '../models/comment.dart';

class PostComments {
  PostComments._();

  static Comment _c(
    String postId,
    int index,
    String user,
    String seed,
    String content, {
    int hoursAgo = 2,
    int likes = 0,
    bool isLiked = false,
  }) {
    return Comment(
      id: '${postId}_$index',
      user: user,
      avatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=$seed',
      content: content,
      timestamp: DateTime.now().subtract(Duration(hours: hoursAgo + index)),
      likes: likes,
      isLiked: isLiked,
    );
  }

  static final Map<String, List<Comment>> _data = {
    '1': [
      _c('1', 0, '旅行小白', 'c101', '洱海日落太美了！请问几点去最好？', hoursAgo: 6, likes: 18),
      _c('1', 1, '大理本地人', 'c102', '建议下午5点左右到才村码头，光线最好。', hoursAgo: 5, likes: 32),
      _c('1', 2, '摄影爱好者', 'c103', '构图绝了，橘色水面太治愈！', hoursAgo: 4, likes: 15),
      _c('1', 3, '周末出逃', 'c104', '已加入旅行清单，下个月就去。', hoursAgo: 3, likes: 8),
      _c('1', 4, '慢生活', 'c105', '在大理住了一周，每天看日落都不腻。', hoursAgo: 2, likes: 21),
    ],
    '2': [
      _c('2', 0, '极地迷', 'c201', '极光下露营太勇了，不怕冷吗？', hoursAgo: 8, likes: 24),
      _c('2', 1, '冰岛攻略', 'c202', '雷克雅未克周边有很多观极光的好位置。', hoursAgo: 7, likes: 41),
      _c('2', 2, '户外达人', 'c203', '装备保暖做好，体验绝对值得！', hoursAgo: 6, likes: 19),
      _c('2', 3, '星空摄影', 'c204', '帐篷那张照片可以当壁纸了。', hoursAgo: 5, likes: 56),
      _c('2', 4, '北欧旅人', 'c205', '我去年也去了，终身难忘。', hoursAgo: 4, likes: 27),
      _c('2', 5, '阿飞粉丝', 'c206', '路上的阿飞出品必属精品！', hoursAgo: 3, likes: 12),
    ],
    '3': [
      _c('3', 0, '和服体验官', 'c301', '清水寺和服拍照太出片了！', hoursAgo: 5, likes: 33),
      _c('3', 1, '樱花季', 'c302', '三月底四月初是京都樱花最好的时候。', hoursAgo: 4, likes: 45),
      _c('3', 2, '日本通', 'c303', '建议提前预约和服店，旺季很抢手。', hoursAgo: 3, likes: 22),
    ],
    '4': [
      _c('4', 0, '极限运动', 'c401', '皇后镇跳伞我做过，终身难忘！', hoursAgo: 7, likes: 38),
      _c('4', 1, '恐高症', 'c402', '看照片腿都软了，佩服！', hoursAgo: 6, likes: 15),
      _c('4', 2, '新西兰攻略', 'c403', 'NZONE跳伞中心口碑很好，推荐。', hoursAgo: 5, likes: 29),
      _c('4', 3, '自由飞翔', 'c404', '这种自由感只有跳过一次才懂。', hoursAgo: 4, likes: 44),
    ],
    '5': [
      _c('5', 0, '高原行者', 'c501', '纳木错海拔高，注意高反哦。', hoursAgo: 6, likes: 26),
      _c('5', 1, '西藏梦', 'c502', '雪山倒影那张太震撼了，收藏！', hoursAgo: 5, likes: 51),
    ],
    '6': [
      _c('6', 0, '吃货联盟', 'c601', '成都火锅哪家最正宗？求推荐！', hoursAgo: 8, likes: 34),
      _c('6', 1, '川味达人', 'c602', '宽窄巷子附近的老字号都不错。', hoursAgo: 7, likes: 28),
      _c('6', 2, '美食博主', 'c603', '看饿了，今晚就去吃串串！', hoursAgo: 6, likes: 19),
      _c('6', 3, '成都土著', 'c604', '兔头配啤酒，巴适得板！', hoursAgo: 5, likes: 42),
      _c('6', 4, '旅行胃', 'c605', '为了美食值得专门飞一趟成都。', hoursAgo: 4, likes: 16),
      _c('6', 5, '辣不怕', 'c606', '5斤算少的，我上次胖了8斤哈哈。', hoursAgo: 3, likes: 23),
    ],
    '7': [
      _c('7', 0, '恐高患者', 'c701', '玻璃栈道我走了十分钟才过去…', hoursAgo: 4, likes: 31),
    ],
    '8': [
      _c('8', 0, '蜜月计划', 'c801', '马尔代夫水上屋是蜜月首选！', hoursAgo: 9, likes: 47),
      _c('8', 1, '海岛控', 'c802', '海水清晰度真的像玻璃一样。', hoursAgo: 8, likes: 35),
      _c('8', 2, '潜水爱好者', 'c803', '附近珊瑚礁浮潜体验超棒。', hoursAgo: 7, likes: 28),
      _c('8', 3, '浪漫旅行', 'c804', '满天繁星下的水上屋，太浪漫了。', hoursAgo: 6, likes: 52),
      _c('8', 4, '度假模式', 'c805', '看完更想辞职去海岛了…', hoursAgo: 5, likes: 19),
    ],
    '9': [],
    '10': [
      _c('10', 0, '文艺少女', 'c1001', '鼓浪屿的钢琴声太有氛围了。', hoursAgo: 5, likes: 22),
      _c('10', 1, '厦门攻略', 'c1002', '海蛎煎推荐龙头路那家老店。', hoursAgo: 4, likes: 18),
      _c('10', 2, '慢旅行', 'c1003', '小岛适合住两晚慢慢逛。', hoursAgo: 3, likes: 14),
    ],
    '11': [
      _c('11', 0, '极光猎人', 'c1101', '等了三天值得！KP指数多少？', hoursAgo: 7, likes: 39),
      _c('11', 1, '北欧摄影', 'c1102', '特罗姆瑟确实是极光最佳观测地之一。', hoursAgo: 6, likes: 44),
      _c('11', 2, '寒带旅人', 'c1103', '绿色光带舞动那张太梦幻了。', hoursAgo: 5, likes: 57),
      _c('11', 3, '冬季旅行', 'c1104', '记得带够保暖装备，夜里非常冷。', hoursAgo: 4, likes: 21),
    ],
    '12': [
      _c('12', 0, '古城漫步', 'c1201', '纳西古乐在四方街附近能听到。', hoursAgo: 5, likes: 17),
      _c('12', 1, '云南旅人', 'c1202', '丽江适合清晨逛，人少景美。', hoursAgo: 4, likes: 25),
    ],
    '13': [
      _c('13', 0, '西北风情', 'c1301', '鸣沙山骑骆驼看日落必体验！', hoursAgo: 8, likes: 36),
      _c('13', 1, '敦煌研究', 'c1302', '建议搭配莫高窟一起安排行程。', hoursAgo: 7, likes: 29),
      _c('13', 2, '沙漠摄影', 'c1303', '金色沙漠配橘红天空，大片！', hoursAgo: 6, likes: 48),
      _c('13', 3, '丝路旅人', 'c1304', '骆驼队那个角度绝了。', hoursAgo: 5, likes: 22),
      _c('13', 4, '大西北', 'c1305', '敦煌昼夜温差大，记得带外套。', hoursAgo: 4, likes: 15),
      _c('13', 5, '户外探险', 'c1306', '滑沙也超好玩，推荐试试！', hoursAgo: 3, likes: 31),
    ],
    '14': [
      _c('14', 0, '魔都夜景', 'c1401', '外滩夜景永远看不腻！', hoursAgo: 4, likes: 33),
    ],
    '15': [
      _c('15', 0, '登山爱好者', 'c1501', '迎客松看日出要凌晨3点出发。', hoursAgo: 7, likes: 28),
      _c('15', 1, '云海摄影', 'c1502', '黄山云海名不虚传，太壮观了。', hoursAgo: 6, likes: 45),
      _c('15', 2, '安徽旅人', 'c1503', '建议山上住一晚，第二天看日出。', hoursAgo: 5, likes: 32),
      _c('15', 3, '户外新手', 'c1504', '爬山累但风景绝对值得！', hoursAgo: 4, likes: 19),
      _c('15', 4, '自然爱好者', 'c1505', '奇松怪石每一帧都是画。', hoursAgo: 3, likes: 37),
    ],
    '16': [],
    '17': [
      _c('17', 0, '江南水乡', 'c1701', '周庄清晨最有韵味，游客也少。', hoursAgo: 5, likes: 24),
      _c('17', 1, '古镇摄影', 'c1702', '双桥是经典机位，建议早去。', hoursAgo: 4, likes: 31),
      _c('17', 2, '苏州旅人', 'c1703', '坐乌篷船听船娘唱小调，太美了。', hoursAgo: 3, likes: 18),
    ],
    '18': [
      _c('18', 0, '川西行者', 'c1801', '牛奶海徒步有点累但美到窒息！', hoursAgo: 8, likes: 42),
      _c('18', 1, '高原摄影', 'c1802', '五色海的颜色会随光线变化。', hoursAgo: 7, likes: 38),
      _c('18', 2, '户外攻略', 'c1803', '亚丁景区建议留至少两天。', hoursAgo: 6, likes: 27),
      _c('18', 3, '香格里拉', 'c1804', '最后的香格里拉，名不虚传！', hoursAgo: 5, likes: 51),
    ],
    '19': [
      _c('19', 0, '海岛度假', 'c1901', '亚龙湾沙细水清，适合带娃。', hoursAgo: 5, likes: 22),
      _c('19', 1, '海鲜控', 'c1902', '第一市场海鲜加工性价比很高。', hoursAgo: 4, likes: 29),
    ],
    '20': [
      _c('20', 0, '历史迷', 'c2001', '兵马俑一号坑最震撼，必看！', hoursAgo: 9, likes: 35),
      _c('20', 1, '西安攻略', 'c2002', '建议请讲解员，了解更深刻。', hoursAgo: 8, likes: 41),
      _c('20', 2, '文化旅行', 'c2003', '两千年前的工艺太精湛了。', hoursAgo: 7, likes: 28),
      _c('20', 3, '博物馆控', 'c2004', '陕西历史博物馆也强烈推荐。', hoursAgo: 6, likes: 33),
      _c('20', 4, '亲子游', 'c2005', '带孩子来很有教育意义。', hoursAgo: 5, likes: 19),
      _c('20', 5, '考古爱好者', 'c2006', '每个俑的表情都不一样，细思极妙。', hoursAgo: 4, likes: 46),
    ],
    '21': [
      _c('21', 0, '雨林探索', 'c2101', '西双版纳早上去雨林，鸟鸣超治愈。', hoursAgo: 4, likes: 20),
    ],
    '22': [],
    '23': [
      _c('23', 0, '杭州土著', 'c2301', '断桥残雪冬天最美，推荐！', hoursAgo: 6, likes: 26),
      _c('23', 1, '西湖十景', 'c2302', '雷峰夕照傍晚去，光线绝了。', hoursAgo: 5, likes: 34),
      _c('23', 2, '江南旅人', 'c2303', '骑行环湖一圈大概两小时。', hoursAgo: 4, likes: 18),
      _c('23', 3, '摄影打卡', 'c2304', '苏堤春晓清晨人最少。', hoursAgo: 3, likes: 29),
      _c('23', 4, '诗意江南', 'c2305', '西湖每一帧都是水墨画。', hoursAgo: 2, likes: 41),
    ],
    '24': [
      _c('24', 0, '天空之镜', 'c2401', '茶卡盐湖要晴天去，倒影才清晰。', hoursAgo: 7, likes: 52),
      _c('24', 1, '青海环线', 'c2402', '青甘大环线上最出片的站点之一。', hoursAgo: 6, likes: 38),
      _c('24', 2, '旅拍达人', 'c2403', '穿红色裙子拍照超好看！', hoursAgo: 5, likes: 61),
    ],
    '25': [
      _c('25', 0, '苗寨旅人', 'c2501', '西江千户苗寨夜景真的像童话。', hoursAgo: 6, likes: 33),
      _c('25', 1, '贵州攻略', 'c2502', '建议住寨子里，体验长桌宴。', hoursAgo: 5, likes: 27),
      _c('25', 2, '民族风', 'c2503', '苗族银饰和吊脚楼太有特色了。', hoursAgo: 4, likes: 42),
      _c('25', 3, '摄影爱好者', 'c2504', '观景台看全景最佳时间是傍晚。', hoursAgo: 3, likes: 35),
    ],
    '26': [
      _c('26', 0, '武夷山茶友', 'c2601', '大红袍景区茶香四溢，太享受了。', hoursAgo: 5, likes: 19),
      _c('26', 1, '茶文化', 'c2602', '九曲溪竹筏漂流也强烈推荐！', hoursAgo: 4, likes: 28),
      _c('26', 2, '福建旅人', 'c2603', '武夷山适合住两晚慢慢品。', hoursAgo: 3, likes: 15),
    ],
    '27': [
      _c('27', 0, '桂林山水', 'c2701', '漓江竹筏从杨堤到兴坪段最美。', hoursAgo: 6, likes: 37),
      _c('27', 1, '山水摄影', 'c2702', '20元人民币背景图就在兴坪！', hoursAgo: 5, likes: 49),
      _c('27', 2, '广西攻略', 'c2703', '遇龙河骑行也是必体验项目。', hoursAgo: 4, likes: 24),
      _c('27', 3, '慢旅行', 'c2704', '桂林山水真的甲天下。', hoursAgo: 3, likes: 31),
    ],
    '28': [
      _c('28', 0, '湘西风情', 'c2801', '凤凰古城夜景的吊脚楼太美了。', hoursAgo: 7, likes: 32),
      _c('28', 1, '沱江漫步', 'c2802', '建议清晨逛古城，人少更有味道。', hoursAgo: 6, likes: 26),
    ],
    '29': [
      _c('29', 0, '丹霞地貌', 'c2901', '张掖七彩丹霞日落时分颜色最艳。', hoursAgo: 8, likes: 44),
      _c('29', 1, '大西北', 'c2902', '4号观景台是最佳拍摄点。', hoursAgo: 7, likes: 38),
      _c('29', 2, '地质爱好者', 'c2903', '像上帝打翻的调色盘！', hoursAgo: 6, likes: 51),
      _c('29', 3, '甘肃环线', 'c2904', '青甘环线上不可错过的一站。', hoursAgo: 5, likes: 29),
      _c('29', 4, '航拍达人', 'c2905', '无人机视角更震撼！', hoursAgo: 4, likes: 42),
    ],
    '30': [
      _c('30', 0, '故宫迷', 'c3001', '太和殿的宏伟只有现场才能感受。', hoursAgo: 9, likes: 36),
      _c('30', 1, '北京攻略', 'c3002', '建议提前网上预约门票。', hoursAgo: 8, likes: 28),
      _c('30', 2, '历史文化', 'c3003', '红墙黄瓦，每一角都是历史。', hoursAgo: 7, likes: 45),
      _c('30', 3, '摄影打卡', 'c3004', '角楼日落是经典机位。', hoursAgo: 6, likes: 33),
      _c('30', 4, '亲子游', 'c3005', '带孩子来了解传统文化很好。', hoursAgo: 5, likes: 22),
      _c('30', 5, '古建爱好者', 'c3006', '故宫四季各有不同的美。', hoursAgo: 4, likes: 39),
    ],
    '31': [
      _c('31', 0, '广州塔', 'c3101', '小蛮腰夜景灯光秀超好看！', hoursAgo: 5, likes: 27),
      _c('31', 1, '粤菜爱好者', 'c3102', '珠江夜游配广州塔，完美组合。', hoursAgo: 4, likes: 21),
    ],
    '32': [
      _c('32', 0, '徽派建筑', 'c3201', '宏村月沼清晨，水墨画本画。', hoursAgo: 6, likes: 40),
      _c('32', 1, '安徽旅人', 'c3202', '建议住一晚，感受古村落的宁静。', hoursAgo: 5, likes: 28),
      _c('32', 2, '写生基地', 'c3203', '美术生都来这儿写生，难怪！', hoursAgo: 4, likes: 34),
    ],
    '33': [
      _c('33', 0, '蓝眼泪', 'c3301', '平潭蓝眼泪季节4-8月，太梦幻了！', hoursAgo: 7, likes: 53),
      _c('33', 1, '海岛控', 'c3302', '北部湾玻璃海也超清澈。', hoursAgo: 6, likes: 31),
      _c('33', 2, '福建海岛', 'c3303', '环岛公路自驾体验很棒。', hoursAgo: 5, likes: 24),
      _c('33', 3, '追光者', 'c3304', '深夜蹲蓝眼泪需要耐心但值得。', hoursAgo: 4, likes: 47),
    ],
    '34': [
      _c('34', 0, '胡杨林', 'c3401', '额济纳胡杨林10月金色最美！', hoursAgo: 8, likes: 38),
      _c('34', 1, '内蒙古', 'c3402', '怪树林日落很有意境。', hoursAgo: 7, likes: 29),
      _c('34', 2, '秋色摄影', 'c3403', '金色胡杨配蓝天，绝配！', hoursAgo: 6, likes: 44),
      _c('34', 3, '自驾旅行', 'c3404', '建议自驾，沿途风景也很棒。', hoursAgo: 5, likes: 22),
      _c('34', 4, '西北秋景', 'c3405', '一年就美这二十天，别错过。', hoursAgo: 4, likes: 36),
    ],
    '35': [
      _c('35', 0, '梅里雪山', 'c3501', '日照金山看到那一刻，值了！', hoursAgo: 9, likes: 48),
      _c('35', 1, '云南深度', 'c3502', '香格里拉建议搭配梅里一起安排。', hoursAgo: 8, likes: 35),
      _c('35', 2, '藏区旅人', 'c3503', '松赞林寺也很值得去。', hoursAgo: 7, likes: 27),
      _c('35', 3, '高原摄影', 'c3504', '雪山、经幡、藏寨，太美了。', hoursAgo: 6, likes: 41),
    ],
    'food_1': [
      _c('food_1', 0, '火锅控', 'f101', '这家牛油锅底确实香！', hoursAgo: 5, likes: 22),
      _c('food_1', 1, '成都土著', 'f102', '宽窄巷子附近好几家都不错。', hoursAgo: 4, likes: 18),
      _c('food_1', 2, '吃货', 'f103', '看饿了，今晚就去！', hoursAgo: 3, likes: 14),
      _c('food_1', 3, '辣不怕', 'f104', '5斤算少的哈哈。', hoursAgo: 2, likes: 26),
    ],
    'food_2': [
      _c('food_2', 0, '早茶达人', 'f201', '一盅两件，广州人的浪漫。', hoursAgo: 6, likes: 31),
      _c('food_2', 1, '虾饺控', 'f202', '虾饺皮要薄才正宗。', hoursAgo: 5, likes: 24),
      _c('food_2', 2, '粤式美食', 'f203', '上下九很多老字号早茶店。', hoursAgo: 4, likes: 19),
    ],
    'couple_1': [
      _c('couple_1', 0, '甜蜜暴击', 'cp101', '太甜了，祝你们幸福！', hoursAgo: 7, likes: 45),
      _c('couple_1', 1, '鼓浪屿', 'cp102', '钢琴博物馆也值得去。', hoursAgo: 6, likes: 28),
      _c('couple_1', 2, '情侣游', 'cp103', '和我男朋友下个月也去！', hoursAgo: 5, likes: 33),
      _c('couple_1', 3, '厦门攻略', 'cp104', '建议住岛内民宿更有感觉。', hoursAgo: 4, likes: 21),
      _c('couple_1', 4, '浪漫旅行', 'cp105', '有你的地方就是最美的风景，好暖。', hoursAgo: 3, likes: 52),
      _c('couple_1', 5, '海蛎煎', 'cp106', '龙头路那家海蛎煎确实好吃！', hoursAgo: 2, likes: 17),
    ],
    'photo_1': [
      _c('photo_1', 0, '风光摄影', 'p101', '天门山云雾机位分享吗？', hoursAgo: 6, likes: 34),
      _c('photo_1', 1, '张家界', 'p102', '玻璃栈道用广角拍更有冲击力。', hoursAgo: 5, likes: 28),
      _c('photo_1', 2, '摄影师', 'p103', '构图和光线都太专业了！', hoursAgo: 4, likes: 41),
      _c('photo_1', 3, '户外摄影', 'p104', '云海天气需要运气和耐心。', hoursAgo: 3, likes: 22),
      _c('photo_1', 4, '旅拍', 'p105', '已收藏，下次去张家界参考。', hoursAgo: 2, likes: 19),
    ],
    'photo_2': [
      _c('photo_2', 0, '天空之镜', 'p201', '茶卡盐湖晴天去倒影才完美。', hoursAgo: 8, likes: 55),
      _c('photo_2', 1, '青海', 'p202', '穿红色拍照超出片！', hoursAgo: 7, likes: 48),
      _c('photo_2', 2, '摄影基地', 'p203', '摄影师必打卡，没错了。', hoursAgo: 6, likes: 62),
      _c('photo_2', 3, '旅拍达人', 'p204', '几点光线最好？', hoursAgo: 5, likes: 31),
      _c('photo_2', 4, '大西北', 'p205', '青甘环线上最美的一站。', hoursAgo: 4, likes: 39),
      _c('photo_2', 5, '盐湖', 'p206', '像走在天空上一样！', hoursAgo: 3, likes: 44),
    ],
    'food_3': [
      _c('food_3', 0, '西安吃货', 'f301', '回民街肉夹馍排队也值得！', hoursAgo: 6, likes: 28),
      _c('food_3', 1, '面食控', 'f302', '外酥里嫩，描述太准确了。', hoursAgo: 5, likes: 22),
      _c('food_3', 2, '美食探店', 'f303', '30年老店确实有实力。', hoursAgo: 4, likes: 35),
      _c('food_3', 3, '肉夹馍', 'f304', '看饿了…', hoursAgo: 3, likes: 16),
      _c('food_3', 4, '西北风味', 'f305', '凉皮搭配肉夹馍绝配！', hoursAgo: 2, likes: 19),
      _c('food_3', 5, '旅行胃', 'f306', '去西安就是为了这一口。', hoursAgo: 1, likes: 24),
    ],
    'food_4': [
      _c('food_4', 0, '甜品脑袋', 'f401', '抹茶千层看起来好好吃！', hoursAgo: 5, likes: 31),
      _c('food_4', 1, '田子坊', 'f402', '这家店叫什么名字？', hoursAgo: 4, likes: 18),
      _c('food_4', 2, '拍照打卡', 'f403', '颜值太高了，必须去！', hoursAgo: 3, likes: 42),
      _c('food_4', 3, '下午茶', 'f404', '马卡龙色彩像艺术品。', hoursAgo: 2, likes: 27),
      _c('food_4', 4, '上海探店', 'f405', '周末就去打卡！', hoursAgo: 1, likes: 15),
    ],
    'food_5': [
      _c('food_5', 0, '海鲜控', 'f501', '青岛海鲜配啤酒，绝配！', hoursAgo: 4, likes: 26),
      _c('food_5', 1, '台东夜市', 'f502', '现捞现做就是新鲜。', hoursAgo: 3, likes: 21),
    ],
    'food_6': [
      _c('food_6', 0, '兰州拉面', 'f601', '一清二白三红四绿，正宗！', hoursAgo: 3, likes: 33),
    ],
    'food_7': [
      _c('food_7', 0, '烧烤党', 'f701', '东北烧烤确实yyds！', hoursAgo: 5, likes: 29),
      _c('food_7', 1, '沈阳美食', 'f702', '中街夜市氛围感拉满。', hoursAgo: 4, likes: 22),
      _c('food_7', 2, '夏日限定', 'f703', '冰啤酒配烤串，夏天的味道。', hoursAgo: 3, likes: 35),
      _c('food_7', 3, '吃货', 'f704', '看饿了，今晚安排！', hoursAgo: 2, likes: 17),
    ],
    'food_8': [
      _c('food_8', 0, '咖啡控', 'f801', '西湖边手冲配湖景，太惬意。', hoursAgo: 4, likes: 24),
      _c('food_8', 1, '杭州慢生活', 'f802', '这家店在哪？求地址。', hoursAgo: 3, likes: 19),
      _c('food_8', 2, '下午茶', 'f803', '这个下午我也想要。', hoursAgo: 2, likes: 28),
    ],
    'couple_2': [
      _c('couple_2', 0, '浪漫巴黎', 'cp201', '巴黎确实是浪漫之都！', hoursAgo: 8, likes: 56),
      _c('couple_2', 1, '铁塔打卡', 'cp202', '埃菲尔铁塔夜景更美。', hoursAgo: 7, likes: 42),
      _c('couple_2', 2, '蜜月计划', 'cp203', '我们的蜜月也想去巴黎！', hoursAgo: 6, likes: 38),
      _c('couple_2', 3, '旅行情侣', 'cp204', '誓言太甜了，祝福！', hoursAgo: 5, likes: 61),
      _c('couple_2', 4, '欧洲游', 'cp205', '建议卢浮宫也安排上。', hoursAgo: 4, likes: 29),
    ],
    'couple_3': [
      _c('couple_3', 0, '丽江情侣', 'cp301', '古城牵手漫步太浪漫了。', hoursAgo: 6, likes: 34),
      _c('couple_3', 1, '纳西古乐', 'cp302', '四方街经常有民间演奏。', hoursAgo: 5, likes: 22),
      _c('couple_3', 2, '恋爱日记', 'cp303', '愿时光不老，你们不散。', hoursAgo: 4, likes: 47),
      _c('couple_3', 3, '云南游', 'cp304', '建议去玉龙雪山拍合照。', hoursAgo: 3, likes: 26),
    ],
    'couple_4': [
      _c('couple_4', 0, '热气球', 'cp401', '卡帕多奇亚热气球太梦幻了！', hoursAgo: 7, likes: 52),
      _c('couple_4', 1, '土耳其', 'cp402', '日出时分颜色最美。', hoursAgo: 6, likes: 38),
      _c('couple_4', 2, '蜜月圣地', 'cp403', '列入我们的蜜月清单！', hoursAgo: 5, likes: 44),
    ],
    'couple_5': [
      _c('couple_5', 0, '海边日落', 'cp501', '亚龙湾日落确实浪漫。', hoursAgo: 5, likes: 31),
      _c('couple_5', 1, '三亚度假', 'cp502', '细沙海风，完美约会地。', hoursAgo: 4, likes: 25),
    ],
    'couple_6': [
      _c('couple_6', 0, '樱花情侣', 'cp601', '京都赏樱太适合情侣了。', hoursAgo: 8, likes: 48),
      _c('couple_6', 1, '和服体验', 'cp602', '粉色花瓣像梦一样。', hoursAgo: 7, likes: 55),
      _c('couple_6', 2, '日本游', 'cp603', '清水寺附近有很多和服店。', hoursAgo: 6, likes: 32),
      _c('couple_6', 3, '赏樱季', 'cp604', '三月底是最佳时间。', hoursAgo: 5, likes: 27),
      _c('couple_6', 4, '甜蜜', 'cp605', '太甜了，祝幸福！', hoursAgo: 4, likes: 41),
      _c('couple_6', 5, '旅拍', 'cp606', '和服合照超出片。', hoursAgo: 3, likes: 36),
    ],
    'couple_7': [
      _c('couple_7', 0, '星空情侣', 'cp701', '特卡波湖观星浪漫到极致！', hoursAgo: 6, likes: 43),
    ],
    'family_1': [
      _c('family_1', 0, '宝妈分享', 'fm101', '迪士尼确实适合带娃！', hoursAgo: 7, likes: 35),
      _c('family_1', 1, '上海亲子', 'fm102', '建议买快速通行证少排队。', hoursAgo: 6, likes: 28),
      _c('family_1', 2, '童话世界', 'fm103', '孩子的笑容最治愈。', hoursAgo: 5, likes: 42),
      _c('family_1', 3, '亲子游', 'fm104', '我们下个月也带孩子去。', hoursAgo: 4, likes: 22),
      _c('family_1', 4, '迪士尼攻略', 'fm105', '烟花秀一定要看！', hoursAgo: 3, likes: 31),
    ],
    'family_2': [
      _c('family_2', 0, '历史启蒙', 'fm201', '带孩子了解历史很有意义。', hoursAgo: 6, likes: 29),
      _c('family_2', 1, '故宫', 'fm202', '建议请儿童讲解员。', hoursAgo: 5, likes: 24),
      _c('family_2', 2, '北京亲子', 'fm203', '孩子看得好认真，好棒。', hoursAgo: 4, likes: 33),
      _c('family_2', 3, '文化旅行', 'fm204', '故宫太大了，分两天逛。', hoursAgo: 3, likes: 18),
    ],
    'family_3': [
      _c('family_3', 0, '长隆亲子', 'fm301', '长颈鹿互动孩子超兴奋！', hoursAgo: 8, likes: 38),
      _c('family_3', 1, '熊猫基地', 'fm302', '大熊猫太可爱了。', hoursAgo: 7, likes: 45),
      _c('family_3', 2, '寓教于乐', 'fm303', '这种亲子游最有价值。', hoursAgo: 6, likes: 27),
      _c('family_3', 3, '野生动物园', 'fm304', '建议早点去，动物更活跃。', hoursAgo: 5, likes: 22),
      _c('family_3', 4, '亲子达人', 'fm305', '已收藏攻略！', hoursAgo: 4, likes: 19),
      _c('family_3', 5, '周末遛娃', 'fm306', '广州长隆值得二刷。', hoursAgo: 3, likes: 31),
    ],
    'family_4': [
      _c('family_4', 0, '海底世界', 'fm401', '海底隧道太震撼了！', hoursAgo: 5, likes: 26),
      _c('family_4', 1, '青岛亲子', 'fm402', '孩子对鲨鱼最感兴趣。', hoursAgo: 4, likes: 21),
      _c('family_4', 2, '海洋馆', 'fm403', '海豚表演别错过。', hoursAgo: 3, likes: 28),
    ],
    'family_5': [
      _c('family_5', 0, '漓江竹筏', 'fm501', '桂林山水最适合亲子游。', hoursAgo: 6, likes: 32),
      _c('family_5', 1, '自然课堂', 'fm502', '山水是最好的教材。', hoursAgo: 5, likes: 24),
    ],
    'family_6': [
      _c('family_6', 0, '科技馆', 'fm601', '互动体验孩子玩疯了！', hoursAgo: 4, likes: 27),
    ],
    'family_7': [
      _c('family_7', 0, '农场体验', 'fm701', '喂小动物孩子超开心。', hoursAgo: 5, likes: 29),
      _c('family_7', 1, '田园生活', 'fm702', '远离城市，享受慢时光。', hoursAgo: 4, likes: 22),
      _c('family_7', 2, '亲子农场', 'fm703', '采摘蔬菜也很有意思。', hoursAgo: 3, likes: 18),
      _c('family_7', 3, '成都周边', 'fm704', '周末好去处，推荐！', hoursAgo: 2, likes: 25),
    ],
    'photo_3': [
      _c('photo_3', 0, '人像摄影', 'p301', '玉龙雪山背景太适合拍人像了。', hoursAgo: 6, likes: 36),
      _c('photo_3', 1, '丽江', 'p302', '光线和色彩确实完美。', hoursAgo: 5, likes: 28),
      _c('photo_3', 2, '雪山', 'p303', '什么镜头拍的？求参数。', hoursAgo: 4, likes: 22),
      _c('photo_3', 3, '旅拍', 'p304', '已收藏机位！', hoursAgo: 3, likes: 19),
    ],
    'photo_4': [
      _c('photo_4', 0, '星空', 'p401', '纳木错拍星空条件太好了。', hoursAgo: 7, likes: 48),
      _c('photo_4', 1, '银河', 'p402', '海拔4718米，致敬！', hoursAgo: 6, likes: 55),
      _c('photo_4', 2, '西藏', 'p403', '摄影师朝圣地没错了。', hoursAgo: 5, likes: 41),
    ],
    'photo_5': [
      _c('photo_5', 0, '城市夜景', 'p501', '外滩夜景经典机位。', hoursAgo: 5, likes: 32),
      _c('photo_5', 1, '建筑摄影', 'p502', '长曝光效果很赞。', hoursAgo: 4, likes: 26),
    ],
    'photo_6': [
      _c('photo_6', 0, '黄山日出', 'p601', '凌晨4点爬山太拼了！', hoursAgo: 8, likes: 38),
      _c('photo_6', 1, '云海', 'p602', '黄山云海名不虚传。', hoursAgo: 7, likes: 45),
      _c('photo_6', 2, '日出摄影', 'p603', '所有辛苦都值得。', hoursAgo: 6, likes: 52),
      _c('photo_6', 3, '登山', 'p604', '迎客松机位分享吗？', hoursAgo: 5, likes: 29),
      _c('photo_6', 4, '自然', 'p605', '每一帧都是大片。', hoursAgo: 4, likes: 37),
      _c('photo_6', 5, '户外', 'p606', '已加入计划清单。', hoursAgo: 3, likes: 24),
    ],
    'photo_7': [
      _c('photo_7', 0, '古镇', 'p701', '周庄水乡韵味十足。', hoursAgo: 4, likes: 28),
    ],
    'photo_8': [
      _c('photo_8', 0, '极光', 'p801', '等了三天太值了！', hoursAgo: 9, likes: 58),
      _c('photo_8', 1, '挪威', 'p802', '特罗姆瑟极光爆发太震撼。', hoursAgo: 8, likes: 62),
      _c('photo_8', 2, '摄影', 'p803', '参数能分享一下吗？', hoursAgo: 7, likes: 35),
      _c('photo_8', 3, '北极光', 'p804', '绿色光带美到窒息。', hoursAgo: 6, likes: 49),
      _c('photo_8', 4, '冬季', 'p805', '保暖装备清单求分享。', hoursAgo: 5, likes: 27),
    ],
  };

  static List<Comment> getForPost(String postId) {
    return (_data[postId] ?? []).map((comment) {
      return Comment(
        id: comment.id,
        user: comment.user,
        avatar: comment.avatar,
        content: comment.content,
        timestamp: comment.timestamp,
        likes: comment.likes,
        isLiked: comment.isLiked,
      );
    }).toList();
  }

  static int countForPost(String postId) => getForPost(postId).length;
}
