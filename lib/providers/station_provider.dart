import 'package:electricity/mock/scroll_stations/mock_station_operations.dart';
import 'package:electricity/mock/scroll_stations/station_operation.dart';
import 'package:flutter/material.dart';

class StationProvider extends ChangeNotifier {
  List<StationOperation> _operations = [];
  List<StationOperation> _archiveOperations = [];

  StationProvider() {
    _loadOperations();
  }

  void _loadOperations() {
    _operations = MockStationOperations.getMockOperations();
    _archiveOperations = MockStationOperations.getArchiveOperations();
    notifyListeners();
  }

  List<StationOperation> get activeOperations {
    final activeOps =
        _operations
            .where(
              (op) =>
                  op.status == OperationStatus.error ||
                  op.status == OperationStatus.unpaid ||
                  op.status == OperationStatus.inProgress,
            )
            .toList();
    return StationOperation.sortOperations(activeOps);
  }

  List<StationOperation> get archiveOperations {
    final archiveOps =
        _operations
            .where((operation) => operation.status == OperationStatus.paid)
            .toList()
          ..sort((a, b) {
            // Сортировка по дате завершения (от новых к старым)
            final aDate = a.endDate ?? a.startDate;
            final bDate = b.endDate ?? b.startDate;
            return bDate.compareTo(aDate);
          });
    return archiveOps;
  }

  StationOperation? getStationByNumber(int number) {
    try {
      return _operations.firstWhere((op) => op.stationNumber == number);
    } catch (e) {
      return null;
    }
  }

  void updateStationStatus(int stationNumber, OperationStatus newStatus) {
    final index = _operations.indexWhere(
      (op) => op.stationNumber == stationNumber,
    );
    if (index != -1) {
      final operation = _operations[index];
      _operations[index] = StationOperation(
        stationNumber: operation.stationNumber,
        stationName: operation.stationName,
        stationType: operation.stationType,
        power: operation.power,
        energy: operation.energy,
        percent: operation.percent,
        colorStatus: operation.colorStatus,
        status: newStatus,
        startDate: operation.startDate,
        endDate:
            newStatus == OperationStatus.paid
                ? DateTime.now()
                : operation.endDate,
      );
      _loadOperations(); // Перезагружаем операции для обновления архивных
      notifyListeners();
    }
  }
}
