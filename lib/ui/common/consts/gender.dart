enum Gender {
  male(title: '남성'),
  female(title: '여성');

  const Gender({
    required this.title,
  });

  final String title;
}
