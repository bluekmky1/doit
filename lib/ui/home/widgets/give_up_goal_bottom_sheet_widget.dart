import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/doit_color_theme.dart';
import '../../../theme/doit_typos.dart';

class GiveUpGoalBottomSheetWidget extends ConsumerWidget {
  const GiveUpGoalBottomSheetWidget({super.key});

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
                const Expanded(
                  child: Text(
                    '의 이름',
                    style: DoitTypos.suitSB16,
                  ),
                ),
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
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      '이 미션을 정말로 삭제하시겠습니까?\n'
                      '삭제된 미션은 되돌릴 수 없어요.',
                      style: DoitTypos.suitSB16,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
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
                      foregroundColor: doitColorTheme.gray80,
                    ),
                    onPressed: () {
                      context.pop();
                    },
                    child: const Text(
                      '취소',
                      style: DoitTypos.suitSB16,
                    ),
                  ),
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: doitColorTheme.gray20,
              ),
              Expanded(
                child: SizedBox(
                  height: 64,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      foregroundColor: doitColorTheme.error,
                    ),
                    onPressed: () {
                      context.pop();
                    },
                    child: const Text(
                      '삭제',
                      style: DoitTypos.suitSB16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }
}
