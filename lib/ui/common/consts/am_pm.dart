enum AmPm {
  am(title: '오전'),
  pm(title: '오후');

  const AmPm({
    required this.title,
  });

  final String title;
}
