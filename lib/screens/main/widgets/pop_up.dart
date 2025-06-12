import 'package:electricity/common/styles/app_sizes.dart';
import 'package:electricity/common/utils/extensions/context_extensions.dart';
import 'package:electricity/mock/scroll_stations/station_operation.dart';
import 'package:electricity/providers/station_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:slide_to_act/slide_to_act.dart';

class PopUp extends StatelessWidget {
  const PopUp({
    super.key,
    this.content,
    required this.cancel,
    required this.ok,
    this.cancelButtonColor,
    this.okButtonColor,
    required this.operation,
    this.onPressed,
    this.onSubmit,
  });

  final Widget? content;
  final String cancel;
  final String ok;
  final Color? cancelButtonColor;
  final Color? okButtonColor;
  final StationOperation operation;
  final VoidCallback? onPressed;
  final Future<void> Function()? onSubmit;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.color.primary,
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: AppSizes.double40,
                height: AppSizes.double40,
                decoration: BoxDecoration(
                  color: context.color.onBackgroundSecondary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    operation.stationNumber.toString(),
                    style: context.text.semiBold31.copyWith(
                      color: operation.colorStatus,
                    ),
                  ),
                ),
              ),
              Gap(AppSizes.double8),
              Text(
                operation.transactionDate,
                style: context.text.medium20.copyWith(
                  color: context.color.onPrimary,
                ),
              ),
            ],
          ),
          Gap(AppSizes.double8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                operation.stationName,
                style: context.text.regular16.copyWith(
                  color: context.color.inactive,
                ),
              ),
              Spacer(),
              Text(
                operation.stationType,
                style: context.text.regular16.copyWith(
                  color: context.color.onPrimary,
                ),
              ),
            ],
          ),
          Divider(color: context.color.onPrimary),
        ],
      ),
      titleTextStyle: context.text.medium16.copyWith(
        color: context.color.onPrimary,
      ),
      content: content,
      contentTextStyle: context.text.regular16.copyWith(
        color: context.color.onPrimary,
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            elevation: 6,
            fixedSize: Size(140, AppSizes.double16),
            backgroundColor: cancelButtonColor,
            side: BorderSide(
              color: context.color.onPrimary,
              width: AppSizes.double05,
            ),
          ),
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: Text(
            cancel,
            style: context.text.regular13.copyWith(
              color: context.color.onPrimary,
            ),
          ),
        ),
        SizedBox(
          width: 140,
          child: SlideAction(
            alignment: Alignment.center,
            height: AppSizes.double32,
            outerColor: okButtonColor,
            sliderButtonIconPadding: AppSizes.double8,
            sliderButtonIconSize: AppSizes.double8,
            onSubmit:
                onSubmit ??
                () async {
                  if (onPressed != null) {
                    onPressed!();
                  }
                  Navigator.pop(context, 'OK');
                },
            child: Text(
              ok,
              style: context.text.regular11.copyWith(
                color: context.color.onSecondary,
              ),
            ),
          ),
        ),
      ],
      actionsAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}

class PopUpClose extends StatelessWidget {
  const PopUpClose({
    super.key,
    required this.index,
    required this.status,
    required this.operation,
  });

  final int index;
  final Color status;
  final StationOperation operation;

  @override
  Widget build(BuildContext context) {
    return PopUp(
      operation: operation,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Мощность: ${operation.power} кВт'),
          Gap(AppSizes.double8),
          Text('Заряд: ${operation.percent}%'),
          Gap(AppSizes.double8),
          Text('Энергия: ${operation.energy} кВт*ч'),
          Gap(AppSizes.double8),
          Text('Напряжение: 400 В'),
        ],
      ),
      cancel: 'Закрыть',
      cancelButtonColor: context.color.onBackgroundSecondary,
      ok: 'Завершить',
      okButtonColor: context.color.danger,
      onPressed: null,
      onSubmit: () async {
        Navigator.pop(context);
        context.read<StationProvider>().updateStationStatus(
          operation.stationNumber,
          OperationStatus.paid,
        );
        showDialog(
          context: context,
          builder:
              (context) => PopUpPay(
                index: index,
                okText: 'Оплачено',
                okButtonColor: context.color.secondary,
                status: status,
                operation: operation,
                onOkPressed: () => Navigator.pop(context),
              ),
        );
      },
    );
  }
}

