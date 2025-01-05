enum AmPm {
  am(title: '오전'),
  pm(title: '오후');

  const AmPm({
    required this.title,
  });

  final String title;

  static AmPm fromString(String name) => switch (name.toLowerCase()) {
        '오전' || 'am' => AmPm.am,
        '오후' || 'pm' => AmPm.pm,
        _ => throw ArgumentError('Unknown am/pm: $name'),
      };
}
