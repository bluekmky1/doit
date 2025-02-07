import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/todo/model/todo_model.dart';
import '../../../theme/doit_color_theme.dart';
import '../../../theme/doit_typos.dart';
import '../home_view_model.dart';

class EditTodoBottomSheetWidget extends ConsumerStatefulWidget {
  const EditTodoBottomSheetWidget({required this.model, super.key});

  final TodoModel model;

  @override
  ConsumerState<EditTodoBottomSheetWidget> createState() =>
      _EditTodoBottomSheetWidgetState();
}

class _EditTodoBottomSheetWidgetState
    extends ConsumerState<EditTodoBottomSheetWidget> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.model.title;
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;

    final HomeViewModel viewModel = ref.read(homeViewModelProvider.notifier);

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
                '할 일 수정하기',
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
            0,
            24,
            16,
          ),
          child: TextField(
            onChanged: (String value) {
              setState(() {});
            },
            controller: _textEditingController,
            cursorColor: doitColorTheme.main,
            minLines: 1,
            maxLines: 2,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '이곳에 할 일을 입력해주세요',
              hintStyle: DoitTypos.suitSB16.copyWith(
                color: doitColorTheme.gray40,
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: _textEditingController.text.trim().isEmpty
                ? doitColorTheme.gray40
                : doitColorTheme.main,
            foregroundColor: _textEditingController.text.trim().isEmpty
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
          onPressed: _textEditingController.text.trim().isEmpty
              ? null
              : () {
                  viewModel.updateTodo(
                    id: widget.model.todoId,
                    title: _textEditingController.text.trim(),
                  );
                  context.pop();
                },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '수정하기',
                style: DoitTypos.suitSB16.copyWith(fontSize: 18),
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
