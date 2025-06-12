import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'common/navigation/app_router.dart';
import 'common/styles/themes/app_theme_data.dart';
import 'providers/station_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ru_RU', null);
  runApp(const Electricity());
}

class Electricity extends StatelessWidget {
  const Electricity({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StationProvider(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter().config(),
        theme: AppThemeData.darkTheme,
      ),
    );
  }
}
