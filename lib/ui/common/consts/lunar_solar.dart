enum LunarSolar {
  lunar(title: '음력'),
  solar(title: '양력');

  const LunarSolar({
    required this.title,
  });

  final String title;
}
