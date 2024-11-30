import 'package:flutter/material.dart';

import '../../common/widgets/text_chip_widget.dart';

class ChipListWidget extends StatelessWidget {
  final List<String> titles;

  const ChipListWidget({
    required this.titles,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List<Widget>.generate(
            titles.length,
            (int index) => TextChipWidget(title: titles[index]),
          ),
        ),
      );
}
