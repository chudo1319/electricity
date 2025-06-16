import 'package:intl/intl.dart';

enum ConnectorStatus { free, connected, charging, error, unpaid, paid }
enum SessionStatus { available, unpaid }

class StationOperation {
  final int stationNumber;
  final String stationName;
  final String stationType;
  final num power;
  final num energy;
  final num percent;
  final ConnectorStatus status;
  final SessionStatus sessionStatus;
  final DateTime startDate;
  final DateTime? endDate;

  StationOperation({
    required this.stationNumber,
    required this.stationName,
    required this.stationType,
    required this.power,
    required this.energy,
    required this.percent,
    required this.status,
    required this.sessionStatus,
    required this.startDate,
    this.endDate,
  });

  String get transactionDate => DateFormat('dd.MM.yyyy HH:mm').format(
    status == ConnectorStatus.free ? startDate : (endDate ?? startDate),
  );

  static List<StationOperation> getArchiveOperations(
    List<StationOperation> operations,
  ) {
    return operations
        .where((operation) => operation.status == ConnectorStatus.paid)
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
        if (a.status == ConnectorStatus.error) return -1;
        if (b.status == ConnectorStatus.error) return 1;
        if (a.status == ConnectorStatus.unpaid) return -1;
        if (b.status == ConnectorStatus.unpaid) return 1;
      }

      // Затем сортируем по дате в зависимости от статуса
      if (a.status == ConnectorStatus.error ||
          a.status == ConnectorStatus.unpaid) {
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
