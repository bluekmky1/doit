import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/loading_status.dart';
import '../../domain/routine/model/routine_model.dart';
import '../../theme/doit_color_theme.dart';
import '../../theme/doit_typos.dart';
import '../common/consts/assets.dart';
import '../home/home_view_model.dart';
import 'routine_state.dart';
import 'routine_view_model.dart';

class RoutineView extends ConsumerStatefulWidget {
  const RoutineView({super.key});

  @override
  ConsumerState<RoutineView> createState() => _RoutineViewState();
}

class _RoutineViewState extends ConsumerState<RoutineView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(routineViewModelProvider.notifier).getAllRoutineList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;

    final RoutineState state = ref.watch(routineViewModelProvider);

    ref.listen(
      routineViewModelProvider.select(
        (RoutineState state) => state.updateRoutineActiveLoadingStatus,
      ),
      (LoadingStatus? previous, LoadingStatus next) {
        if (next == LoadingStatus.success) {
          ref.read(homeViewModelProvider.notifier).getActiveRoutineList();
        }
        if (next == LoadingStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: doitColorTheme.error,
              content: const Text('루틴 상태 변경에 실패했습니다.'),
            ),
          );
        }
      },
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
          ),
        ),
        titleSpacing: 0,
        title: Text(
          '루틴',
          style: DoitTypos.suitSB16.copyWith(
            fontSize: 18,
          ),
        ),
        actions: <Widget>[
          IconButton(
            constraints: const BoxConstraints(),
            style: TextButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: EdgeInsets.zero,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                backgroundColor: doitColorTheme.background,
                builder: (BuildContext context) =>
                    const AddRoutineBottomSheet(),
              );
            },
            icon: SvgPicture.asset(
              Assets.add,
              width: 28,
              height: 28,
              colorFilter: ColorFilter.mode(
                doitColorTheme.main,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(
            width: 24,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 8,
            ),
            if (state.getRoutineListLoadingStatus == LoadingStatus.success &&
                state.routineList.isEmpty)
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: const Center(
                  child: EmptyRoutineSpace(),
                ),
              ),
            if (state.getRoutineListLoadingStatus == LoadingStatus.loading)
              Wrap(
                runSpacing: 16,
                children: List<Widget>.generate(
                  4, // 적당한 개수의 쉬머 카드를 보여줌
                  (int index) => Shimmer.fromColors(
                    baseColor: doitColorTheme.gray10,
                    highlightColor: doitColorTheme.gray20,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        color: doitColorTheme.gray10,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              )
            else
              Wrap(
                runSpacing: 16,
                children: <Widget>[
                  ...List<Widget>.generate(
                    state.routineList.length,
                    (int index) => RoutineCard(
                      routine: state.routineList[index],
                    ),
                  ),
                ],
              ),
            const SizedBox(
              height: 48,
            ),
          ],
        ),
      ),
    );
  }
}

class AddRoutineBottomSheet extends ConsumerStatefulWidget {
  const AddRoutineBottomSheet({
    super.key,
  });

  @override
  ConsumerState<AddRoutineBottomSheet> createState() =>
      _AddRoutineBottomSheetState();
}

class _AddRoutineBottomSheetState extends ConsumerState<AddRoutineBottomSheet> {
  final TextEditingController titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;
    final RoutineViewModel viewModel =
        ref.watch(routineViewModelProvider.notifier);
    final RoutineState state = ref.watch(routineViewModelProvider);
    ref.listen(
      routineViewModelProvider.select(
        (RoutineState state) => state.createRoutineLoadingStatus,
      ),
      (LoadingStatus? previous, LoadingStatus next) {
        if (next == LoadingStatus.success) {
          ref.read(homeViewModelProvider.notifier).getActiveRoutineList();
          context.pop();
        }
      },
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.fromLTRB(
            24,
            16,
            24,
            0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '루틴 추가',
                style: DoitTypos.suitSB20,
              ),
              CloseButton(
                style: ButtonStyle(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            24,
            8,
            24,
            16,
          ),
          child: TextField(
            controller: titleController,
            cursorColor: doitColorTheme.main,
            onChanged: (String value) {
              setState(() {});
            },
            minLines: 1,
            maxLines: 2,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '이곳에 루틴을 입력해주세요',
              hintStyle: DoitTypos.suitSB16.copyWith(
                color: doitColorTheme.gray40,
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: titleController.text.trim().isEmpty
                ? doitColorTheme.gray40
                : doitColorTheme.main,
            foregroundColor: titleController.text.trim().isEmpty
                ? doitColorTheme.gray80
                : doitColorTheme.background,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          onPressed: titleController.text.trim().isEmpty
              ? null
              : () {
                  if (state.createRoutineLoadingStatus ==
                      LoadingStatus.loading) {
                    return;
                  }
                  viewModel.addRoutine(titleController.text);
                },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '추가하기',
                style: DoitTypos.suitSB16.copyWith(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).viewInsets.bottom,
        ),
      ],
    );
  }
}

class RoutineCard extends ConsumerWidget {
  const RoutineCard({
    required this.routine,
    super.key,
  });

