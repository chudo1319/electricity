import 'package:electricity/common/styles/app_sizes.dart';
import 'package:electricity/common/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class Report extends StatelessWidget {
  const Report({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.double12),
      decoration: BoxDecoration(
        color: context.color.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Количество сессий, шт.',
                style: context.text.medium16.copyWith(
                  color: context.color.onPrimary,
                ),
              ),
              Text(
                '100',
                style: context.text.medium16.copyWith(
                  color: context.color.onPrimary,
                ),
              ),
            ],
          ),
          Divider(color: context.color.onPrimary),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Затраченная энергия, кВт',
                style: context.text.medium16.copyWith(
                  color: context.color.onPrimary,
                ),
              ),
              Text(
                '5000',
                style: context.text.medium16.copyWith(
                  color: context.color.onPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
