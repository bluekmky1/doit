import 'package:flutter/material.dart';

import 'doit_colors.dart';

@immutable
class DoitColorTheme extends ThemeExtension<DoitColorTheme> {
  const DoitColorTheme({
    required this.background,
    required this.main,
    required this.error,
    required this.inputBorder,
    required this.shadow1,
    required this.shadow2,
    required this.gray80,
    required this.gray60,
    required this.gray40,
    required this.gray20,
    required this.gray10,
    required this.gradient1Stop42,
    required this.gradient1Stop100,
    required this.gradient2Stop0,
    required this.gradient2Stop100,
    required this.gradient3Stop0,
    required this.gradient3Stop100,
    required this.gradient4Stop0,
    required this.gradient4Stop100,
    required this.gradient5Stop0,
    required this.gradient5Stop100,
    required this.gradient6Stop0,
    required this.gradient6Stop100,
    required this.gradient7Stop0,
    required this.gradient7Stop100,
  });

  static const DoitColorTheme light = DoitColorTheme(
    background: DoitColors.background,
    main: DoitColors.main,
    error: DoitColors.error,
    inputBorder: DoitColors.inputBorder,
    shadow1: DoitColors.shadow1,
    shadow2: DoitColors.shadow2,
    gray80: DoitColors.gray80,
    gray60: DoitColors.gray60,
    gray40: DoitColors.gray40,
    gray20: DoitColors.gray20,
    gray10: DoitColors.gray10,
    gradient1Stop42: DoitColors.gradient1Stop42,
    gradient1Stop100: DoitColors.gradient1Stop100,
    gradient2Stop0: DoitColors.gradient2Stop0,
    gradient2Stop100: DoitColors.gradient2Stop100,
    gradient3Stop0: DoitColors.gradient3Stop0,
    gradient3Stop100: DoitColors.gradient3Stop100,
    gradient4Stop0: DoitColors.gradient4Stop0,
    gradient4Stop100: DoitColors.gradient4Stop100,
    gradient5Stop0: DoitColors.gradient5Stop0,
    gradient5Stop100: DoitColors.gradient5Stop100,
    gradient6Stop0: DoitColors.gradient6Stop0,
    gradient6Stop100: DoitColors.gradient6Stop100,
    gradient7Stop0: DoitColors.gradient7Stop0,
    gradient7Stop100: DoitColors.gradient7Stop100,
  );

  static const DoitColorTheme dark = light;

  final Color background;
  final Color main;
  final Color error;
  final Color inputBorder;
  final Color shadow1;
  final Color shadow2;
  final Color gray80;
  final Color gray60;
  final Color gray40;
  final Color gray20;
  final Color gray10;
  final Color gradient1Stop42;
  final Color gradient1Stop100;
  final Color gradient2Stop0;
  final Color gradient2Stop100;
  final Color gradient3Stop0;
  final Color gradient3Stop100;
  final Color gradient4Stop0;
  final Color gradient4Stop100;
  final Color gradient5Stop0;
  final Color gradient5Stop100;
  final Color gradient6Stop0;
  final Color gradient6Stop100;
  final Color gradient7Stop0;
  final Color gradient7Stop100;

