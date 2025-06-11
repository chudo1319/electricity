import 'package:flutter/material.dart';

enum OperationStatus { error, unpaid, inProgress, paid }

class StationOperation {
  final int stationNumber;
  final String stationName;
  final String stationType;
  final num power;
  final num energy;
  final num percent;
  final Color colorStatus;
  final OperationStatus status;
  final DateTime startDate;
  final DateTime? endDate;

  StationOperation({
    required this.stationNumber,
    required this.stationName,
    required this.stationType,
    required this.power,
    required this.energy,
    required this.percent,
    required this.colorStatus,
    required this.status,
    required this.startDate,
    this.endDate,
  });

  static List<StationOperation> getArchiveOperations(
    List<StationOperation> operations,
  ) {
    return operations
        .where((operation) => operation.status == OperationStatus.paid)
        .toList()
      ..sort((a, b) {
        // Сортировка по дате завершения (от новых к старым)
        final aDate = a.endDate ?? a.startDate;
        final bDate = b.endDate ?? b.startDate;
        return bDate.compareTo(aDate);
      });
  }

  static List<StationOperation> sortOperations(
    List<StationOperation> operations,
  ) {
    return List<StationOperation>.from(operations)..sort((a, b) {
      // Сначала сортируем по статусу
      if (a.status != b.status) {
        if (a.status == OperationStatus.error) return -1;
        if (b.status == OperationStatus.error) return 1;
        if (a.status == OperationStatus.unpaid) return -1;
        if (b.status == OperationStatus.unpaid) return 1;
      }

      // Затем сортируем по дате в зависимости от статуса
      if (a.status == OperationStatus.error ||
          a.status == OperationStatus.unpaid) {
        // Для ошибок и неоплаченных используем дату завершения
        final aDate = a.endDate ?? a.startDate;
        final bDate = b.endDate ?? b.startDate;
        return bDate.compareTo(aDate);
      } else {
        // Для остальных используем дату начала
        return b.startDate.compareTo(a.startDate); 
      }
    });
  }
}
