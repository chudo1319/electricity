import 'package:auto_route/auto_route.dart';
import 'package:electricity/common/styles/app_sizes.dart';
import 'package:electricity/common/utils/extensions/context_extensions.dart';
import 'package:electricity/common/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class StatisticsTitle extends StatelessWidget {
  const StatisticsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(AppSizes.double12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.double20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PrimaryButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                icon: 'assets/icons/left_arrow.svg',
                onPressed: () {
                  context.router.back();
                },
              ),
              Gap(AppSizes.double12),
              Text(
                'Статистика и аналитика',
                style: context.text.medium20.copyWith(
                  color: context.color.onSecondary,
                ),
              ),
            ],
          ),
        ),
        Divider(color: context.color.onPrimary),
      ],
    );
  }
}
