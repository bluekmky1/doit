import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/loading_status.dart';
import '../../../theme/doit_color_theme.dart';
import '../../../theme/doit_typos.dart';
import '../../common/consts/assets.dart';
import '../home_state.dart';
import '../home_view_model.dart';

class RoutineListItemWidget extends ConsumerWidget {
  const RoutineListItemWidget({
    required this.id,
    required this.title,
    super.key,
  });

  final String id;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;
    final HomeState state = ref.watch(homeViewModelProvider);
    final HomeViewModel viewModel = ref.watch(homeViewModelProvider.notifier);
    return GestureDetector(
      onTap: () {
        if (state.addTodoLoadingStatus == LoadingStatus.loading) {
          return;
        }
        viewModel.addTodoWithRoutine(
          todo: title,
          routineId: id,
        );
      },
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                title,
                style: DoitTypos.suitR14.copyWith(
                  color: doitColorTheme.gray40,
                ),
              ),
            ),
          ),
          SvgPicture.asset(
            Assets.add,
            colorFilter: ColorFilter.mode(
              doitColorTheme.gray40,
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
    );
  }
}
