import 'package:flutter/material.dart';
import 'package:electricity/mock/scroll_stations/station_operation.dart';
import 'package:electricity/common/utils/extensions/context_extensions.dart';

Color getConnectorStatusColor(StationOperation op, BuildContext context) {
  switch (op.status) {
    case ConnectorStatus.error:
    case ConnectorStatus.unpaid:
      return context.color.errorStatus;
    case ConnectorStatus.free:
      return context.color.freeStatus;
    case ConnectorStatus.paid:
      return context.color.secondary;
    case ConnectorStatus.connected:
      return context.color.connectedStatus;
    case ConnectorStatus.charging:
      return context.color.chargingStatus;
  }
}

Color getSessionStatusColor(SessionStatus sessionStatus, BuildContext context) {
  switch (sessionStatus) {
    case SessionStatus.available:
      return context.color.shimmer;
    case SessionStatus.unpaid:
      return context.color.primary;
  }
}