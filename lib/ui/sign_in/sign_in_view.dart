import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/loading_status.dart';
import '../../routes/routes.dart';
import '../../theme/doit_color_theme.dart';
import '../../theme/doit_typos.dart';
import '../common/consts/assets.dart';
import 'sign_in_state.dart';
import 'sign_in_view_model.dart';

class SignInView extends ConsumerWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;

    final SignInState state = ref.watch(signInViewModelProvider);

    final SignInViewModel viewModel =
        ref.read(signInViewModelProvider.notifier);

    ref.listen(
        signInViewModelProvider
            .select((SignInState state) => state.kakaoOauthLoadingStatus),
        (LoadingStatus? previous, LoadingStatus next) {
      if (next == LoadingStatus.success) {
        if (ref.read(signInViewModelProvider).needOnboarding) {
          context.goNamed(Routes.onboardingStart.name);
        } else {
          context.goNamed(Routes.home.name);
        }
      }
    });

    return Scaffold(
      backgroundColor: doitColorTheme.background,
      body: Stack(
        children: <Widget>[
          DecoratedBox(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Assets.loginBackground), fit: BoxFit.cover),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'DOIT',
                  style: DoitTypos.tenadaEB20
                      .copyWith(fontSize: 56, color: doitColorTheme.main),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 168,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: InkWell(
                    onTap: viewModel.signInWithKakao,
                    child: Image.asset(Assets.kakaoLogin),
                  ),
                ),
              ],
            ),
          ),
          if (state.kakaoOauthLoadingStatus == LoadingStatus.loading)
            ColoredBox(
              color: Colors.black38,
              child: Center(
                child: CircularProgressIndicator(
                  color: doitColorTheme.main,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
