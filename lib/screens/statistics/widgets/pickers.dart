import 'package:electricity/common/styles/app_sizes.dart';
import 'package:electricity/common/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class DataPicker extends StatelessWidget {
  const DataPicker({
    super.key,
    required this.title,
    this.startDate,
    this.endDate,
    this.changeStartDate,
    this.changeEndDate,
  });

  final String title;
  final String? startDate;
  final String? endDate;
  final void Function(String)? changeStartDate;
  final void Function(String)? changeEndDate;

  @override
  Widget build(BuildContext context) {
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
              child: DatePickerButton(
                text: 'с',
                value: startDate ?? '',
                changeDate: changeStartDate,
              ),
            ),
            const Gap(AppSizes.double6),
            Container(height: 2, width: 10, color: context.color.inactive),
            const Gap(AppSizes.double6),
            Expanded(
              child: DatePickerButton(
                text: 'по',
                value: endDate ?? '',
                changeDate: changeEndDate,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DatePickerButton extends StatefulWidget {
  const DatePickerButton({
    super.key,
    required this.text,
    this.value = '',
    this.changeDate,
  });

  final String text;
  final String value;
  final void Function(String)? changeDate;

  @override
  State<DatePickerButton> createState() => _DatePickerButtonState();
}

class _DatePickerButtonState extends State<DatePickerButton> {
  String formatDate(DateTime date) {
    return DateFormat("d MMMM. yyyy", "ru_RU").format(date);
  }

  String formatDisplayDate(String isoDate) {
    if (isoDate.isEmpty) return '';
    final date = DateTime.parse(isoDate);
    return formatDate(date);
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
      ),
      dialogSize: const Size(325, 400),
      borderRadius: BorderRadius.circular(AppSizes.double12),
    );

    if (picked != null && picked.isNotEmpty && widget.changeDate != null) {
      final formattedDate = DateFormat(
        "yyyy-MM-dd'T'HH:mm:ss'Z'",
      ).format(picked.first!);
      widget.changeDate!(formattedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.value.isEmpty) {
          _showDatePicker();
        } else if (widget.changeDate != null) {
          widget.changeDate!('');
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
            border: Border.all(color: context.color.inactive),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.value.isNotEmpty
                    ? formatDisplayDate(widget.value)
                    : widget.text,
                style: context.text.regular16.copyWith(
                  color: context.color.inactive,
                ),
              ),
              SvgPicture.asset(
                widget.value.isEmpty
                    ? 'assets/icons/calendar.svg'
                    : 'assets/icons/cancel.svg',
                height: AppSizes.double20,
                colorFilter: ColorFilter.mode(
                  context.color.positive,
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

class TimePicker extends StatelessWidget {
  const TimePicker({
    super.key,
    required this.title,
    this.startTime,
    this.endTime,
    this.changeStartTime,
    this.changeEndTime,
  });

  final String title;
  final String? startTime;
  final String? endTime;
  final void Function(String)? changeStartTime;
  final void Function(String)? changeEndTime;

  @override
  Widget build(BuildContext context) {
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
              child: TimePickerButton(
                text: 'с',
                value: startTime ?? '',
                changeTime: changeStartTime,
              ),
            ),
            const Gap(AppSizes.double6),
            Container(height: 2, width: 10, color: context.color.inactive),
            const Gap(AppSizes.double6),
            Expanded(
              child: TimePickerButton(
                text: 'по',
                value: endTime ?? '',
                changeTime: changeEndTime,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TimePickerButton extends StatefulWidget {
  const TimePickerButton({
    super.key,
    required this.text,
    this.value = '',
    this.changeTime,
  });

  final String text;
  final String value;
  final void Function(String)? changeTime;

  @override
  State<TimePickerButton> createState() => _TimePickerButtonState();
}

class _TimePickerButtonState extends State<TimePickerButton> {
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

  Future<void> _showTimePicker() async {
    final TimeOfDay? picked = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      cancelText: 'Отмена',
      confirmText: 'Выбрать',
      helpText: 'Выберите время',
      hourLabelText: 'Часы',
      minuteLabelText: 'Минуты',
      initialTime: TimeOfDay.now(),
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

    if (picked != null && widget.changeTime != null) {
      final now = DateTime.now();
      final dt = DateTime(
        now.year,
        now.month,
        now.day,
        picked.hour,
        picked.minute,
      );
      final formattedTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(dt);
      widget.changeTime!(formattedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.value.isEmpty) {
          _showTimePicker();
        } else if (widget.changeTime != null) {
          widget.changeTime!('');
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
            border: Border.all(color: context.color.inactive),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.value.isNotEmpty
                    ? formatDisplayTime(widget.value)
                    : widget.text,
                style: context.text.regular16.copyWith(
                  color: context.color.inactive,
                ),
              ),
              SvgPicture.asset(
                widget.value.isEmpty
                    ? 'assets/icons/calendar.svg'
                    : 'assets/icons/cancel.svg',
                height: AppSizes.double20,
                colorFilter: ColorFilter.mode(
                  context.color.positive,
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
