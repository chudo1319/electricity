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
  final bool wasError;

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
    this.wasError = false,
  });

  String get transactionDate => DateFormat(
    'dd.MM.yyyy HH:mm',
  ).format(status == ConnectorStatus.free ? startDate : (endDate ?? startDate));

  static List<StationOperation> getArchiveOperations(
    List<StationOperation> operations,
  ) {
    return operations
        .where((operation) => operation.status == ConnectorStatus.paid)
        .toList()
      ..sort((a, b) {
        // Сортировка по дате начала (от новых к старым)
        final aDate = a.startDate;
        final bDate = b.startDate;
        return bDate.compareTo(aDate);
      });
  }

  static List<StationOperation> sortOperations(
    List<StationOperation> operations,
  ) {
    bool isError(StationOperation op) => op.status == ConnectorStatus.error;
    bool isUnpaid(StationOperation op) =>
        op.status == ConnectorStatus.unpaid || op.sessionStatus == SessionStatus.unpaid;

    return List<StationOperation>.from(operations)..sort((a, b) {
      if (isError(a) && !isError(b)) return -1;
      if (!isError(a) && isError(b)) return 1;
      if (isUnpaid(a) && !isUnpaid(b)) return -1;
      if (!isUnpaid(a) && isUnpaid(b)) return 1;

      // Далее сортировка по дате, как раньше
      final aDate = a.endDate ?? a.startDate;
      final bDate = b.endDate ?? b.startDate;
      return bDate.compareTo(aDate);
    });
  }
}
