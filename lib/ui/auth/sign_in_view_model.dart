import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/loading_status.dart';
import '../../service/supabase_service.dart';
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

    _supabaseClient.auth.onAuthStateChange.listen((AuthState data) {
      if (data.event == AuthChangeEvent.signedIn) {
        state = state.copyWith(
          kakaoOauthLoadingStatus: LoadingStatus.success,
        );
      }
    });
  }
}
