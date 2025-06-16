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
                  op.status == ConnectorStatus.error ||
                  op.status == ConnectorStatus.unpaid ||
                  op.status == ConnectorStatus.charging,
            )
            .toList();
    return StationOperation.sortOperations(activeOps);
  }

  List<StationOperation> get archiveOperations {
    final archiveOps =
        _operations
            .where((operation) =>
                operation.status == ConnectorStatus.paid ||
                operation.status == ConnectorStatus.error)
            .toList()
          ..sort((a, b) {
            final aDate = a.endDate ?? a.startDate;
            final bDate = b.endDate ?? b.startDate;
            return bDate.compareTo(aDate);
          });
    return archiveOps;
  }

  List<StationOperation> get gridOperations {
    final gridOps =
        _operations
            .where(
              (op) =>
                  op.status == ConnectorStatus.error ||
                  op.status == ConnectorStatus.unpaid ||
                  op.status == ConnectorStatus.charging ||
                  op.status == ConnectorStatus.free ||
                  op.status == ConnectorStatus.connected,
            )
            .toList();
    return StationOperation.sortOperations(gridOps);
  }

  StationOperation? getStationByNumber(int number) {
    try {
      return _operations.firstWhere((op) => op.stationNumber == number);
    } catch (e) {
      return null;
    }
  }

  void updateStationStatus(int stationNumber, ConnectorStatus newStatus) {
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
        status: newStatus,
        sessionStatus: operation.sessionStatus,
        startDate: operation.startDate,
        endDate:
            newStatus == ConnectorStatus.paid
                ? DateTime.now()
                : operation.endDate,
        wasError: (operation.status == ConnectorStatus.error && newStatus == ConnectorStatus.paid)
            ? true
            : operation.wasError,
      );
      notifyListeners();
    }
  }
}
