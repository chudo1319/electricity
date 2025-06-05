import 'package:flutter/material.dart';

import '../../styles/colors/app_color_scheme.dart';
import '../../styles/text/app_text_scheme.dart';


extension ContextExtensions on BuildContext {
  AppColorScheme get color => Theme.of(this).extension<AppColorScheme>()!;

  AppTextScheme get text => Theme.of(this).extension<AppTextScheme>()!;
}
