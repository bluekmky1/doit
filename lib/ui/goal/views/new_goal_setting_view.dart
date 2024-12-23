import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/routes.dart';
import '../../../theme/doit_color_theme.dart';
import '../../../theme/doit_typos.dart';
import '../../common/widgets/outlined_text_field_widget.dart';
import '../../onboarding/widgets/goal_suggestion_widget.dart';
import '../goal_state.dart';
import '../goal_view_model.dart';

class NewGoalSettingView extends ConsumerStatefulWidget {
  const NewGoalSettingView({super.key});

  @override
  ConsumerState<NewGoalSettingView> createState() => _NewGoalSettingViewState();
}

class _NewGoalSettingViewState extends ConsumerState<NewGoalSettingView> {
  final TextEditingController goalForUserInputController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    final GoalState state = ref.read(goalViewModelProvider);
    goalForUserInputController.text = state.goalForUser;
  }

  @override
  void dispose() {
    goalForUserInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GoalState state = ref.watch(goalViewModelProvider);
    final GoalViewModel viewModel = ref.read(goalViewModelProvider.notifier);

    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;

    ref.listen(
        goalViewModelProvider.select(
          (GoalState value) => value.goalForUserInput,
        ), (String? prev, String next) {
      if (prev != next && next.isEmpty) {
        goalForUserInputController.clear();
      }
    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.goNamed(Routes.home.name);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        scrolledUnderElevation: 0,
        backgroundColor: doitColorTheme.background,
      ),
      bottomNavigationBar: SizedBox(
        height: 64,
        width: double.infinity,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: state.isGoalForUserValid
                ? doitColorTheme.main
                : doitColorTheme.gray20,
            foregroundColor: state.isGoalForUserValid
                ? doitColorTheme.background
                : doitColorTheme.gray80,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            padding: EdgeInsets.zero,
          ),
          onPressed: state.isGoalForUserValid
              ? () {
                  context.pushNamed(Routes.goalDurationSetting.name);
                }
              : null,
          child: Text(
            '목표 설정 완료',
            style: DoitTypos.suitSB20.copyWith(),
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
                    controller: goalForUserInputController,
                    enabled: !state.recommendedGoal.contains(state.goalForUser),
                    height: 52,
                    hintText: '예) 매일 30분씩 명상하기',
                    hintStyle: DoitTypos.suitR12.copyWith(
                      color: doitColorTheme.gray40,
                      height: 2,
                    ),
                    onChanged: (String value) {
                      viewModel.changeGoalForUserInput(goalForUserInput: value);
                    },
                    textAlign: TextAlign.start,
                  ),

                  const SizedBox(height: 32),
                  const Text(
                    '아직 고민 중이시라면이런 목표에 도전해보세요!',
                    style: DoitTypos.suitR16,
                  ),
                  const SizedBox(height: 10),
                  ...state.recommendedGoal.map(
                    (String goal) => GoalSuggestionWidget(
                      title: goal,
                      isChecked: state.goalForUser == goal,
                      onPressedCheck: () {
                        goalForUserInputController.clear();
                        viewModel.selectGoalForUser(goalForUser: goal);
                      },
                    ),
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
                            '새롭게 이루고 싶은\n목표는 무엇인가요?',
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
