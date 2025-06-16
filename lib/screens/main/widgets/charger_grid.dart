import 'package:electricity/common/styles/app_sizes.dart';
import 'package:electricity/common/utils/extensions/context_extensions.dart';
import 'package:electricity/mock/scroll_stations/station_operation.dart';
import 'package:electricity/providers/station_provider.dart';
import 'package:electricity/screens/main/widgets/pop_up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:electricity/common/func/get_status_color.dart';

class ChargerGrid extends StatelessWidget {
  const ChargerGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StationProvider>(
      builder: (context, provider, child) {
        final operations = List<StationOperation>.from(provider.gridOperations)
          ..sort((a, b) => a.stationNumber.compareTo(b.stationNumber));
        final chargers = List.generate(operations.length, (index) {
          final operation = operations[index];

          return ChargerGridItem(
            number: operation.stationNumber,
            type: operation.stationType,
            energy: operation.energy.toInt(),
            status: getConnectorStatusColor(operation, context),
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
    return GestureDetector(
      onTap: () {
        if (operation.status == ConnectorStatus.free ||
            operation.status == ConnectorStatus.connected) {
          showDialog(
            context: context,
            builder:
                (context) => PopUpTextField(
                  index: number - 1,
                  status: status,
                  operation: operation,
                ),
          );
        } else if (operation.status == ConnectorStatus.charging) {
          showDialog(
            context: context,
            builder:
                (context) => PopUpClose(
                  okText: 'Завершить',
                  index: number - 1,
                  status: status,
                  operation: operation,
                ),
          );
        } else if (operation.status == ConnectorStatus.error) {
          showDialog(
            context: context,
            builder: (context) => PopUpError(operation: operation),
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
              color: getSessionStatusColor(operation.sessionStatus, context),
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
                      style: context.text.medium15.copyWith(
                        color:
                            status == context.color.disabledStatus
                                ? context.color.onSecondary
                                : status,
                      ),
                    ),
                    Text(
                      '$energy кВт•ч',
                      style: context.text.regular10.copyWith(
                        color:
                            operation.sessionStatus == SessionStatus.unpaid
                                ? context.color.onPrimary
                                : context.color.onSecondary,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      type,
                      style: context.text.regular10.copyWith(
                        color:
                            operation.sessionStatus == SessionStatus.unpaid
                                ? context.color.onPrimary
                                : context.color.onSecondary,
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
        ],
      ),
    );
  }
}
