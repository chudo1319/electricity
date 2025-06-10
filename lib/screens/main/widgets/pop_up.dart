import 'package:electricity/common/styles/app_sizes.dart';
import 'package:electricity/common/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PopUp extends StatelessWidget {
  const PopUp({
    super.key,
    this.content,
    required this.cancel,
    required this.ok,
    this.cancelButtonColor,
    this.okButtonColor,
    required this.stationNumber,
    required this.stationName,
    required this.stationType,
    this.onPressed,
  });

  final Widget? content;
  final String cancel;
  final String ok;
  final Color? cancelButtonColor;
  final Color? okButtonColor;
  final int stationNumber;
  final String stationName;
  final String stationType;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.color.primary,
      title: Column(
        children: [
          Row(
            children: [
              Text(stationNumber.toString()),
              Gap(AppSizes.double8),
              Text(
                stationName,
                style: context.text.regular16.copyWith(
                  color: context.color.inactive,
                ),
              ),
              Spacer(),
              Text(stationType),
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
            fixedSize: Size(AppSizes.double100, AppSizes.double16),
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
        TextButton(
          style: TextButton.styleFrom(
            fixedSize: Size(AppSizes.double100, AppSizes.double16),
            backgroundColor: okButtonColor,
            side: BorderSide(
              color: context.color.onPrimary,
              width: AppSizes.double05,
            ),
          ),
          onPressed: onPressed ?? () => Navigator.pop(context, 'OK'),
          child: Text(
            ok,
            style: context.text.regular13.copyWith(
              color: context.color.onSecondary,
            ),
          ),
        ),
      ],
      actionsAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}

class PopUpClose extends StatelessWidget {
  const PopUpClose({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return PopUp(
      stationNumber: index + 1,
      stationName: 'A57_0140',
      stationType: 'CCS',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Мощность: 22 кВт'),
          Gap(AppSizes.double8),
          Text('Заряд: 75%'),
          Gap(AppSizes.double8),
          Text('Энергия: 15 кВт*ч'),
          Gap(AppSizes.double8),
          Text('Напряжение: 400 В'),
        ],
      ),
      cancel: 'Закрыть',
      cancelButtonColor: context.color.onBackgroundSecondary,
      ok: 'Завершить',
      okButtonColor: context.color.danger,
      onPressed: () {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) => PopUpPay(index: index),
        );
      },
    );
  }
}

class PopUpPay extends StatelessWidget {
  const PopUpPay({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return PopUp(
      stationNumber: index + 1,
      stationName: 'A57_0140',
      stationType: 'CCS',
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
          Text('Заряд: c 20% до 80%'),
          Gap(AppSizes.double8),
          Text('Энергия: 15 кВт*ч'),
        ],
      ),
      cancel: 'Закрыть',
      ok: 'Оплатить',
      cancelButtonColor: context.color.onBackgroundSecondary,
      okButtonColor: context.color.secondary,
    );
  }
}

class PopUpTextField extends StatelessWidget {
  const PopUpTextField({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return PopUp(
      stationNumber: index + 1,
      stationName: 'A57_0140',
      stationType: 'CCS',
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          PopUpTextFieldItem(hintText: 'Лимит SOC'),
          Gap(AppSizes.double8),
          PopUpTextFieldItem(hintText: 'Лимит кВт*ч'),
          Gap(AppSizes.double8),
          PopUpTextFieldItem(hintText: 'Лимит времени'),
        ],
      ),
      cancel: 'Закрыть',
      ok: 'Оплатить',
      cancelButtonColor: context.color.onBackgroundSecondary,
      okButtonColor: context.color.secondary,
    );
  }
}

class PopUpTextFieldItem extends StatelessWidget {
  const PopUpTextFieldItem({super.key, required this.hintText});

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
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
