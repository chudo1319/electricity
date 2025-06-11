import 'package:electricity/common/styles/app_sizes.dart';
import 'package:electricity/common/utils/extensions/context_extensions.dart';
import 'package:electricity/mock/scroll_stations/mock_station_operations.dart';
import 'package:electricity/mock/scroll_stations/station_operation.dart';
import 'package:electricity/screens/main/widgets/pop_up.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class CurrentStations extends StatelessWidget {
  const CurrentStations({super.key, this.isArchive = false});

  final bool isArchive;

  @override
  Widget build(BuildContext context) {
    final allOperations = MockStationOperations.getMockOperations();
    final operations =
        isArchive
            ? allOperations
                .where((operation) => operation.status == OperationStatus.paid)
                .toList()
            : allOperations
                .where(
                  (operation) =>
                      operation.status == OperationStatus.error ||
                      operation.status == OperationStatus.unpaid ||
                      operation.status == OperationStatus.inProgress,
                )
                .toList();

    final sortedOperations =
        isArchive
            ? (operations..sort(
              (a, b) => (b.endDate ?? b.startDate).compareTo(
                a.endDate ?? a.startDate,
              ),
            ))
            : StationOperation.sortOperations(operations);

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sortedOperations.length,
      itemBuilder: (context, index) {
        final operation = sortedOperations[index];
        final isErrorOrUnpaid =
            operation.status == OperationStatus.error ||
            operation.status == OperationStatus.unpaid;

        String? getStatusText(OperationStatus status) {
          switch (status) {
            case OperationStatus.error:
              return 'Ошибка';
            case OperationStatus.unpaid:
              return 'Не оплачено';
            case OperationStatus.paid:
              return 'Оплачено';
            case OperationStatus.inProgress:
              return null;
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
                          status: context.color.positive,
                        )
                        : isErrorOrUnpaid
                        ? PopUpPay(
                          index: index,
                          okText: getStatusText(operation.status) ?? '',
                          okButtonColor:
                              operation.status == OperationStatus.error
                                  ? context.color.danger
                                  : context.color.secondary,
                          status: context.color.positive,
                        )
                        : PopUpClose(
                          index: index,
                          status: context.color.positive,
                        ),
            stationNumber: operation.stationNumber,
            stationName: operation.stationName,
            stationType: operation.stationType,
            transactionDate: DateFormat('dd.MM.yyyy HH:mm').format(
              operation.status == OperationStatus.inProgress && !isArchive
                  ? operation.startDate
                  : (operation.endDate ?? operation.startDate),
            ),
            power: operation.power,
            energy: operation.energy,
            percent: operation.percent,
            colorStatus: operation.colorStatus,
            isPaid: isArchive || operation.status != OperationStatus.inProgress,
            textStatus: getStatusText(operation.status),
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
                    ? textStatus != null
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
