import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'common/navigation/app_router.dart';
import 'common/styles/themes/app_theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ru_RU', null);
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
