import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';
import 'package:electricity/common/styles/text/text_style.dart';

part 'app_text_scheme.tailor.dart';

/// App text style scheme.
@TailorMixin(themeGetter: ThemeGetter.none)
class AppTextScheme extends ThemeExtension<AppTextScheme>
    with _$AppTextSchemeTailorMixin {
  const AppTextScheme({
    required this.regular10,
    required this.regular11,
    required this.regular12,
    required this.regular13,
    required this.regular14,
    required this.regular15,
    required this.regular16,
    required this.regular20,
    required this.regular22,
    required this.regular24,
    required this.regular32,
    required this.regular40,
    required this.semiBold20,
    required this.semiBold24,
    required this.semiBold31,
    required this.semiBold36,
    required this.semiBold40,
    required this.semiBold48,
    required this.semiBold60,
    required this.semiBold64,
    required this.medium13,
    required this.medium15,
    required this.medium16,
    required this.medium20,
    required this.medium24,
  });

  /// Base app text theme.
  AppTextScheme.base([Color? color])
    : regular10 = AppTextStyle.regular10.value.copyWith(color: color),
      regular11 = AppTextStyle.regular11.value.copyWith(color: color),
      regular12 = AppTextStyle.regular12.value.copyWith(color: color),
      regular13 = AppTextStyle.regular13.value.copyWith(color: color),
      regular14 = AppTextStyle.regular14.value.copyWith(color: color),
      regular15 = AppTextStyle.regular15.value.copyWith(color: color),
      regular16 = AppTextStyle.regular16.value.copyWith(color: color),
      regular20 = AppTextStyle.regular20.value.copyWith(color: color),
      regular22 = AppTextStyle.regular22.value.copyWith(color: color),
      regular24 = AppTextStyle.regular24.value.copyWith(color: color),
      regular32 = AppTextStyle.regular32.value.copyWith(color: color),
      regular40 = AppTextStyle.regular40.value.copyWith(color: color),
      semiBold20 = AppTextStyle.semiBold20.value.copyWith(color: color),
      semiBold24 = AppTextStyle.semiBold24.value.copyWith(color: color),
      semiBold31 = AppTextStyle.semiBold31.value.copyWith(color: color),
      semiBold36 = AppTextStyle.semiBold36.value.copyWith(color: color),
      semiBold40 = AppTextStyle.semiBold40.value.copyWith(color: color),
      semiBold48 = AppTextStyle.semiBold31.value.copyWith(color: color),
      semiBold60 = AppTextStyle.semiBold60.value.copyWith(color: color),
      semiBold64 = AppTextStyle.semiBold64.value.copyWith(color: color),
      medium13 = AppTextStyle.medium13.value.copyWith(color: color),
      medium15 = AppTextStyle.medium15.value.copyWith(color: color),
      medium16 = AppTextStyle.medium16.value.copyWith(color: color),
      medium20 = AppTextStyle.medium20.value.copyWith(color: color),
      medium24 = AppTextStyle.medium24.value.copyWith(color: color);

  @override
  final TextStyle regular10;
  @override
  final TextStyle regular11;
  @override
  final TextStyle regular12;
  @override
  final TextStyle regular13;
  @override
  final TextStyle regular14;
  @override
  final TextStyle regular15;
  @override
  final TextStyle regular16;
  @override
  final TextStyle regular20;
  @override
  final TextStyle regular22;
  @override
  final TextStyle regular24;
  @override
  final TextStyle regular32;
  @override
  final TextStyle regular40;
  @override
  final TextStyle semiBold20;
  @override
  final TextStyle semiBold24;
  @override
  final TextStyle semiBold31;
  @override
  final TextStyle semiBold36;
  @override
  final TextStyle semiBold40;
  @override
  final TextStyle semiBold48;
  @override
  final TextStyle semiBold60;
  @override
  final TextStyle semiBold64;
  @override
  final TextStyle medium13;
  @override
  final TextStyle medium15;
  @override
  final TextStyle medium16;
  @override
  final TextStyle medium20;
  @override
  final TextStyle medium24;
}
