import 'package:electricity/mock/scroll_stations/station_operation.dart';
import 'package:flutter/material.dart';

class MockStationOperations {
  static List<StationOperation> getMockOperations() {
    final now = DateTime.now();
    return [
      // Операции с ошибками
      StationOperation(
        stationNumber: 1,
        stationName: 'A57_0140',
        stationType: 'CCS',
        power: 22,
        energy: 10,
        percent: 75,
        colorStatus: Colors.red,
        status: OperationStatus.error,
        startDate: now.subtract(const Duration(hours: 2)),
        endDate: now.subtract(const Duration(hours: 1)),
      ),
      StationOperation(
        stationNumber: 2,
        stationName: 'A57_0141',
        stationType: 'CCS',
        power: 25,
        energy: 15,
        percent: 80,
        colorStatus: Colors.red,
        status: OperationStatus.error,
        startDate: now.subtract(const Duration(hours: 4)),
        endDate: now.subtract(const Duration(hours: 3)),
      ),
      // Неоплаченные операции
      StationOperation(
        stationNumber: 3,
        stationName: 'A57_0142',
        stationType: 'CCS',
        power: 20,
        energy: 12,
        percent: 60,
        colorStatus: Colors.red,
        status: OperationStatus.unpaid,
        startDate: now.subtract(const Duration(hours: 3)),
        endDate: now.subtract(const Duration(hours: 2)),
      ),
      StationOperation(
        stationNumber: 4,
        stationName: 'A57_0143',
        stationType: 'CCS',
        power: 18,
        energy: 8,
        percent: 45,
        colorStatus: Colors.red,
        status: OperationStatus.unpaid,
        startDate: now.subtract(const Duration(hours: 5)),
        endDate: now.subtract(const Duration(hours: 4)),
      ),
      // Операции в процессе
      StationOperation(
        stationNumber: 5,
        stationName: 'A57_0144',
        stationType: 'CCS',
        power: 30,
        energy: 20,
        percent: 90,
        colorStatus: Colors.green,
        status: OperationStatus.inProgress,
        startDate: now.subtract(const Duration(hours: 1)),
      ),
      StationOperation(
        stationNumber: 6,
        stationName: 'A57_0145',
        stationType: 'CCS',
        power: 28,
        energy: 18,
        percent: 85,
        colorStatus: Colors.green,
        status: OperationStatus.inProgress,
        startDate: now.subtract(const Duration(hours: 6)),
      ),
      // Архивные операции (оплаченные)
      StationOperation(
        stationNumber: 7,
        stationName: 'A57_0146',
        stationType: 'CCS',
        power: 35,
        energy: 25,
        percent: 100,
        colorStatus: Colors.green,
        status: OperationStatus.paid,
        startDate: now.subtract(const Duration(days: 2)),
        endDate: now.subtract(const Duration(days: 1, hours: 23)),
      ),
      StationOperation(
        stationNumber: 8,
        stationName: 'A57_0147',
        stationType: 'CCS',
        power: 32,
        energy: 22,
        percent: 95,
        colorStatus: Colors.green,
        status: OperationStatus.paid,
        startDate: now.subtract(const Duration(days: 3)),
        endDate: now.subtract(const Duration(days: 2, hours: 23)),
      ),
      StationOperation(
        stationNumber: 9,
        stationName: 'A57_0148',
        stationType: 'CCS',
        power: 28,
        energy: 18,
        percent: 85,
        colorStatus: Colors.green,
        status: OperationStatus.paid,
        startDate: now.subtract(const Duration(days: 4)),
        endDate: now.subtract(const Duration(days: 3, hours: 23)),
      ),
    ];
  }

  static List<StationOperation> getArchiveOperations() {
    return StationOperation.getArchiveOperations(getMockOperations());
  }
}
