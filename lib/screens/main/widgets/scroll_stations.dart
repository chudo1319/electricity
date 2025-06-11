import 'package:electricity/common/styles/app_sizes.dart';
import 'package:electricity/common/utils/extensions/context_extensions.dart';
import 'package:electricity/screens/main/widgets/pop_up.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CurrentStations extends StatelessWidget {
  const CurrentStations({super.key, required this.textStatus});

  final String textStatus;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return index == 0 || index == 1 || textStatus == 'Оплачено'
            ? Padding(
              padding: const EdgeInsets.only(bottom: AppSizes.double8),
              child: Station(
                buildContext:
                    (context) =>
                        textStatus == 'Оплачено'
                            ? PopUpPay(
                              index: index,
                              okText: 'Не оплачено',
                              okButtonColor: context.color.danger,
                              status: context.color.positive,
                            )
                            : PopUpPay(
                              index: index,
                              okText: 'Оплачено',
                              okButtonColor: context.color.secondary,
                              status: context.color.positive,
                            ),
                stationNumber: index + 1,
                stationName: 'A57_0140',
                stationType: 'CCS',
                transactionDate: '13.06.2025 12:00',
                power: 22,
                energy: 10,
                percent: 75,
                colorStatus: context.color.positive,
                isPaid: true,
                textStatus: textStatus,
              ),
            )
            : Padding(
              padding: const EdgeInsets.only(bottom: AppSizes.double8),
              child: Station(
                buildContext:
                    (context) => PopUpClose(
                      index: index,
                      status: context.color.positive,
                    ),
                stationNumber: index + 1,
                stationName: 'A57_0140',
                stationType: 'CCS',
                transactionDate: '13.06.2025 12:00',
                power: 22,
                energy: 10,
                percent: 75,
                colorStatus: context.color.positive,
                isPaid: false,
              ),
            );
      },
    );
  }
}

class Station extends StatelessWidget {
  const Station({
    super.key,
    required this.stationNumber,
    required this.stationName,
    required this.stationType,
    required this.power,
    required this.energy,
    required this.percent,
    required this.colorStatus,
    required this.isPaid,
    required this.buildContext,
    required this.transactionDate,
    this.textStatus,  
  });

  final int stationNumber;
  final String stationName;
  final String stationType;
  final num power;
  final num energy;
  final num percent;
  final Color colorStatus;
  final bool isPaid;
  final String? textStatus;
  final Widget Function(BuildContext context)? buildContext;
  final String transactionDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (buildContext != null) {
          showDialog(
            context: context,
            builder: (context) => buildContext!(context),
          );
        }
      },
      child: Container(
        height: AppSizes.double70,
        width: double.infinity,
        padding: const EdgeInsets.all(AppSizes.double12),
        decoration: BoxDecoration(
          color: context.color.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  stationNumber.toString(),
                  style: context.text.medium16.copyWith(
                    color: context.color.onPrimary,
                  ),
                ),
                Gap(AppSizes.double8),
                Text(
                  stationName,
                  style: context.text.medium16.copyWith(
                    color: context.color.textFieldHelper,
                  ),
                ),
                Gap(AppSizes.double8),
                Text(
                  stationType,
                  style: context.text.medium16.copyWith(
                    color: context.color.onPrimary,
                  ),
                ),
                Gap(AppSizes.double8),
                // Text(
                //   transactionDate,
                //   textAlign: TextAlign.end,
                //   style: context.text.regular15.copyWith(
                //     color: context.color.inactive,
                //   ),
                // ),
                Spacer(),
                isPaid
                    ? Text(
                      textStatus!,
                      style: context.text.regular15.copyWith(
                        color:
                            textStatus == 'Оплачено'
                                ? context.color.secondary
                                : context.color.danger,
                      ),
                    )
                    : Container(
                      width: AppSizes.double12,
                      height: AppSizes.double12,
                      decoration: BoxDecoration(
                        color: colorStatus,
                        shape: BoxShape.circle,
                      ),
                    ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.double8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$power кВт',
                    style: context.text.regular15.copyWith(
                      color: context.color.onPrimary,
                    ),
                  ),
                  Text(
                    '$energy кВт*ч',
                    style: context.text.regular15.copyWith(
                      color: context.color.onPrimary,
                    ),
                  ),
                  Text(
                    '$percent%',
                    style: context.text.regular15.copyWith(
                      color: context.color.onPrimary,
                    ),
                  ),
                  Text(
                    transactionDate,
                    textAlign: TextAlign.end,
                    style: context.text.regular15.copyWith(
                      color: context.color.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
