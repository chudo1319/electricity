import 'package:auto_route/auto_route.dart';
import 'package:electricity/common/styles/app_sizes.dart';
import 'package:electricity/common/utils/extensions/context_extensions.dart';
import 'package:electricity/common/widgets/buttons/primary_button.dart';
import 'package:electricity/screens/statistics/widgets/data_picker.dart';
import 'package:electricity/screens/statistics/widgets/report.dart';
import 'package:electricity/screens/statistics/widgets/statistics_title.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

@RoutePage()
class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  bool showReport = false;
  String? saveStatus; 

  void _onSave() async {
    final success = false;
    setState(() {
      saveStatus = success ? 'success' : 'error';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppSizes.double70),
        child: StatisticsTitle(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.double20,
            vertical: AppSizes.double12,
          ),
          child: Column(
            children: [
              DataPicker(title: 'Выберите период'),
              Gap(AppSizes.double12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryButton(
                    width: MediaQuery.of(context).size.width * 0.44,
                    text: 'Сформировать',
                    onPressed: () {
                      setState(() {
                        showReport = true;
                        saveStatus = null;
                      });
                    },
                  ),
                  PrimaryButton(
                    width: MediaQuery.of(context).size.width * 0.44,
                    text: 'Сохранить',
                    onPressed: _onSave,
                  ),
                ],
              ),
              Gap(AppSizes.double12),
              if (showReport) ...[
                Report(),
                if (saveStatus == 'success')
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Успешно сохранено!',
                      style: context.text.medium16.copyWith(
                        color: context.color.secondary,
                      ),
                    ),
                  ),
                if (saveStatus == 'error')
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Ошибка при сохранении',
                      style: context.text.medium16.copyWith(
                        color: context.color.danger,
                      ),
                    ),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
