// ignore_for_file: sort_constructors_first

import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'app_color_scheme.tailor.dart';

const _skeletonOpacity = 0.06;

/// App brand color scheme.
@immutable
@TailorMixin(themeGetter: ThemeGetter.none)
class AppColorScheme extends ThemeExtension<AppColorScheme> with _$AppColorSchemeTailorMixin {
  /// Base branding color for the app.
  ///
  /// Can be used as an accent color for buttons, switches, labels, icons, etc.
  @override
  final Color primary;

  /// The color of the text on [primary].
  @override
  final Color onPrimary;

  /// Secondary branding color for the app.
  ///
  /// Can be used as an accent color for buttons, switches, labels, icons, etc.
  ///
  /// Complements [primary] color.
  @override
  final Color secondary;

  /// The color of the text on [secondary].
  @override
  final Color onSecondary;

  /// Tertiary branding color for the app.
  ///
  /// Can be used as an accent color for buttons, switches, labels, icons, etc.
  ///
  /// Complements [primary] color.
  @override
  final Color tertiary;

  /// The color of the text on [tertiary].
  @override
  final Color onTertiary;

  /// Surface color.
  ///
  /// Usually, the background color of cards, alerts, dialogs, bottom sheets, etc
  /// is considered a surface.
  @override
  final Color surface;

  /// Surface color.
  ///
  /// Usually, the background color of cards, alerts, dialogs, bottom sheets, etc
  /// is considered a surface.
  @override
  final Color surfaceSecondary;

  /// Surface color.
  ///
  /// Usually, the background color of cards, alerts, dialogs, bottom sheets, etc
  /// is considered a surface.
  @override
  final Color surfaceTertiary;

  /// High surface color. Darker, more emphasis
  ///
  /// Usually, the background color of cards, alerts, dialogs, bottom sheets, etc
  /// is considered a surface.
  @override
  final Color surfaceHigh;

  /// The color of the text on [surface].
  @override
  final Color onSurface;

  /// The color of the text on [surface]. Lighter, less emphasis
  @override
  final Color onSurfaceVariant;

  /// The color of the containers above surface
  @override
  final Color surfaceContainer;

  /// Background color.
  ///
  /// Usually refers to the general background of the screen.
  @override
  final Color background;

  /// The color of the text on [background].
  @override
  final Color onBackground;

  /// The color of the text on [background]. Muted version.
  @override
  final Color onBackgroundSecondary;

  /// Color of danger.
  ///
  /// Commonly used to display errors.
  ///
  /// Can be used as an accent color for text/background of an error message/destructive button.
  @override
  final Color danger;

  /// The color of the text on [danger].
  @override
  final Color onDanger;

  /// Color of text in text field.
  @override
  final Color textField;

  /// Color of label in text field.
  @override
  final Color textFieldLabel;

  /// Color of helper text in text field.
  @override
  final Color textFieldHelper;

  /// Color of border and cursor in text field.
  @override
  final Color frameTextFieldSecondary;

  /// Color of inactive elements.
  @override
  final Color inactive;

  /// The color of the text on [inactive].
  @override
  final Color onInactive;

  /// Positive color.
  ///
  /// Typically used for informational success messages.
  @override
  final Color positive;

  /// The color of the text on [positive].
  @override
  final Color onPositive;

  /// Primary skeleton color.
  @override
  final Color skeletonPrimary;

  /// The color of the text on [skeletonPrimary].
  @override
  final Color onSkeletonPrimary;

  /// The color of the shimmer.
  @override
  final Color shimmer;

  /// The color of the shadow.
  @override
  final Color shadow;

  /// The color of the avatar border on [background].
  @override
  final Color avatarBorderOnBackground;

  /// @nodoc
  const AppColorScheme({
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.tertiary,
    required this.onTertiary,
    required this.surface,
    required this.surfaceSecondary,
    required this.surfaceTertiary,
    required this.surfaceHigh,
    required this.onSurfaceVariant,
    required this.onSurface,
    required this.surfaceContainer,
    required this.background,
    required this.onBackground,
    required this.onBackgroundSecondary,
    required this.danger,
    required this.onDanger,
    required this.textField,
    required this.textFieldLabel,
    required this.textFieldHelper,
    required this.frameTextFieldSecondary,
    required this.inactive,
    required this.onInactive,
    required this.positive,
    required this.onPositive,
    required this.skeletonPrimary,
    required this.onSkeletonPrimary,
    required this.shimmer,
    required this.shadow,
    required this.avatarBorderOnBackground,
  });

  /// Base dark theme version.
  AppColorScheme.dark()
      : primary = const Color(0xFFD9D9D9),
        onPrimary = const Color(0xFF000000),
        secondary = const Color(0xFF35C518),
        onSecondary = const Color(0xFFFFFFFF),
        tertiary = const Color(0xFF9747FF),
        onTertiary = const Color(0xFFFFFFFF),
        surface = const Color(0xFF505050),
        surfaceSecondary = const Color(0xFFFFF2CF),
        surfaceTertiary = const Color(0xFFE4EEFC),
        surfaceHigh = const Color(0xFFE7E7E7),
        onSurface = const Color(0xFF303030),
        onSurfaceVariant = const Color(0xFF7C7C7C),
        surfaceContainer = const Color(0xFFFFFFFF),
        background = const Color(0xFF3E3C3C),
        onBackground = const Color(0xFFFFFFFF),
        onBackgroundSecondary = const Color(0xFF000000),
        danger = const Color(0xFFDF3222),
        onDanger = const Color(0xFFFFFFFF),
        textField = const Color(0xFF303030),
        textFieldLabel = const Color(0xFF7C7C7C),
        textFieldHelper = const Color(0xFF7C7C7C),
        frameTextFieldSecondary = const Color(0xFF303030),
        inactive = const Color(0xFF898989),
        onInactive = const Color(0xFFF3F3F3),
        positive = const Color(0xFF23DDF9),
        onPositive = const Color(0xFFFFFFFF),
        skeletonPrimary = Colors.black.withOpacity(_skeletonOpacity),
        onSkeletonPrimary = const Color(0xFFFFFFFF),
        shimmer = Colors.black,
        shadow = Colors.black.withOpacity(0.25),
        avatarBorderOnBackground = const Color(0xFFE7E7E7);
}
