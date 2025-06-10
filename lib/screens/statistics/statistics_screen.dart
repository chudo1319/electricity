import 'package:auto_route/auto_route.dart';
import 'package:electricity/common/styles/app_sizes.dart';
import 'package:electricity/screens/statistics/widgets/statistics_title.dart';
import 'package:flutter/material.dart';

@RoutePage()
class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppSizes.double100),
        child: StatisticsTitle(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.double20,
            vertical: AppSizes.double12,
          ),
          child: Column(children: [
            ],
          ),
        ),
      ),
    );
  }
}
