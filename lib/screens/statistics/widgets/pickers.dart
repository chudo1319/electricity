import 'package:electricity/common/styles/app_sizes.dart';
import 'package:electricity/common/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

enum PickerType { date, time }

class PeriodPicker extends StatelessWidget {
  const PeriodPicker({
    super.key,
    required this.title,
    this.startValue,
    this.endValue,
    this.onStartChanged,
    this.onEndChanged,
    required this.type,
    this.showError = false,
  });

  final String title;
  final String? startValue;
  final String? endValue;
  final void Function(String)? onStartChanged;
  final void Function(String)? onEndChanged;
  final PickerType type;
  final bool showError;

  DateTime? _parseDate(String? value) {
    if (value == null || value.isEmpty) return null;
    try {
      return DateTime.parse(value);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final startDate = _parseDate(startValue);
    final endDate = _parseDate(endValue);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.text.medium13.copyWith(color: context.color.inactive),
        ),
        const Gap(AppSizes.double6),
        Row(
          children: [
            Expanded(
              child: PickerButton(
                text: 'с',
                value: startValue ?? '',
                onChanged: onStartChanged,
                type: type,
                showError: showError,
                maxDate: endDate,
              ),
            ),
            const Gap(AppSizes.double6),
            Container(height: 2, width: 10, color: context.color.inactive),
            const Gap(AppSizes.double6),
            Expanded(
              child: PickerButton(
                text: 'по',
                value: endValue ?? '',
                onChanged: onEndChanged,
                type: type,
                showError: showError,
                minDate: startDate,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PickerButton extends StatefulWidget {
  const PickerButton({
    super.key,
    required this.text,
    this.value = '',
    this.onChanged,
    required this.type,
    this.showError = false,
    this.minDate,
    this.maxDate,
  });

  final String text;
  final String value;
  final void Function(String)? onChanged;
  final PickerType type;
  final bool showError;
  final DateTime? minDate;
  final DateTime? maxDate;

  @override
  State<PickerButton> createState() => _PickerButtonState();
}

class _PickerButtonState extends State<PickerButton> {
  String formatDate(DateTime date) {
    return DateFormat("d MMMM. yyyy", "ru_RU").format(date);
  }

  String formatDisplayDate(String isoDate) {
    if (isoDate.isEmpty) return '';
    final date = DateTime.parse(isoDate);
    return formatDate(date);
  }

  String formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat("HH:mm", "ru_RU").format(dt);
  }

  String formatDisplayTime(String isoTime) {
    if (isoTime.isEmpty) return '';
    final time = DateTime.parse(isoTime);
    return DateFormat("HH:mm", "ru_RU").format(time);
  }

  Future<void> _showDatePicker() async {
    List<DateTime?>? picked = await showCalendarDatePicker2Dialog(
      context: context,
      dialogBackgroundColor: context.color.primary,
      config: CalendarDatePicker2WithActionButtonsConfig(
        yearTextStyle: context.text.regular16.copyWith(
          color: context.color.onPrimary,
        ),
        monthTextStyle: context.text.regular16.copyWith(
          color: context.color.onPrimary,
        ),
        dayTextStyle: context.text.regular16.copyWith(
          color: context.color.onPrimary,
        ),
        calendarType: CalendarDatePicker2Type.single,
        selectedDayHighlightColor: context.color.positive,
        lastMonthIcon: Icon(
          Icons.arrow_back_ios,
          size: AppSizes.double12,
          color: context.color.onPrimary,
        ),
        nextMonthIcon: Icon(
          Icons.arrow_forward_ios,
          size: AppSizes.double12,
          color: context.color.onPrimary,
        ),
        okButton: Text('Выбрать'),
        okButtonTextStyle: context.text.regular16.copyWith(
          color: context.color.onPrimary,
        ),
        cancelButton: Text('Отмена'),
        cancelButtonTextStyle: context.text.regular16.copyWith(
          color: context.color.onPrimary,
        ),
        disabledDayTextStyle: context.text.regular16.copyWith(
          color: context.color.inactive,
        ),
        selectableDayPredicate: (date) {
          if (widget.minDate != null && date.isBefore(widget.minDate!)) {
            return false;
          }
          if (widget.maxDate != null && date.isAfter(widget.maxDate!)) {
            return false;
          }
          return true;
        },
      ),
      dialogSize: const Size(325, 400),
      borderRadius: BorderRadius.circular(AppSizes.double12),
      value:
          widget.value.isNotEmpty
              ? [DateTime.parse(widget.value)]
              : <DateTime?>[],
    );

    if (picked != null && picked.isNotEmpty && widget.onChanged != null) {
      final formattedDate = DateFormat(
        "yyyy-MM-dd'T'HH:mm:ss'Z'",
      ).format(picked.first!);
      widget.onChanged!(formattedDate);
    }
  }

  Future<void> _showTimePicker() async {
    final TimeOfDay? picked = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      cancelText: 'Отмена',
      confirmText: 'Выбрать',
      helpText: 'Выберите время',
      hourLabelText: 'Часы',
      minuteLabelText: 'Минуты',
      initialTime:
          widget.value.isNotEmpty
              ? TimeOfDay.fromDateTime(DateTime.parse(widget.value))
              : TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: context.color.onPrimary,
              onPrimary: context.color.primary,
              surface: context.color.primary,
              onSurface: context.color.onPrimary,
            ),
            timePickerTheme: TimePickerThemeData(
              backgroundColor: context.color.primary,
              hourMinuteTextStyle: context.text.medium20.copyWith(
                color: context.color.onPrimary,
              ),
              dayPeriodTextStyle: context.text.medium20.copyWith(
                color: context.color.onPrimary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && widget.onChanged != null) {
      final now = DateTime.now();
      final dt = DateTime(
        now.year,
        now.month,
        now.day,
        picked.hour,
        picked.minute,
      );

      if (widget.minDate != null) {
        final minTime = TimeOfDay.fromDateTime(widget.minDate!);
        if (picked.hour < minTime.hour ||
            (picked.hour == minTime.hour && picked.minute < minTime.minute)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Время должно быть не раньше ${formatTime(minTime)}',
                style: context.text.regular14.copyWith(
                  color: context.color.onPrimary,
                ),
              ),
              backgroundColor: context.color.danger,
            ),
          );
          return;
        }
      }

      if (widget.maxDate != null) {
        final maxTime = TimeOfDay.fromDateTime(widget.maxDate!);
        if (picked.hour > maxTime.hour ||
            (picked.hour == maxTime.hour && picked.minute > maxTime.minute)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Время должно быть не позже ${formatTime(maxTime)}',
                style: context.text.regular14.copyWith(
                  color: context.color.onPrimary,
                ),
              ),
              backgroundColor: context.color.danger,
            ),
          );
          return;
        }
      }

      final formattedTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(dt);
      widget.onChanged!(formattedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    String displayValue = '';
    if (widget.type == PickerType.date) {
      displayValue =
          widget.value.isNotEmpty
              ? formatDisplayDate(widget.value)
              : widget.text;
    } else {
      displayValue =
          widget.value.isNotEmpty
              ? formatDisplayTime(widget.value)
              : widget.text;
    }

    return GestureDetector(
      onTap: () {
        if (widget.value.isEmpty) {
          if (widget.type == PickerType.date) {
            _showDatePicker();
          } else {
            _showTimePicker();
          }
        } else if (widget.onChanged != null) {
          widget.onChanged!('');
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: AppSizes.double8,
            horizontal: AppSizes.double4,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.double8),
            border: Border.all(
              color:
                  widget.showError
                      ? context.color.danger
                      : context.color.inactive,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                displayValue,
                style: context.text.regular16.copyWith(
                  color:
                      widget.showError
                          ? context.color.danger
                          : context.color.inactive,
                ),
              ),
              SvgPicture.asset(
                widget.value.isEmpty
                    ? 'assets/icons/calendar.svg'
                    : 'assets/icons/cancel.svg',
                height: AppSizes.double20,
                colorFilter: ColorFilter.mode(
                  widget.showError
                      ? context.color.danger
                      : context.color.positive,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
