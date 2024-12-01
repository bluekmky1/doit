import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/doit_color_theme.dart';
import '../../../theme/doit_typos.dart';
import '../../common/widgets/outlined_text_field_widget.dart';

class AddTodoBottomSheetWidget extends ConsumerWidget {
  const AddTodoBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;

    return DecoratedBox(
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
                  '새로운 할 일 추가하기',
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
              hintText: '오늘은 목표를 위해 무슨 일을 하실건가요?',
              height: 52,
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
                    context.pop();
                  },
                  child: const Text(
                    '추가하기',
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
