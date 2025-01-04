import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/loading_status.dart';
import '../../service/supabase/supabase_service.dart';
import 'sign_in_state.dart';

final AutoDisposeStateNotifierProvider<SignInViewModel, SignInState>
    signInViewModelProvider = StateNotifierProvider.autoDispose(
  (Ref ref) => SignInViewModel(
    state: const SignInState.init(),
    supabaseClient: ref.read(supabaseServiceProvider),
  ),
);

class SignInViewModel extends StateNotifier<SignInState> {
  final SupabaseClient _supabaseClient;

  SignInViewModel({
    required SignInState state,
    required SupabaseClient supabaseClient,
  })  : _supabaseClient = supabaseClient,
        super(state);

  Future<void> signInWithKakao() async {
    state = state.copyWith(
      kakaoOauthLoadingStatus: LoadingStatus.loading,
    );

    await _supabaseClient.auth.signInWithOAuth(
      OAuthProvider.kakao,
      redirectTo: 'kakao0285681c4077c794d47f025055eedcd8://oauth',
    );

    _supabaseClient.auth.onAuthStateChange.listen((AuthState data) async {
      if (data.event == AuthChangeEvent.signedIn) {
        // supabase의 다른 테이블에 userId가 있는지 확인
        final User? user = _supabaseClient.auth.currentUser;

        if (user != null) {
          final PostgrestList userData = await _supabaseClient
              .from('user')
              .select()
              .eq('user_id', user.id);

          // 유저 데이터가 없으면 온보딩 페이지로 이동
          if (userData.isEmpty) {
            state = state.copyWith(
              needOnboarding: true,
              kakaoOauthLoadingStatus: LoadingStatus.success,
            );
          }

          // 유저 데이터가 있으면 로그인 성공
          state = state.copyWith(
            kakaoOauthLoadingStatus: LoadingStatus.success,
          );
        }
      } else {
        state = state.copyWith(
          kakaoOauthLoadingStatus: LoadingStatus.error,
        );
      }
    });
  }
}
