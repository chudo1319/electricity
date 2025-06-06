import 'package:electricity/common/styles/app_sizes.dart';
import 'package:electricity/common/utils/extensions/context_extensions.dart';
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
                stationName: 'A57_0140',
                stationType: 'CCS',
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
                stationName: 'A57_0140',
                stationType: 'CCS',
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
    required this.stationName,
    required this.stationType,
    required this.power,
    required this.energy,
    required this.percent,
    required this.colorStatus,
    required this.isPaid,
    this.textStatus,
  });

  final String stationName;
  final String stationType;
  final num power;
  final num energy;
  final num percent;
  final Color colorStatus;
  final bool isPaid;
  final String? textStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.double70,
      width: double.infinity,
      padding: const EdgeInsets.all(12),
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
                stationName,
                style: context.text.medium16.copyWith(
                  color: context.color.onPrimary,
                ),
              ),
              Gap(AppSizes.double8),
              Text(
                stationType,
                style: context.text.regular15.copyWith(
                  color: context.color.textFieldHelper,
                ),
              ),
              Spacer(),
              isPaid
                  ? Text(
                    textStatus!,
                    style: context.text.regular15.copyWith(
                      color: context.color.danger,
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
            padding: const EdgeInsets.symmetric(horizontal: 18),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
