import 'package:auto_route/auto_route.dart';
import 'package:electricity/common/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';

import '../../common/navigation/app_router.gr.dart';
import '../../common/styles/app_sizes.dart';
import '../../common/widgets/buttons/primary_button.dart';

@RoutePage()
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

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
              Image.asset('assets/images/logo.png', width: MediaQuery.of(context).size.width * 0.5),
              Gap(AppSizes.double60),
              Pinput(
                onCompleted: (pin) => print(pin),
                defaultPinTheme: PinTheme(
                  width: AppSizes.double60,
                  height: AppSizes.double60,
                  textStyle: context.text.medium16.copyWith(
                    color: context.color.onSecondary,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: context.color.inactive,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Spacer(),
              PrimaryButton(
                width: double.infinity,
                textStyle: context.text.medium16,
                textColor: context.color.onPrimary,
                onPressed: () {
                  context.router.pushAndPopUntil(
                    MainRoute(),
                    predicate: (_) => false,
                  );
                },
                text: 'Продолжить',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
