import 'package:flutter/material.dart';

import 'common/navigation/app_router.dart';
import 'common/styles/themes/app_theme_data.dart';

void main() {
  runApp(Electricity());
}

class Electricity extends StatelessWidget {
  Electricity({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _appRouter.config(),
      theme: AppThemeData.darkTheme,
    );
  }
}
