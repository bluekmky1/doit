enum LunarSolar {
  lunar(title: '음력'),
  solar(title: '양력');

  const LunarSolar({
    required this.title,
  });

  final String title;

  static LunarSolar fromString(String name) => switch (name.toLowerCase()) {
        '음력' => LunarSolar.lunar,
        '양력' => LunarSolar.solar,
        _ => throw ArgumentError('Unknown lunar/solar: $name'),
      };
}
