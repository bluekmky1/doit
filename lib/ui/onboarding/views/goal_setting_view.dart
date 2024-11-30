import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/routes.dart';
import '../../../theme/doit_color_theme.dart';
import '../../../theme/doit_typos.dart';
import '../../common/widgets/outlined_text_field_widget.dart';
import '../widgets/goal_suggestion_widget.dart';
import '../widgets/onboarding_app_bar.dart';

class GoalSettingView extends ConsumerWidget {
  const GoalSettingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;
    return Scaffold(
      appBar: OnboardingAppBar(
        pageController: PageController(initialPage: 2),
      ),
      bottomNavigationBar: SizedBox(
        height: 64,
        width: double.infinity,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: doitColorTheme.main,
            foregroundColor: doitColorTheme.background,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            padding: EdgeInsets.zero,
          ),
          onPressed: () {
            context.pushNamed(Routes.onboardingUserProfileInput.name);
          },
          child: Text(
            '목표 설정 완료',
            style: DoitTypos.suitSB20.copyWith(
              color: doitColorTheme.background,
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 186),
                  // 목표 입력 섹션
                  const Text(
                    '이루고 싶은 목표를 적어주세요',
                    style: DoitTypos.suitR16,
                  ),
                  const SizedBox(height: 10),
                  OutlinedTextFieldWidget(
                    height: 52,
                    hintText: '예) 매일 30분씩 명상하기',
                    hintStyle: DoitTypos.suitR12.copyWith(
                      color: doitColorTheme.gray40,
                      height: 2,
                    ),
                    onChanged: (String value) {},
                    textAlign: TextAlign.start,
                  ),

                  const SizedBox(height: 32),
                  const Text(
                    '아직 고민 중이시라면이런 목표에 도전해보세요!',
                    style: DoitTypos.suitR16,
                  ),
                  const SizedBox(height: 10),
                  GoalSuggestionWidget(
                    title: '긍정적인 사람 되어보기',
                    isChecked: false,
                    onPressedCheck: () {},
                  ),
                  GoalSuggestionWidget(
                    title: '긍정적인 사람 되어보기',
                    isChecked: false,
                    onPressedCheck: () {},
                  ),
                  GoalSuggestionWidget(
                    title: '긍정적인 사람 되어보기',
                    isChecked: false,
                    onPressedCheck: () {},
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 162,
                decoration: BoxDecoration(
                  color: doitColorTheme.background,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(16),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: doitColorTheme.shadow2.withOpacity(0.2),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '이루고 싶은 목표는\n무엇인가요?',
                            style: DoitTypos.suitSB20.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 28,
                              height: 1.4,
                              color: doitColorTheme.main,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text.rich(
                            TextSpan(
                              text: '마재훈',
                              style: DoitTypos.suitSB16,
                              children: <InlineSpan>[
                                TextSpan(
                                  text: '님이 목표에 한발짝 더\n'
                                      '가까워질 수 있도록 도와드릴게요!',
                                  style: DoitTypos.suitR16,
                                ),
                              ],
                            ),
                            style: DoitTypos.suitR16,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
