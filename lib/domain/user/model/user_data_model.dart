import 'package:equatable/equatable.dart';

import '../../../data/user/entity/user_data_entity.dart';

class UserDataModel extends Equatable {
  final String id;
  final String nickname;
  final String gender;
  final String lunarSolar;
  final DateTime birthDate;
  final bool consent;
  final bool unknownBirthTime;

  const UserDataModel({
    required this.id,
    required this.nickname,
    required this.gender,
    required this.lunarSolar,
    required this.birthDate,
    required this.consent,
    required this.unknownBirthTime,
  });

  UserDataModel copyWith({
    String? id,
    String? nickname,
    String? gender,
    String? lunarSolar,
    DateTime? birthDate,
    bool? consent,
    bool? unknownBirthTime,
  }) =>
      UserDataModel(
        id: id ?? this.id,
        nickname: nickname ?? this.nickname,
        gender: gender ?? this.gender,
        lunarSolar: lunarSolar ?? this.lunarSolar,
        birthDate: birthDate ?? this.birthDate,
        consent: consent ?? this.consent,
        unknownBirthTime: unknownBirthTime ?? this.unknownBirthTime,
      );

  factory UserDataModel.fromEntity(UserDataEntity entity) => UserDataModel(
        id: entity.userId,
        nickname: entity.nickname,
        gender: entity.gender,
        lunarSolar: entity.lunarSolar,
        birthDate: entity.birthDate,
        consent: entity.consent,
        unknownBirthTime: entity.unknownBirthTime,
      );

  @override
  List<Object?> get props => <Object?>[
        id,
        nickname,
        gender,
        lunarSolar,
        birthDate,
        consent,
        unknownBirthTime,
      ];
}
