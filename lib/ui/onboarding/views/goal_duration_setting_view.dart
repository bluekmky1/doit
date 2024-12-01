import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/routes.dart';
import '../../../theme/doit_color_theme.dart';
import '../../../theme/doit_typos.dart';
import '../../common/widgets/outlined_text_field_widget.dart';
import '../onboarding_state.dart';
import '../onboarding_view_model.dart';
import '../widgets/onboarding_app_bar.dart';

class GoalDurationSettingView extends ConsumerStatefulWidget {
  const GoalDurationSettingView({super.key});

  @override
  ConsumerState<GoalDurationSettingView> createState() =>
      _GoalDurationSettingViewState();
}

class _GoalDurationSettingViewState
    extends ConsumerState<GoalDurationSettingView> {
  final TextEditingController startYearInputController =
      TextEditingController();
  final TextEditingController startMonthInputController =
      TextEditingController();
  final TextEditingController startDayInputController = TextEditingController();
  final TextEditingController endYearInputController = TextEditingController();
  final TextEditingController endMonthInputController = TextEditingController();
  final TextEditingController endDayInputController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final OnboardingState state = ref.read(onboardingViewModelProvider);
      startYearInputController.text = state.startYear;
      startMonthInputController.text = state.startMonth;
      startDayInputController.text = state.startDay;
      endYearInputController.text = state.endYear;
      endMonthInputController.text = state.endMonth;
      endDayInputController.text = state.endDay;
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    startYearInputController.dispose();
    startMonthInputController.dispose();
    startDayInputController.dispose();
    endYearInputController.dispose();
    endMonthInputController.dispose();
    endDayInputController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final OnboardingState state = ref.watch(onboardingViewModelProvider);
    final OnboardingViewModel viewModel =
        ref.read(onboardingViewModelProvider.notifier);

    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;

    return Scaffold(
      appBar: OnboardingAppBar(
        pageController: PageController(initialPage: 3),
      ),
      bottomNavigationBar: SizedBox(
        height: 64,
        width: double.infinity,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: state.isDurationValid
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
          onPressed: state.isDurationValid
              ? () {
                  context.goNamed(Routes.tutorial.name);
                }
              : null,
          child: Text(
            '기간 설정 완료',
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
                  const SizedBox(height: 156),
                  const Text(
                    '도전할 목표',
                    style: DoitTypos.suitSB16,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      color: Colors.white,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          blurRadius: 10.0,
                          color: doitColorTheme.shadow2.withOpacity(0.2),
                        )
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            state.goalForUser,
                            style: DoitTypos.suitSB16.copyWith(
                              color: doitColorTheme.main,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        '도전을 시작할 날짜를 정해주세요',
                        style: DoitTypos.suitSB16,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          foregroundColor: doitColorTheme.main,
                          visualDensity: VisualDensity.compact,
                        ),
                        onPressed: () {
                          final DateTime today = DateTime.now();
                          viewModel
                            ..changeGoalStartYear(
                              startYear: today.year.toString(),
                            )
                            ..changeGoalStartMonth(
                              startMonth: today.month.toString(),
                            )
                            ..changeGoalStartDay(
                              startDay: today.day.toString(),
                            );
                          startYearInputController.text = today.year.toString();
                          startMonthInputController.text =
                              today.month.toString();
                          startDayInputController.text = today.day.toString();
                        },
                        child: const Text(
                          '오늘부터',
                          style: DoitTypos.suitR14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 68,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: OutlinedTextFieldWidget(
                            controller: startYearInputController,
                            hintText: 'YYYY',
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            maxLength: 4,
                            onChanged: (String value) {
                              viewModel.changeGoalStartYear(
                                startYear: value,
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: OutlinedTextFieldWidget(
                                  controller: startMonthInputController,
                                  hintText: 'MM',
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  maxLength: 2,
                                  onChanged: (String value) {
                                    viewModel.changeGoalStartMonth(
                                      startMonth: value,
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: OutlinedTextFieldWidget(
                                  controller: startDayInputController,
                                  hintText: 'DD',
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  maxLength: 2,
                                  onChanged: (String value) {
                                    viewModel.changeGoalStartDay(
                                      startDay: value,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    '도전이 끝날 날짜를 정해주세요',
                    style: DoitTypos.suitSB16,
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 78,
                    child: Stack(
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: OutlinedTextFieldWidget(
                                controller: endYearInputController,
                                hintText: 'YYYY',
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                maxLength: 4,
                                onChanged: (String value) {
                                  viewModel.changeGoalEndYear(
                                    endYear: value,
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: OutlinedTextFieldWidget(
                                      controller: endMonthInputController,
                                      hintText: 'MM',
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      maxLength: 2,
                                      onChanged: (String value) {
                                        viewModel.changeGoalEndMonth(
                                          endMonth: value,
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: OutlinedTextFieldWidget(
                                      controller: endDayInputController,
                                      hintText: 'DD',
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      maxLength: 2,
                                      onChanged: (String value) {
                                        viewModel.changeGoalEndDay(
                                          endDay: value,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (state.isStartDateValid)
                          Positioned(
                            bottom: 0,
                            child: Wrap(
                              spacing: 8,
                              children: <Widget>[
                                TextButton(
                                  style: TextButton.styleFrom(
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    padding: EdgeInsets.zero,
                                    visualDensity: VisualDensity.compact,
                                    foregroundColor: doitColorTheme.main,
                                  ),
                                  onPressed: () {
                                    final DateTime startDate = DateTime(
                                      int.parse(state.startYear),
                                      int.parse(state.startMonth),
                                      int.parse(state.startDay),
                                    );
                                    final DateTime sevenDaysLater =
                                        startDate.add(const Duration(days: 7));
                                    viewModel
                                      ..changeGoalEndYear(
                                        endYear: sevenDaysLater.year.toString(),
                                      )
                                      ..changeGoalEndMonth(
                                        endMonth:
                                            sevenDaysLater.month.toString(),
                                      )
                                      ..changeGoalEndDay(
                                        endDay: sevenDaysLater.day.toString(),
                                      );
                                    endYearInputController.text =
                                        sevenDaysLater.year.toString();
                                    endMonthInputController.text =
                                        sevenDaysLater.month.toString();
                                    endDayInputController.text =
                                        sevenDaysLater.day.toString();
                                  },
                                  child: const Text(
                                    '7일 후',
                                    style: DoitTypos.suitR14,
                                  ),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    padding: EdgeInsets.zero,
                                    visualDensity: VisualDensity.compact,
                                    foregroundColor: doitColorTheme.main,
                                  ),
                                  onPressed: () {
                                    final DateTime startDate = DateTime(
                                      int.parse(state.startYear),
                                      int.parse(state.startMonth),
                                      int.parse(state.startDay),
                                    );
                                    final DateTime twoWeeksLater =
                                        startDate.add(const Duration(days: 14));
                                    viewModel
                                      ..changeGoalEndYear(
                                        endYear: twoWeeksLater.year.toString(),
                                      )
                                      ..changeGoalEndMonth(
                                        endMonth:
                                            twoWeeksLater.month.toString(),
                                      )
                                      ..changeGoalEndDay(
                                        endDay: twoWeeksLater.day.toString(),
                                      );
                                    endYearInputController.text =
                                        twoWeeksLater.year.toString();
                                    endMonthInputController.text =
                                        twoWeeksLater.month.toString();
                                    endDayInputController.text =
                                        twoWeeksLater.day.toString();
                                  },
                                  child: const Text(
                                    '14일 후',
                                    style: DoitTypos.suitR14,
                                  ),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    padding: EdgeInsets.zero,
                                    foregroundColor: doitColorTheme.main,
                                    visualDensity: VisualDensity.compact,
                                  ),
                                  onPressed: () {
                                    final DateTime startDate = DateTime(
                                      int.parse(state.startYear),
                                      int.parse(state.startMonth),
                                      int.parse(state.startDay),
                                    );
                                    final DateTime oneMonthLater =
                                        startDate.add(const Duration(days: 30));
                                    viewModel
                                      ..changeGoalEndYear(
                                        endYear: oneMonthLater.year.toString(),
                                      )
                                      ..changeGoalEndMonth(
                                        endMonth:
                                            oneMonthLater.month.toString(),
                                      )
                                      ..changeGoalEndDay(
                                        endDay: oneMonthLater.day.toString(),
                                      );
                                    endYearInputController.text =
                                        oneMonthLater.year.toString();
                                    endMonthInputController.text =
                                        oneMonthLater.month.toString();
                                    endDayInputController.text =
                                        oneMonthLater.day.toString();
                                  },
                                  child: const Text(
                                    '30일 후',
                                    style: DoitTypos.suitR14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 132,
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
                            '목표에 도전할\n기간을 정해주세요',
                            style: DoitTypos.suitSB20.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 28,
                              height: 1.4,
                              color: doitColorTheme.main,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '목표에 도전할 기간을 정해주세요!',
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
