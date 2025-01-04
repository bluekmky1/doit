import 'package:equatable/equatable.dart';

class AnimalMarkerModel extends Equatable {
  final String name;
  final int count;

  const AnimalMarkerModel({
    required this.name,
    required this.count,
  });

  AnimalMarkerModel copyWith({
    int? count,
  }) =>
      AnimalMarkerModel(
        name: name,
        count: count ?? this.count,
      );

  @override
  List<Object> get props => <Object>[name, count];
}