  @override
  DoitColorTheme lerp(DoitColorTheme? other, double t) {
    if (other is! DoitColorTheme) {
      return this;
    }
    return DoitColorTheme(
      background: Color.lerp(background, other.background, t)!,
      main: Color.lerp(main, other.main, t)!,
      error: Color.lerp(error, other.error, t)!,
      inputBorder: Color.lerp(inputBorder, other.inputBorder, t)!,
      shadow1: Color.lerp(shadow1, other.shadow1, t)!,
      shadow2: Color.lerp(shadow2, other.shadow2, t)!,
      gray80: Color.lerp(gray80, other.gray80, t)!,
      gray60: Color.lerp(gray60, other.gray60, t)!,
      gray40: Color.lerp(gray40, other.gray40, t)!,
      gray20: Color.lerp(gray20, other.gray20, t)!,
      gray10: Color.lerp(gray10, other.gray10, t)!,
      gradient1Stop42: Color.lerp(gradient1Stop42, other.gradient1Stop42, t)!,
      gradient1Stop100:
          Color.lerp(gradient1Stop100, other.gradient1Stop100, t)!,
      gradient2Stop0: Color.lerp(gradient2Stop0, other.gradient2Stop0, t)!,
      gradient2Stop100:
          Color.lerp(gradient2Stop100, other.gradient2Stop100, t)!,
      gradient3Stop0: Color.lerp(gradient3Stop0, other.gradient3Stop0, t)!,
      gradient3Stop100:
          Color.lerp(gradient3Stop100, other.gradient3Stop100, t)!,
      gradient4Stop0: Color.lerp(gradient4Stop0, other.gradient4Stop0, t)!,
      gradient4Stop100:
          Color.lerp(gradient4Stop100, other.gradient4Stop100, t)!,
      gradient5Stop0: Color.lerp(gradient5Stop0, other.gradient5Stop0, t)!,
      gradient5Stop100:
          Color.lerp(gradient5Stop100, other.gradient5Stop100, t)!,
      gradient6Stop0: Color.lerp(gradient6Stop0, other.gradient6Stop0, t)!,
      gradient6Stop100:
          Color.lerp(gradient6Stop100, other.gradient6Stop100, t)!,
      gradient7Stop0: Color.lerp(gradient7Stop0, other.gradient7Stop0, t)!,
      gradient7Stop100:
          Color.lerp(gradient7Stop100, other.gradient7Stop100, t)!,
    );
  }

  @override
  DoitColorTheme copyWith({
    Color? background,
    Color? main,
    Color? error,
    Color? inputBorder,
    Color? shadow1,
    Color? shadow2,
    Color? gray80,
    Color? gray60,
    Color? gray40,
    Color? gray20,
    Color? gray10,
    Color? gradient1Stop42,
    Color? gradient1Stop100,
    Color? gradient2Stop0,
    Color? gradient2Stop100,
    Color? gradient3Stop0,
    Color? gradient3Stop100,
    Color? gradient4Stop0,
    Color? gradient4Stop100,
    Color? gradient5Stop0,
    Color? gradient5Stop100,
    Color? gradient6Stop0,
    Color? gradient6Stop100,
    Color? gradient7Stop0,
    Color? gradient7Stop100,
  }) =>
      DoitColorTheme(
        background: background ?? this.background,
        main: main ?? this.main,
        error: error ?? this.error,
        inputBorder: inputBorder ?? this.inputBorder,
        shadow1: shadow1 ?? this.shadow1,
        shadow2: shadow2 ?? this.shadow2,
        gray80: gray80 ?? this.gray80,
        gray60: gray60 ?? this.gray60,
        gray40: gray40 ?? this.gray40,
        gray20: gray20 ?? this.gray20,
        gray10: gray10 ?? this.gray10,
        gradient1Stop42: gradient1Stop42 ?? this.gradient1Stop42,
        gradient1Stop100: gradient1Stop100 ?? this.gradient1Stop100,
        gradient2Stop0: gradient2Stop0 ?? this.gradient2Stop0,
        gradient2Stop100: gradient2Stop100 ?? this.gradient2Stop100,
        gradient3Stop0: gradient3Stop0 ?? this.gradient3Stop0,
        gradient3Stop100: gradient3Stop100 ?? this.gradient3Stop100,
        gradient4Stop0: gradient4Stop0 ?? this.gradient4Stop0,
        gradient4Stop100: gradient4Stop100 ?? this.gradient4Stop100,
        gradient5Stop0: gradient5Stop0 ?? this.gradient5Stop0,
        gradient5Stop100: gradient5Stop100 ?? this.gradient5Stop100,
        gradient6Stop0: gradient6Stop0 ?? this.gradient6Stop0,
        gradient6Stop100: gradient6Stop100 ?? this.gradient6Stop100,
        gradient7Stop0: gradient7Stop0 ?? this.gradient7Stop0,
        gradient7Stop100: gradient7Stop100 ?? this.gradient7Stop100,
      );
}
