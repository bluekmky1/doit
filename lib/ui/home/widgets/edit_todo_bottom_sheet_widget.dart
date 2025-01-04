import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/todo/model/todo_model.dart';
import '../../../theme/doit_color_theme.dart';
import '../../../theme/doit_typos.dart';
import '../../common/widgets/outlined_text_field_widget.dart';
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
                  '할 일 수정하기',
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
            child: OutlinedTextFieldWidget(
              controller: _textEditingController,
              height: 52,
              hintText: '할 일을 꼭 입력해주세요!',
              textAlign: TextAlign.left,
              hintStyle: DoitTypos.suitR14.copyWith(
                color: doitColorTheme.gray40,
              ),
              onChanged: (String value) {},
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
                    viewModel.updateTodo(
                      id: widget.model.todoId,
                      title: _textEditingController.text,
                    );
                    context.pop();
                  },
                  child: const Text(
                    '수정하기',
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
