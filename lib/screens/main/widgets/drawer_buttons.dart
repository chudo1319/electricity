import 'package:auto_route/auto_route.dart';
import 'package:electricity/common/navigation/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:electricity/common/styles/app_sizes.dart';
import 'package:electricity/common/utils/extensions/context_extensions.dart';
import 'package:gap/gap.dart';

class DrawerButtons extends StatelessWidget {
  const DrawerButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: context.color.shimmer,
        child: Column(
          children: [
            Gap(AppSizes.double60),
            DrawerButton(text: 'Статистика и аналитика', onPressed: () {
              context.router.push(const StatisticsRoute());
            }),
            Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.only(bottom: AppSizes.double60),
              child: DrawerButton(
                text: 'Выход из профиля',
                onPressed: () {
                  context.router.replace(const AuthRoute());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerButton extends StatelessWidget {
  const DrawerButton({super.key, required this.text, required this.onPressed});
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.double8,
        horizontal: AppSizes.double16,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: context.color.primary,
          foregroundColor: context.color.shimmer,
          minimumSize: Size(double.infinity, AppSizes.double40),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: context.text.regular16.copyWith(
            color: context.color.onPrimary,
          ),
        ),
      ),
    );
  }
}
