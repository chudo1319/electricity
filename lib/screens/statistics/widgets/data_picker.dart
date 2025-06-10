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

    if (picked != null && picked.isNotEmpty) {
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
        } else {
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
                widget.value.isNotEmpty == true ? widget.value : widget.text,
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
