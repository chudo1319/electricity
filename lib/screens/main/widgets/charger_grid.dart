import 'package:electricity/common/styles/app_sizes.dart';
import 'package:electricity/common/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ChargerGrid extends StatelessWidget {
  const ChargerGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ChargerGridItem> chargers = List.generate(15, (index) {
      final id = index + 1;
      final types = ['GB/T', 'CCS', 'CHAdeMO'];
      final typeIndex = index % 3;
      final statusColors = [
        Colors.yellow,
        Colors.green,
        context.color.positive,
      ];
      final color = statusColors[typeIndex];

      return ChargerGridItem(
        number: id,
        type: types[typeIndex],
        rubles: 4999,
        energy: 150,
        status: color,
      );
    });

    return Wrap(spacing: 2, runSpacing: 2, children: chargers);
  }
}

class ChargerGridItem extends StatelessWidget {
  const ChargerGridItem({
    super.key,
    required this.number,
    required this.rubles,
    required this.energy,
    required this.type,
    required this.status,
  });

  final int number;
  final int rubles;
  final int energy;
  final String type;
  final Color status;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.double70,
      width: AppSizes.double80,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.color.shimmer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                number.toString(),
                style: context.text.medium13.copyWith(color: status),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$rubles руб',
                    style: context.text.regular8.copyWith(
                      color: context.color.onSecondary,
                    ),
                  ),
                  Gap(AppSizes.double4),
                  Text(
                    '$energy кВт*ч',
                    style: context.text.regular8.copyWith(
                      color: context.color.onSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                type,
                style: context.text.regular8.copyWith(
                  color: context.color.onSecondary,
                ),
              ),
              Container(
                width: AppSizes.double12,
                height: AppSizes.double12,
                decoration: BoxDecoration(
                  color: status,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
