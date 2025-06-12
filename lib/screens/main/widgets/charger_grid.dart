import 'package:electricity/common/styles/app_sizes.dart';
import 'package:electricity/common/utils/extensions/context_extensions.dart';
import 'package:electricity/mock/scroll_stations/station_operation.dart';
import 'package:electricity/providers/station_provider.dart';
import 'package:electricity/screens/main/widgets/pop_up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChargerGrid extends StatelessWidget {
  const ChargerGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StationProvider>(
      builder: (context, provider, child) {
        final operations = provider.activeOperations;
        final chargers = List.generate(operations.length, (index) {
          final operation = operations.firstWhere(
            (op) => op.stationNumber == index + 1,
            orElse:
                () => StationOperation(
                  stationNumber: index + 1,
                  stationName:
                      'A57_${(index + 140).toString().padLeft(4, '0')}',
                  stationType: ['GB/T', 'CCS', 'CHAdeMO'][index % 3],
                  power: 0,
                  energy: 0,
                  percent: 0,
                  colorStatus: context.color.positive,
                  status: OperationStatus.paid,
                  startDate: DateTime.now(),
                ),
          );

          // Определяем цвет статуса в зависимости от состояния
          Color getStatusColor(StationOperation op) {
            switch (op.status) {
              case OperationStatus.error:
              case OperationStatus.unpaid:
                return context.color.danger;
              case OperationStatus.inProgress:
                return context.color.secondary;
              case OperationStatus.paid:
                return context.color.positive;
            }
          }

          return ChargerGridItem(
            number: operation.stationNumber,
            type: operation.stationType,
            energy: operation.energy.toInt(),
            status: getStatusColor(operation),
            operation: operation,
          );
        });

        return Wrap(spacing: 2, runSpacing: 2, children: chargers);
      },
    );
  }
}

class ChargerGridItem extends StatelessWidget {
  const ChargerGridItem({
    super.key,
    required this.number,
    required this.energy,
    required this.type,
    required this.status,
    required this.operation,
  });

  final int number;
  final int energy;
  final String type;
  final Color status;
  final StationOperation operation;

  @override
  Widget build(BuildContext context) {
    final isError = operation.status == OperationStatus.error;

    return GestureDetector(
      onTap:
          isError
              ? null // Отключаем onTap для статуса "Ошибка"
              : () {
                if (operation.status == OperationStatus.paid) {
                  showDialog(
                    context: context,
                    builder:
                        (context) => PopUpTextField(
                          index: number - 1,
                          status: status,
                          operation: operation,
                        ),
                  );
                } else if (operation.status == OperationStatus.unpaid) {
                  showDialog(
                    context: context,
                    builder:
                        (context) => PopUpPay(
                          index: number - 1,
                          okText: 'Не оплачено',
                          okButtonColor: context.color.danger,
                          status: status,
                          operation: operation,
                        ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder:
                        (context) => PopUpClose(
                          index: number - 1,
                          status: status,
                          operation: operation,
                        ),
                  );
                }
              },
      child: Stack(
        children: [
          Container(
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
                      style: context.text.medium13.copyWith(
                        color: status,
                        decorationColor: status,
                        decorationThickness: 2,
                      ),
                    ),
                    Text(
                      '$energy кВт*ч',
                      style: context.text.regular8.copyWith(
                        color: context.color.onSecondary,
                        decorationColor: context.color.onSecondary,
                        decorationThickness: 1,
                      ),
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
                        decorationColor: context.color.onSecondary,
                        decorationThickness: 1,
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
          ),
          if (isError)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: status, width: 2),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
