import 'package:electricity/common/styles/app_sizes.dart';
import 'package:electricity/common/utils/extensions/context_extensions.dart';
import 'package:electricity/mock/scroll_stations/station_operation.dart';
import 'package:electricity/providers/station_provider.dart';
import 'package:electricity/screens/main/widgets/pop_up.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

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
                operation.status == OperationStatus.error ||
                operation.status == OperationStatus.unpaid;

            String? getStatusText(OperationStatus status) {
              if (isArchive) return 'Оплачено';
              switch (status) {
                case OperationStatus.error:
                  return 'Ошибка';
                case OperationStatus.unpaid:
                  return 'Не оплачено';
                case OperationStatus.paid:
                case OperationStatus.inProgress:
                  return null;
              }
            }

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

            return Padding(
              padding: const EdgeInsets.only(bottom: AppSizes.double8),
              child: Station(
                buildContext:
                    (context) =>
                        isArchive
                            ? PopUpClose(
                              index: index,
                              status: getStatusColor(operation),
                              operation: operation,
                            )
                            : isErrorOrUnpaid
                            ? PopUpPay(
                              index: index,
                              okText: getStatusText(operation.status) ?? '',
                              okButtonColor: context.color.danger,
                              status: getStatusColor(operation),
                              operation: operation,
                            )
                            : PopUpClose(
                              index: index,
                              status: getStatusColor(operation),
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
    String? getStatusText(OperationStatus status) {
      if (isArchive) return 'Оплачено';
      switch (status) {
        case OperationStatus.error:
          return 'Ошибка';
        case OperationStatus.unpaid:
          return 'Не оплачено';
        case OperationStatus.paid:
        case OperationStatus.inProgress:
          return null;
      }
    }

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

    final statusColor = getStatusColor(operation);
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
                  style: context.text.medium20.copyWith(
                    color: statusColor,
                  ),
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
                    style: context.text.regular15.copyWith(
                      color: context.color.danger,
                    ),
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