class PopUpPay extends StatelessWidget {
  const PopUpPay({
    super.key,
    required this.index,
    required this.okText,
    required this.okButtonColor,
    required this.status,
    required this.operation,
    this.onOkPressed,
  });

  final int index;
  final String okText;
  final Color okButtonColor;
  final Color status;
  final StationOperation operation;
  final VoidCallback? onOkPressed;

  @override
  Widget build(BuildContext context) {
    return PopUp(
      operation: operation,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              'Итого',
              style: context.text.medium20.copyWith(
                color: context.color.onPrimary,
              ),
            ),
          ),
          Gap(AppSizes.double16),
          Text('Заряд: c ${operation.percent}% до 80%'),
          Gap(AppSizes.double8),
          Text('Энергия: ${operation.energy} кВт*ч'),
        ],
      ),
      cancel: 'Закрыть',
      ok: okText,
      cancelButtonColor: context.color.onBackgroundSecondary,
      okButtonColor: okButtonColor,
      onPressed: null,
      onSubmit: () async => Navigator.pop(context),
    );
  }
}

class PopUpTextField extends StatefulWidget {
  const PopUpTextField({
    super.key,
    required this.index,
    required this.status,
    required this.operation,
  });

  final int index;
  final Color status;
  final StationOperation operation;

  @override
  State<PopUpTextField> createState() => _PopUpTextFieldState();
}

class _PopUpTextFieldState extends State<PopUpTextField> {
  final TextEditingController socController = TextEditingController();
  final TextEditingController kwhController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  @override
  void dispose() {
    socController.dispose();
    kwhController.dispose();
    timeController.dispose();
    super.dispose();
  }

  void _onChanged() {
    setState(() {});
  }

  bool get isAnyFilled =>
      socController.text.isNotEmpty ||
      kwhController.text.isNotEmpty ||
      timeController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    socController.addListener(_onChanged);
    kwhController.addListener(_onChanged);
    timeController.addListener(_onChanged);
  }

  @override
  Widget build(BuildContext context) {
    final socEnabled = socController.text.isNotEmpty || !isAnyFilled;
    final kwhEnabled = kwhController.text.isNotEmpty || !isAnyFilled;
    final timeEnabled = timeController.text.isNotEmpty || !isAnyFilled;

    return PopUp(
      operation: widget.operation,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          PopUpTextFieldItem(
            hintText: 'Лимит SOC',
            controller: socController,
            enabled: socEnabled,
          ),
          Gap(AppSizes.double8),
          PopUpTextFieldItem(
            hintText: 'Лимит кВт*ч',
            controller: kwhController,
            enabled: kwhEnabled,
          ),
          Gap(AppSizes.double8),
          PopUpTextFieldItem(
            hintText: 'Лимит времени',
            controller: timeController,
            enabled: timeEnabled,
          ),
        ],
      ),
      cancel: 'Закрыть',
      ok: 'Начать',
      cancelButtonColor: context.color.onBackgroundSecondary,
      okButtonColor: context.color.secondary,
      onSubmit: () async {
        context.read<StationProvider>().updateStationStatus(
          widget.operation.stationNumber,
          OperationStatus.inProgress,
        );
        Navigator.pop(context);
      },
    );
  }
}

class PopUpTextFieldItem extends StatelessWidget {
  const PopUpTextFieldItem({
    super.key,
    required this.hintText,
    this.controller,
    this.enabled = true,
  });

  final String hintText;
  final TextEditingController? controller;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      textAlign: TextAlign.start,
      cursorHeight: AppSizes.double20,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSizes.double12,
          vertical: AppSizes.double8,
        ),
        fillColor: context.color.onBackgroundSecondary,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: AppSizes.double05,
            color: context.color.inactive,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: context.color.onPrimary,
            width: AppSizes.double05,
          ),
        ),
        hintText: hintText,
        hintStyle: context.text.regular16.copyWith(
          color: context.color.inactive,
        ),
      ),
    );
  }
}
