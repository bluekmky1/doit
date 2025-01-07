import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/loading_status.dart';
import '../../../theme/doit_color_theme.dart';
import '../../../theme/doit_typos.dart';
import '../../common/consts/assets.dart';
import '../home_state.dart';
import '../home_view_model.dart';

class CalenderBarWidget extends ConsumerStatefulWidget {
  const CalenderBarWidget({super.key});

  @override
  ConsumerState<CalenderBarWidget> createState() => _CalenderBarWidgetState();
}

class _CalenderBarWidgetState extends ConsumerState<CalenderBarWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;

    final HomeState state = ref.watch(homeViewModelProvider);
    final HomeViewModel viewModel = ref.read(homeViewModelProvider.notifier);

    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) {
        if (details.primaryVelocity == null) {
          return;
        }

        // 왼쪽으로 스와이프하면 다음 주로 이동
        if (details.primaryVelocity! < 0) {
          viewModel.moveToNextWeek();
        }
        // 오른쪽으로 스와이프하면 이전 주로 이동
        else if (details.primaryVelocity! > 0) {
          viewModel.moveToPreviousWeek();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: doitColorTheme.background,
          border: Border.all(
            color: Colors.transparent,
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: doitColorTheme.shadow1.withAlpha((0.2 * 255).round()),
              blurRadius: 16,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      final DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: state.selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        builder: (BuildContext context, Widget? child) => Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: doitColorTheme.main,
                              onSurface: doitColorTheme.gray80,
                            ),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                foregroundColor: doitColorTheme.main,
                              ),
                            ),
                          ),
                          child: child!,
                        ),
                        locale: const Locale('ko', 'KR'),
                      );
                      if (selectedDate != null) {
                        viewModel.setSelectedDate(date: selectedDate);
                        await viewModel.getTodoListWithDate(
                            targetDate: selectedDate);

                        final DateTime weekStart = state.currentWeekStart;
                        final DateTime weekEnd =
                            weekStart.add(const Duration(days: 6));

                        if (selectedDate.isBefore(weekStart) ||
                            selectedDate.isAfter(weekEnd)) {
                          final int diff = selectedDate.weekday - 1;
                          final DateTime newWeekStart =
                              selectedDate.subtract(Duration(days: diff));
                          viewModel.setCurrentWeekStart(date: newWeekStart);
                        }
                      }
                    },
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: SvgPicture.asset(
                            Assets.calendar,
                            colorFilter: ColorFilter.mode(
                              doitColorTheme.main,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${state.currentWeekStart.year}년 '
                          '${state.currentWeekStart.month}월',
                          style: DoitTypos.suitSB16,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: viewModel.moveToPreviousWeek,
                    constraints: const BoxConstraints(
                      minWidth: 24,
                      minHeight: 24,
                    ),
                    style: IconButton.styleFrom(
                      padding: EdgeInsets.zero,
                      overlayColor: Colors.transparent,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 16,
                      color: doitColorTheme.gray60,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  IconButton(
                    onPressed: viewModel.moveToNextWeek,
                    constraints: const BoxConstraints(
                      minWidth: 24,
                      minHeight: 24,
                    ),
                    style: IconButton.styleFrom(
                      padding: EdgeInsets.zero,
                      overlayColor: Colors.transparent,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: doitColorTheme.gray60,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 7,
                itemBuilder: (BuildContext context, int index) {
                  final DateTime date =
                      state.currentWeekStart.add(Duration(days: index));
                  final bool isToday = date.day == DateTime.now().day &&
                      date.month == DateTime.now().month &&
                      date.year == DateTime.now().year;

                  final bool isSelected = date.day == state.selectedDate.day &&
                      date.month == state.selectedDate.month &&
                      date.year == state.selectedDate.year;

                  final bool canNotTap =
                      state.getTodoListLoadingStatus == LoadingStatus.loading ||
                          isSelected;

                  return GestureDetector(
                    onTap: () {
                      if (canNotTap) {
                        return;
                      }
                      viewModel
                        ..setSelectedDate(date: date)
                        ..getTodoListWithDate(targetDate: date);
                    },
                    child: Container(
                      width: 45,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        border: isToday
                            ? Border.all(
                                color: doitColorTheme.main,
                              )
                            : null,
                        borderRadius: BorderRadius.circular(8),
                        color: isSelected
                            ? doitColorTheme.main.withAlpha((0.1 * 255).round())
                            : Colors.transparent,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            <String>['월', '화', '수', '목', '금', '토', '일'][index],
                            style: DoitTypos.suitR12.copyWith(
                              color: doitColorTheme.gray60,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${date.day}',
                            style: DoitTypos.suitSB16.copyWith(
                              color: date.day == state.selectedDate.day &&
                                      date.month == state.selectedDate.month &&
                                      date.year == state.selectedDate.year
                                  ? doitColorTheme.main
                                  : doitColorTheme.gray80,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
