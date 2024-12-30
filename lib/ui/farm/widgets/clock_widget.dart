import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';

import '../../../theme/doit_color_theme.dart';
import '../../../theme/doit_typos.dart';
import '../farm_state.dart';
import '../farm_view_model.dart';

class ClockWidget extends ConsumerWidget {
  const ClockWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FarmState state = ref.watch(farmViewModelProvider);
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      opacity: state.isClockButtonSelected ? 1.0 : 0.0,
      child: TimerBuilder.periodic(
        const Duration(seconds: 1),
        builder: (BuildContext context) => Column(
          children: <Widget>[
            Text(
              DateFormat('yyyy-MM-dd').format(DateTime.now()),
              style: DoitTypos.tenadaEB20.copyWith(
                color: doitColorTheme.background,
                height: 0.4,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              DateFormat('HH:mm').format(DateTime.now()),
              style: DoitTypos.tenadaEB20.copyWith(
                color: doitColorTheme.background,
                fontSize: 100,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
