import 'package:auto_route/auto_route.dart';
import 'package:electricity/common/styles/app_sizes.dart';
import 'package:electricity/common/utils/extensions/context_extensions.dart';
import 'package:electricity/common/widgets/buttons/primary_button.dart';
import 'package:electricity/screens/statistics/widgets/pickers.dart';
import 'package:electricity/screens/statistics/widgets/report.dart';
import 'package:electricity/screens/statistics/widgets/statistics_title.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

@RoutePage()
class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  bool showReport = false;
  String? saveStatus;
  bool showDateError = false;
  bool showTimeError = false;

  String? _startDate;
  String? _endDate;
  String? _startTime;
  String? _endTime;

  bool get _isPeriodValid => _startDate != null && _endDate != null;
  bool get _isTimeValid => _startTime != null && _endTime != null;
  bool get _isFormValid => _isPeriodValid && _isTimeValid;

  void _onGenerate() {
    if (!_isPeriodValid) {
      setState(() => showDateError = true);
    }
    if (!_isTimeValid) {
      setState(() => showTimeError = true);
    }
    if (_isFormValid) {
      setState(() {
        showReport = true;
        saveStatus = null;
        showDateError = false;
        showTimeError = false;
      });
    }
  }

  void _onSave() async {
    if (!showReport) return;
    final success = true;
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
              PeriodPicker(
                title: 'Выберите период',
                startValue: _startDate,
                endValue: _endDate,
                onStartChanged:
                    (val) => setState(() {
                      _startDate = val;
                      showDateError = false;
                    }),
                onEndChanged:
                    (val) => setState(() {
                      _endDate = val;
                      showDateError = false;
                    }),
                type: PickerType.date,
                showError: showDateError,
              ),
              if (showDateError)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    'Выберите период',
                    style: context.text.regular14.copyWith(
                      color: context.color.danger,
                    ),
                  ),
                ),
              Gap(AppSizes.double12),
              PeriodPicker(
                title: 'Выберите время',
                startValue: _startTime,
                endValue: _endTime,
                onStartChanged:
                    (val) => setState(() {
                      _startTime = val;
                      showTimeError = false;
                    }),
                onEndChanged:
                    (val) => setState(() {
                      _endTime = val;
                      showTimeError = false;
                    }),
                type: PickerType.time,
                showError: showTimeError,
              ),
              if (showTimeError)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    'Выберите время',
                    style: context.text.regular14.copyWith(
                      color: context.color.danger,
                    ),
                  ),
                ),
              Gap(AppSizes.double20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryButton(
                    width: MediaQuery.of(context).size.width * 0.44,
                    text: 'Сформировать',
                    onPressed: _onGenerate,
                    isEnabled: true,
                  ),
                  PrimaryButton(
                    width: MediaQuery.of(context).size.width * 0.44,
                    text: 'Сохранить',
                    onPressed: showReport ? _onSave : null,
                    isEnabled: showReport,
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
