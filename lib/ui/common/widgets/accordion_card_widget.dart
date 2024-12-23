import 'package:flutter/material.dart';

import '../../../theme/doit_color_theme.dart';

class AccordionCardWidget extends StatefulWidget {
  const AccordionCardWidget({
    required this.titleChild,
    required this.bodyChild,
    super.key,
    this.initiallyExpanded = false,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 12,
    ),
  });

  final Widget titleChild;
  final Widget bodyChild;
  final bool initiallyExpanded;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  @override
  State<AccordionCardWidget> createState() => _AccordionCardWidgetState();
}

class _AccordionCardWidgetState extends State<AccordionCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightFactor;
  late Animation<double> _iconTurns;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _heightFactor = _controller.drive(CurveTween(curve: Curves.easeInOut));
    _iconTurns = _controller.drive(Tween<double>(begin: 0.0, end: 0.5)
        .chain(CurveTween(curve: Curves.easeInOut)));
    _isExpanded = widget.initiallyExpanded;
    if (_isExpanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: doitColorTheme.background,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: doitColorTheme.shadow1.withOpacity(0.2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          InkWell(
            onTap: _handleTap,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: Padding(
              padding: widget.padding,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(child: widget.titleChild),
                  RotationTransition(
                    turns: _iconTurns,
                    child: const Icon(Icons.keyboard_arrow_down),
                  ),
                ],
              ),
            ),
          ),
          ClipRect(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget? child) => SizeTransition(
                sizeFactor: _heightFactor,
                child: child,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: widget.bodyChild,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
