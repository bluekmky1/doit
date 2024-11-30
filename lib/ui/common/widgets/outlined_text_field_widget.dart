import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../theme/doit_color_theme.dart';
import '../../../theme/doit_typos.dart';

class OutlinedTextFieldWidget extends StatelessWidget {
  const OutlinedTextFieldWidget({
    required this.hintText,
    required this.onChanged,
    this.maxLength,
    this.inputFormatters,
    this.errorText,
    this.height = 40,
    this.enabled = true,
    this.textAlign = TextAlign.center,
    this.hintStyle,
    super.key,
  });

  final String hintText;
  final int? maxLength;
  final ValueChanged<String> onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;
  final double? height;
  final bool enabled;
  final TextAlign textAlign;
  final TextStyle? hintStyle;
  @override
  Widget build(BuildContext context) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: height,
          child: TextField(
            enabled: enabled,
            textAlign: textAlign,
            maxLength: maxLength,
            cursorColor: doitColorTheme.main,
            onTapOutside: (PointerDownEvent event) {
              FocusScope.of(context).unfocus();
            },
            decoration: InputDecoration(
              hintText: hintText,
              counterText: '',
              hintStyle: hintStyle ??
                  DoitTypos.suitR20.copyWith(
                    color:
                        enabled ? doitColorTheme.gray40 : doitColorTheme.gray20,
                    height: 0,
                  ),
              filled: !enabled,
              fillColor: enabled ? null : doitColorTheme.gray10,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: errorText != null
                      ? doitColorTheme.error
                      : doitColorTheme.gray20,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: doitColorTheme.gray20,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: errorText != null
                      ? doitColorTheme.error
                      : doitColorTheme.main,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
            ),
            inputFormatters: inputFormatters,
            onChanged: onChanged,
          ),
        ),
        if (errorText != null) ...<Widget>[
          const SizedBox(height: 4),
          Text(
            errorText!,
            style: DoitTypos.suitR14.copyWith(
              color: doitColorTheme.error,
            ),
          ),
        ],
      ],
    );
  }
}
