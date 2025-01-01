import 'package:equatable/equatable.dart';
import '../../core/loading_status.dart';

class SignInState extends Equatable {
  final LoadingStatus kakaoOauthLoadingStatus;

  const SignInState({
    required this.kakaoOauthLoadingStatus,
  });

  const SignInState.init() : kakaoOauthLoadingStatus = LoadingStatus.none;

  SignInState copyWith({
    LoadingStatus? kakaoOauthLoadingStatus,
  }) =>
      SignInState(
        kakaoOauthLoadingStatus:
            kakaoOauthLoadingStatus ?? this.kakaoOauthLoadingStatus,
      );

  @override
  List<Object> get props => <Object>[
        kakaoOauthLoadingStatus,
      ];
}