  final RoutineModel routine;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;
    final RoutineViewModel viewModel =
        ref.watch(routineViewModelProvider.notifier);
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: doitColorTheme.background,
        borderRadius: BorderRadius.circular(12),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: doitColorTheme.shadow1.withOpacity(0.1),
            blurRadius: 8,
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            showModalBottomSheet(
              backgroundColor: doitColorTheme.background,
              context: context,
              builder: (BuildContext context) => RoutineDetailBottomSheet(
                routine: routine,
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(routine.title),
                ),
                Switch(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  trackColor: WidgetStatePropertyAll<Color>(
                    doitColorTheme.background,
                  ),
                  activeColor: doitColorTheme.main,
                  inactiveThumbColor: doitColorTheme.gray20,
                  splashRadius: 0,
                  trackOutlineColor: WidgetStateProperty.resolveWith(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.selected)) {
                        return doitColorTheme.main;
                      }

                      return doitColorTheme.gray20;
                    },
                  ),
                  thumbIcon: WidgetStateProperty.resolveWith<Icon>(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.selected)) {
                        return Icon(
                          Icons.circle,
                          color: doitColorTheme.main,
                        );
                      }
                      return Icon(
                        Icons.circle,
                        color: doitColorTheme.gray20,
                      );
                    },
                  ),
                  value: routine.isActive,
                  onChanged: (bool value) {
                    viewModel.toggleRoutineActive(
                      id: routine.id,
                      isActive: value,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RoutineDetailBottomSheet extends StatelessWidget {
  const RoutineDetailBottomSheet({
    required this.routine,
    super.key,
  });

  final RoutineModel routine;

  @override
  Widget build(BuildContext context) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.only(top: 24, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  routine.title,
                  style: DoitTypos.suitSB20,
                ),
                const CloseButton(
                  style: ButtonStyle(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: doitColorTheme.background,
                foregroundColor: doitColorTheme.error,
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => DeleteRoutineDialog(
                    routineId: routine.id,
                  ),
                );
              },
              icon: SvgPicture.asset(
                Assets.delete,
                colorFilter: ColorFilter.mode(
                  doitColorTheme.error,
                  BlendMode.srcIn,
                ),
              ),
              label: const Row(
                children: <Widget>[
                  Text(
                    '루틴 삭제',
                    style: DoitTypos.suitSB16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DeleteRoutineDialog extends ConsumerWidget {
  const DeleteRoutineDialog({
    required this.routineId,
    super.key,
  });

  final String routineId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;
    final RoutineViewModel viewModel =
        ref.watch(routineViewModelProvider.notifier);
    final RoutineState state = ref.watch(routineViewModelProvider);
    ref.listen(
      routineViewModelProvider.select(
        (RoutineState state) => state.deleteRoutineLoadingStatus,
      ),
      (LoadingStatus? previous, LoadingStatus next) {
        if (next == LoadingStatus.success) {
          ref.read(homeViewModelProvider.notifier).getActiveRoutineList();
          context
            ..pop()
            ..pop();
        }
      },
    );
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: doitColorTheme.background,
      actionsAlignment: MainAxisAlignment.center,
      titleTextStyle: DoitTypos.suitSB20.copyWith(
        color: doitColorTheme.error,
      ),
      content: Text(
        '정말로 루틴을 삭제하시겠습니까?\n 삭제 후 복구할 수 없습니다.',
        textAlign: TextAlign.center,
        style: DoitTypos.suitSB16.copyWith(
          color: doitColorTheme.gray80,
        ),
      ),
      contentPadding: const EdgeInsets.fromLTRB(
        24,
        16,
        24,
        0,
      ),
      contentTextStyle: DoitTypos.suitSB16.copyWith(
        color: doitColorTheme.gray80,
      ),
      actionsPadding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 16,
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: TextButton(
                onPressed: () {
                  context.pop();
                },
                style: TextButton.styleFrom(
                  backgroundColor: doitColorTheme.background,
                  foregroundColor: doitColorTheme.gray80,
                ),
                child: Text(
                  '취소',
                  style: DoitTypos.suitSB16.copyWith(
                    color: doitColorTheme.gray80,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextButton(
                onPressed: () {
                  if (state.deleteRoutineLoadingStatus ==
                      LoadingStatus.loading) {
                    return;
                  }
                  viewModel.deleteRoutine(routineId);
                },
                style: TextButton.styleFrom(
                  backgroundColor: doitColorTheme.background,
                  foregroundColor: doitColorTheme.error,
                ),
                child: Text(
                  '삭제',
                  style: DoitTypos.suitSB16.copyWith(
                    color: doitColorTheme.error,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class EmptyRoutineSpace extends StatelessWidget {
  const EmptyRoutineSpace({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 10),
          Image.asset(Assets.emptyDragon),
          const SizedBox(height: 10),
          const Text(
            '등록한 루틴이 없어요\n'
            '루틴을 추가해보세요!',
            style: DoitTypos.suitR14,
            textAlign: TextAlign.center,
          ),
        ],
      );
}
