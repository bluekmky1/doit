enum Gender {
  male(title: '남성'),
  female(title: '여성');

  const Gender({
    required this.title,
  });

  final String title;

  static Gender fromString(String name) => switch (name.toLowerCase()) {
        '남성' => Gender.male,
        '여성' => Gender.female,
        _ => throw ArgumentError('Unknown gender: $name'),
      };
}
