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
      final statusColors = [Colors.yellow, Colors.green, context.color.positive];
      final color = statusColors[typeIndex];

      return ChargerGridItem(
        number: id,
        type: types[typeIndex],
        rubles: 4999,
        energy: 150,
        status: color,
      );
    });

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: chargers.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemBuilder: (context, index) {
        return chargers[index];
      },
    );
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
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.029,
                  fontWeight: FontWeight.w600,
                  color: status,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$rubles руб',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.016,
                      color: context.color.onSecondary,
                    ),
                  ),
                  Gap(AppSizes.double4),
                  Text(
                    '$energy кВт*ч',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.016,
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
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.016,
                  color: context.color.onSecondary,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.02,
                height: MediaQuery.of(context).size.width * 0.02,
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
