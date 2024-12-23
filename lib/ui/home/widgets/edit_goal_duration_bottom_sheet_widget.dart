import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/doit_color_theme.dart';
import '../../../theme/doit_typos.dart';
import '../../common/widgets/outlined_text_field_widget.dart';

class EditGoalDurationBottomSheetWidget extends ConsumerStatefulWidget {
  const EditGoalDurationBottomSheetWidget({super.key});

  @override
  ConsumerState<EditGoalDurationBottomSheetWidget> createState() =>
      _EditGoalDurationBottomSheetWidgetState();
}

class _EditGoalDurationBottomSheetWidgetState
    extends ConsumerState<EditGoalDurationBottomSheetWidget> {
  final TextEditingController endYearInputController = TextEditingController();
  final TextEditingController endMonthInputController = TextEditingController();
  final TextEditingController endDayInputController = TextEditingController();

  @override
  Widget build(
    BuildContext context,
  ) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: doitColorTheme.background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: <Widget>[
                const Text(
                  '목표 기간 수정하기',
                  style: DoitTypos.suitSB16,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  style: IconButton.styleFrom(
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: OutlinedTextFieldWidget(
                        controller: endYearInputController,
                        hintText: 'YYYY',
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        maxLength: 4,
                        onChanged: (String value) {},
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
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              maxLength: 2,
                              onChanged: (String value) {},
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: OutlinedTextFieldWidget(
                              controller: endDayInputController,
                              hintText: 'DD',
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              maxLength: 2,
                              onChanged: (String value) {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: <Widget>[
                    Wrap(
                      spacing: 8,
                      children: <Widget>[
                        TextButton(
                          style: TextButton.styleFrom(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            padding: EdgeInsets.zero,
                            visualDensity: VisualDensity.compact,
                            foregroundColor: doitColorTheme.main,
                          ),
                          onPressed: () {
                            final DateTime sevenDaysLater =
                                DateTime.now().add(const Duration(days: 7));
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
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            padding: EdgeInsets.zero,
                            visualDensity: VisualDensity.compact,
                            foregroundColor: doitColorTheme.main,
                          ),
                          onPressed: () {
                            final DateTime twoWeeksLater =
                                DateTime.now().add(const Duration(days: 14));
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
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            padding: EdgeInsets.zero,
                            foregroundColor: doitColorTheme.main,
                            visualDensity: VisualDensity.compact,
                          ),
                          onPressed: () {
                            final DateTime oneMonthLater =
                                DateTime.now().add(const Duration(days: 30));
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
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: SizedBox(
                height: 64,
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    backgroundColor: doitColorTheme.main,
                    foregroundColor: doitColorTheme.background,
                  ),
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text(
                    '기간 연장하기',
                    style: DoitTypos.suitSB20,
                  ),
                ),
              )),
            ],
          ),
        ],
      ),
    );
  }
}
