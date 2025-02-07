import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/todo/model/todo_model.dart';
import '../../../theme/doit_color_theme.dart';
import '../../../theme/doit_typos.dart';
import '../../common/consts/assets.dart';
import '../home_view_model.dart';
import 'edit_todo_bottom_sheet_widget.dart';

class TodoListItemWidget extends ConsumerWidget {
  const TodoListItemWidget({
    required this.model,
    super.key,
  });

  final TodoModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;

    final HomeViewModel viewModel = ref.watch(homeViewModelProvider.notifier);
    return Row(
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) =>
                    TodoDetailModalWidget(model: model),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(model.title),
            ),
          ),
        ),
        Container(
          width: 20,
          height: 20,
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.only(left: 16),
          decoration: BoxDecoration(
            color:
                model.isCompleted ? doitColorTheme.main : doitColorTheme.gray20,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              overlayColor: WidgetStatePropertyAll<Color>(
                doitColorTheme.main.withOpacity(0.2),
              ),
              onTap: () {
                viewModel.toggleTodoDone(id: model.todoId);
              },
              child: SvgPicture.asset(
                Assets.done,
                colorFilter: ColorFilter.mode(
                  doitColorTheme.background,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TodoDetailModalWidget extends ConsumerWidget {
  const TodoDetailModalWidget({required this.model, super.key});

  final TodoModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;
    final HomeViewModel viewModel = ref.watch(homeViewModelProvider.notifier);
    return Container(
      decoration: BoxDecoration(
        color: doitColorTheme.background,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(model.title, style: DoitTypos.suitSB20),
              ),
              IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: SvgPicture.asset(
                  Assets.closeMD,
                  colorFilter: ColorFilter.mode(
                    doitColorTheme.gray60,
                    BlendMode.srcIn,
                  ),
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                style: const ButtonStyle(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {
              context.pop();
              showModalBottomSheet(
                context: context,
                backgroundColor: doitColorTheme.background,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                builder: (BuildContext context) =>
                    EditTodoBottomSheetWidget(model: model),
              );
            },
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              overlayColor: doitColorTheme.gray80,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Row(
              children: <Widget>[
                SvgPicture.asset(
                  Assets.edit,
                  colorFilter: ColorFilter.mode(
                    doitColorTheme.gray80,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '할 일 수정하기',
                  style: DoitTypos.suitSB16.copyWith(
                    color: doitColorTheme.gray80,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: doitColorTheme.gray20,
            height: 29,
          ),
          TextButton(
            onPressed: () {
              context.pop();
              viewModel.deleteTodo(id: model.todoId);
            },
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              overlayColor: doitColorTheme.error,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Row(
              children: <Widget>[
                SvgPicture.asset(
                  Assets.delete,
                  colorFilter: ColorFilter.mode(
                    doitColorTheme.error,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '할 일 삭제하기',
                  style: DoitTypos.suitSB16.copyWith(
                    color: doitColorTheme.error,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
