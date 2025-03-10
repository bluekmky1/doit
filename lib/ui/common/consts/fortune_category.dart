import 'assets.dart';

enum FortuneCategory {
  total(
    imageAssetName: Assets.allLuck,
    selectedIconName: Assets.chartFilled,
    unselectedIconName: Assets.chartOutlined,
    title: '총운',
  ),
  love(
    imageAssetName: Assets.love,
    unselectedIconName: Assets.heartOutlined,
    selectedIconName: Assets.heartFilled,
    title: '애정운',
  ),
  money(
    imageAssetName: Assets.money,
    selectedIconName: Assets.pigFilled,
    unselectedIconName: Assets.pigOutlined,
    title: '금전운',
  ),
  job(
    imageAssetName: Assets.workPlace,
    selectedIconName: Assets.buildingFilled,
    unselectedIconName: Assets.buildingOutlined,
    title: '직장운',
  ),
  study(
    imageAssetName: Assets.study,
    selectedIconName: Assets.bookFilled,
    unselectedIconName: Assets.bookOutlined,
    title: '학업운',
  ),
  health(
    imageAssetName: Assets.health,
    selectedIconName: Assets.healthFilled,
    unselectedIconName: Assets.healthOutlined,
    title: '건강운',
  );

  static FortuneCategory fromString(String category) {
    switch (category) {
      case 'total':
        return FortuneCategory.total;
      case 'love':
        return FortuneCategory.love;
      case 'money':
        return FortuneCategory.money;
      case 'job':
        return FortuneCategory.job;
      case 'study':
        return FortuneCategory.study;
      case 'health':
        return FortuneCategory.health;
      default:
        throw Exception('Invalid category: $category');
    }
  }

  const FortuneCategory({
    required this.imageAssetName,
    required this.title,
    required this.selectedIconName,
    required this.unselectedIconName,
  });

  final String imageAssetName;
  final String selectedIconName;
  final String unselectedIconName;
  final String title;
}
