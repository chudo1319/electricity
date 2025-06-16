import 'package:electricity/common/styles/app_sizes.dart';
import 'package:electricity/common/utils/extensions/context_extensions.dart';
import 'package:electricity/mock/scroll_stations/station_operation.dart';
import 'package:electricity/providers/station_provider.dart';
import 'package:electricity/screens/main/widgets/pop_up.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:electricity/common/func/get_status_color.dart';

class CurrentStations extends StatelessWidget {
  const CurrentStations({super.key, this.isArchive = false});

  final bool isArchive;

  @override
  Widget build(BuildContext context) {
    return Consumer<StationProvider>(
      builder: (context, provider, child) {
        final operations =
            isArchive ? provider.archiveOperations : provider.activeOperations;

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: operations.length,
          itemBuilder: (context, index) {
            final operation = operations[index];
            final isErrorOrUnpaid =
                operation.status == ConnectorStatus.error ||
                operation.status == ConnectorStatus.unpaid;

            return Padding(
              padding: const EdgeInsets.only(bottom: AppSizes.double8),
              child: Station(
                buildContext:
                    (context) =>
                        isArchive
                            ? PopUpClose(
                              index: index,
                              status: getConnectorStatusColor(operation, context),
                              operation: operation,
                            )
                            : isErrorOrUnpaid
                            ? PopUpPay(
                              index: index,
                              status: getConnectorStatusColor(operation, context),
                              okButtonColor: context.color.secondary,
                              operation: operation,
                            )
                            : PopUpClose(
                              index: index,
                              status: getConnectorStatusColor(operation, context),
                              operation: operation,
                            ),
                operation: operation,
                isArchive: isArchive,
              ),
            );
          },
        );
      },
    );
  }
}

class Station extends StatelessWidget {
  const Station({
    super.key,
    required this.operation,
    required this.buildContext,
    required this.isArchive,
  });

  final StationOperation operation;
  final Widget Function(BuildContext context)? buildContext;
  final bool isArchive;

  @override
  Widget build(BuildContext context) {
    String? getStatusText(ConnectorStatus status) {
      if (isArchive) return 'Оплачено';
      switch (status) {
        case ConnectorStatus.error:
          return 'Ошибка';
        case ConnectorStatus.unpaid:
          return 'Не оплачено';
        case ConnectorStatus.paid:
        case ConnectorStatus.free:
        case ConnectorStatus.connected:
        case ConnectorStatus.charging:
          return null;
      }
    }

    final statusColor = getConnectorStatusColor(operation, context);
    final statusText = getStatusText(operation.status);

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
                  operation.stationNumber.toString(),
                  style: context.text.medium20.copyWith(color: statusColor),
                ),
                Gap(AppSizes.double8),
                Text(
                  operation.stationName,
                  style: context.text.medium16.copyWith(
                    color: context.color.textFieldHelper,
                  ),
                ),
                Gap(AppSizes.double8),
                Text(
                  operation.stationType,
                  style: context.text.medium16.copyWith(
                    color: context.color.onPrimary,
                  ),
                ),
                Gap(AppSizes.double8),
                Spacer(),
                if (statusText != null)
                  Text(
                    statusText,
                    style: context.text.regular15.copyWith(color: statusColor),
                  )
                else
                  Container(
                    width: AppSizes.double12,
                    height: AppSizes.double12,
                    decoration: BoxDecoration(
                      color: statusColor,
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
                    '${operation.power} кВт',
                    style: context.text.regular15.copyWith(
                      color: context.color.onPrimary,
                    ),
                  ),
                  Text(
                    '${operation.energy} кВт*ч',
                    style: context.text.regular15.copyWith(
                      color: context.color.onPrimary,
                    ),
                  ),
                  Text(
                    '${operation.percent}%',
                    style: context.text.regular15.copyWith(
                      color: context.color.onPrimary,
                    ),
                  ),
                  Text(
                    operation.transactionDate,
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
