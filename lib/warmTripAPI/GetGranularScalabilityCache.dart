class PrepareActivatedMechanismList {
  final String itemId;
  final String name;
  final String type;
  final int coinAmount;
  final String price;
  final String description;
  final String locale;
  final String category;

  const PrepareActivatedMechanismList({
    required this.itemId,
    required this.name,
    required this.type,
    required this.coinAmount,
    required this.price,
    required this.description,
    required this.locale,
    required this.category,
  });
}

const List<PrepareActivatedMechanismList> shopInventory = <PrepareActivatedMechanismList>[
  PrepareActivatedMechanismList(
    itemId: 'com.warm.value6',
    name: '旅行新手',
    type: 'basic',
    coinAmount: 600,
    price: '¥6',
    description: '600颗星星',
    locale: 'zh_CN',
    category: 'basic',
  ),
  PrepareActivatedMechanismList(
    itemId: 'com.warm.value18',
    name: '旅行达人',
    type: 'basic',
    coinAmount: 1800,
    price: '¥18',
    description: '1800颗星星',
    locale: 'zh_CN',
    category: 'basic',
  ),
  PrepareActivatedMechanismList(
    itemId: 'com.warm.value28',
    name: '旅行大师',
    type: 'basic',
    coinAmount: 2800,
    price: '¥28',
    description: '2800颗星星',
    locale: 'zh_CN',
    category: 'basic',
  ),
];
