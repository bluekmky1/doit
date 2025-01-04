import 'package:equatable/equatable.dart';
import '../../core/loading_status.dart';

class SignInState extends Equatable {
  final LoadingStatus kakaoOauthLoadingStatus;
  final bool needOnboarding;

  const SignInState({
    required this.kakaoOauthLoadingStatus,
    required this.needOnboarding,
  });

  const SignInState.init()
      : kakaoOauthLoadingStatus = LoadingStatus.none,
        needOnboarding = false;

  SignInState copyWith({
    LoadingStatus? kakaoOauthLoadingStatus,
    bool? needOnboarding,
  }) =>
      SignInState(
        kakaoOauthLoadingStatus:
            kakaoOauthLoadingStatus ?? this.kakaoOauthLoadingStatus,
        needOnboarding: needOnboarding ?? this.needOnboarding,
      );

  @override
  List<Object> get props => <Object>[
        kakaoOauthLoadingStatus,
        needOnboarding,
      ];
}
