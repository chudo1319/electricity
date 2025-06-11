import 'package:auto_route/auto_route.dart';
import 'package:electricity/common/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';

import '../../common/navigation/app_router.gr.dart';
import '../../common/styles/app_sizes.dart';
import '../../common/widgets/buttons/primary_button.dart';

@RoutePage()
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final pinController = TextEditingController();
  bool isError = false;

  void onCompleted(String pin) {
    setState(() {
      isError = pin != '0055';
    });
  }

  void onContinue() {
    if (pinController.text == '0055') {
      context.router.pushAndPopUntil(
        const MainRoute(),
        predicate: (_) => false,
      );
    } else {
      setState(() {
        isError = true;
      });
    }
  }

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.double20,
            vertical: AppSizes.double12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', width: 300, height: 300),
              Gap(AppSizes.double60),
              Pinput(
                controller: pinController,
                onCompleted: onCompleted,
                errorText: isError ? 'Неверный PIN-код' : null,
                defaultPinTheme: PinTheme(
                  width: AppSizes.double60,
                  height: AppSizes.double60,
                  textStyle: context.text.medium16.copyWith(
                    color: context.color.onSecondary,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: context.color.inactive),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                errorPinTheme: PinTheme(
                  width: AppSizes.double60,
                  height: AppSizes.double60,
                  textStyle: context.text.medium16.copyWith(
                    color: context.color.danger,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: context.color.danger),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              if (isError) ...[
                Gap(AppSizes.double8),
                Text(
                  'Неверный PIN-код',
                  style: context.text.regular13.copyWith(
                    color: context.color.danger,
                  ),
                ),
              ],
              Spacer(),
              PrimaryButton(
                width: double.infinity,
                textStyle: context.text.medium16,
                textColor: context.color.onPrimary,
                onPressed: onContinue,
                text: 'Продолжить',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
