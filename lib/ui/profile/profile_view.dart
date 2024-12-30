import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/routes.dart';
import '../../../theme/doit_color_theme.dart';
import '../../../theme/doit_typos.dart';

import '../common/consts/am_pm.dart';
import '../common/consts/assets.dart';
import '../common/consts/gender.dart';
import '../common/consts/lunar_solar.dart';
import '../common/widgets/outlined_text_field_widget.dart';
import 'profile_state.dart';
import 'profile_view_model.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({
    super.key,
  });

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  final ScrollController scrollController = ScrollController();

  final TextEditingController birthYearInputController =
      TextEditingController();
  final TextEditingController birthMonthInputController =
      TextEditingController();
  final TextEditingController birthDayInputController = TextEditingController();
  final TextEditingController birthHourInputController =
      TextEditingController();
  final TextEditingController birthMinuteInputController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    final ProfileState state = ref.read(profileViewModelProvider);
    birthYearInputController.text = state.birthYear;
    birthMonthInputController.text = state.birthMonth;
    birthDayInputController.text = state.birthDay;
    birthHourInputController.text = state.birthHour;
    birthMinuteInputController.text = state.birthMinute;
  }

  @override
  void dispose() {
    scrollController.dispose();
    birthYearInputController.dispose();
    birthMonthInputController.dispose();
    birthDayInputController.dispose();
    birthHourInputController.dispose();
    birthMinuteInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ProfileState state = ref.watch(profileViewModelProvider);

    final ProfileViewModel viewModel =
        ref.read(profileViewModelProvider.notifier);

    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: doitColorTheme.background,
        scrolledUnderElevation: 0,
      ),
      bottomNavigationBar: SizedBox(
        height: 64,
        width: double.infinity,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: state.isAllFormValid
                ? doitColorTheme.main
                : doitColorTheme.gray20,
            foregroundColor: state.isAllFormValid
                ? doitColorTheme.background
                : doitColorTheme.gray80,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            padding: EdgeInsets.zero,
          ),
          onPressed: state.isAllFormValid
              ? () {
                  context.goNamed(Routes.my.name);
                }
              : null,
          child: Text(
            '입력완료',
            style: DoitTypos.suitR20.copyWith(
              color: state.isAllFormValid
                  ? doitColorTheme.background
                  : doitColorTheme.gray80,
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 160),
                        const Text(
                          '성별',
                          style: DoitTypos.suitSB16,
                        ),
                        const SizedBox(height: 8),
                        ChoiceButtonsWiget(
                          isFirstSelected: state.gender == Gender.male,
                          firstText: '남성',
                          secondText: '여성',
                          onPressedFirst: () {
                            viewModel.changeGender(gender: Gender.male);
                          },
                          onPressedSecond: () {
                            viewModel.changeGender(gender: Gender.female);
                          },
                        ),
                        const SizedBox(height: 48),
                        const Text(
                          '생년월일',
                          style: DoitTypos.suitSB16,
                        ),
                        const SizedBox(height: 8),
                        ChoiceButtonsWiget(
                          isFirstSelected: state.lunarSolar == LunarSolar.solar,
                          firstText: '양력',
                          secondText: '음력',
                          onPressedFirst: () {
                            viewModel.changeLunarSolar(
                                lunarSolar: LunarSolar.solar);
                          },
                          onPressedSecond: () {
                            viewModel.changeLunarSolar(
                                lunarSolar: LunarSolar.lunar);
                          },
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 68,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: OutlinedTextFieldWidget(
                                  controller: birthYearInputController,
                                  hintText: 'YYYY',
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  errorText:
                                      state.birthYearError.isEmpty ? null : '',
                                  maxLength: 4,
                                  onChanged: (String value) {
                                    viewModel.changeBirthYear(birthYear: value);
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
                                        controller: birthMonthInputController,
                                        hintText: 'MM',
                                        errorText: state.birthMonthError.isEmpty
                                            ? null
                                            : '',
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                        maxLength: 2,
                                        onChanged: (String value) {
                                          viewModel.changeBirthMonth(
                                            birthMonth: value,
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: OutlinedTextFieldWidget(
                                        controller: birthDayInputController,
                                        hintText: 'DD',
                                        errorText: state.birthDayError.isEmpty
                                            ? null
                                            : '',
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                        maxLength: 2,
                                        onChanged: (String value) {
                                          viewModel.changeBirthDay(
                                            birthDay: value,
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
                        const SizedBox(height: 37),
                        const Text(
                          '태어난 시간',
                          style: DoitTypos.suitSB16,
                        ),
                        const SizedBox(height: 8),
                        Stack(
                          children: <Widget>[
                            SizedBox(
                              height: 68,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: ChoiceButtonsWiget(
                                      enabled: !state.isBirthDateUnknown,
                                      isFirstSelected: state.amPm == AmPm.am,
                                      firstText: 'AM',
                                      secondText: 'PM',
                                      onPressedFirst: () {
                                        viewModel.changeAmPm(amPm: AmPm.am);
                                      },
                                      onPressedSecond: () {
                                        viewModel.changeAmPm(amPm: AmPm.pm);
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: OutlinedTextFieldWidget(
                                            controller:
                                                birthHourInputController,
                                            hintText: 'HH',
                                            errorText:
                                                state.birthHourError.isEmpty
                                                    ? null
                                                    : '',
                                            enabled: !state.isBirthDateUnknown,
                                            // ignore: lines_longer_than_80_chars
                                            inputFormatters: <TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                            ],
                                            maxLength: 2,
                                            onChanged: (String value) {
                                              viewModel.changeBirthHour(
                                                birthHour: value,
                                              );
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4),
                                          child: Text(
                                            ':',
                                            style: DoitTypos.suitR20.copyWith(
                                              color: doitColorTheme.gray60,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: OutlinedTextFieldWidget(
                                            controller:
                                                birthMinuteInputController,
                                            // ignore: lines_longer_than_80_chars
                                            inputFormatters: <TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                            ],
                                            hintText: 'MM',
                                            enabled: !state.isBirthDateUnknown,
                                            errorText:
                                                state.birthMinuteError.isEmpty
                                                    ? null
                                                    : '',
                                            maxLength: 2,
                                            onChanged: (String value) {
                                              viewModel.changeBirthMinute(
                                                birthMinute: value,
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
                            Positioned(
                              bottom: 0,
                              child: GestureDetector(
                                onTap: () {
                                  viewModel.changeIsBirthDateUnknown(
                                    isBirthDateUnknown:
                                        !state.isBirthDateUnknown,
                                  );
                                },
                                child: SizedBox(
                                  height: 20,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        height: 16,
                                        width: 16,
                                        decoration: BoxDecoration(
                                          color: state.isBirthDateUnknown
                                              ? doitColorTheme.main
                                              : doitColorTheme.gray20,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: SvgPicture.asset(
                                          Assets.done,
                                          colorFilter: ColorFilter.mode(
                                            doitColorTheme.background,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      const Text(
                                        '태어난 시간을 알지 못합니다.',
                                        style: DoitTypos.suitR10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 65),
                        SizedBox(
                          height: MediaQuery.of(context).viewInsets.bottom,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 125,
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
                            '정보를 입력해주세요',
                            style: DoitTypos.suitSB20.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 28,
                              height: 1.4,
                              color: doitColorTheme.main,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '입력 정보를 기반으로\n'
                            '운세와 맞춤 목표를 추천드릴게요!',
                            style: DoitTypos.suitR16,
                          ),
                          const SizedBox(height: 24),
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

class ChoiceButtonsWiget extends StatelessWidget {
  const ChoiceButtonsWiget({
    required this.firstText,
    required this.secondText,
    required this.onPressedFirst,
    required this.onPressedSecond,
    required this.isFirstSelected,
    this.height = 40,
    this.enabled = true,
    super.key,
  });

  final String firstText;
  final String secondText;
  final VoidCallback onPressedFirst;
  final VoidCallback onPressedSecond;
  final bool isFirstSelected;
  final bool enabled;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;
    return SizedBox(
      height: height,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: enabled
                    ? isFirstSelected
                        ? doitColorTheme.main
                        : doitColorTheme.gray10
                    : doitColorTheme.gray10,
                foregroundColor: enabled
                    ? isFirstSelected
                        ? doitColorTheme.background
                        : doitColorTheme.gray60
                    : doitColorTheme.gray40,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: enabled ? onPressedFirst : null,
              child: Text(
                firstText,
                style: DoitTypos.suitR20.copyWith(height: 1.2),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: enabled
                    ? isFirstSelected
                        ? doitColorTheme.gray10
                        : doitColorTheme.main
                    : doitColorTheme.gray10,
                foregroundColor: enabled
                    ? isFirstSelected
                        ? doitColorTheme.gray60
                        : doitColorTheme.background
                    : doitColorTheme.gray40,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: enabled ? onPressedSecond : null,
              child: Text(
                secondText,
                style: DoitTypos.suitR20.copyWith(height: 1.2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
