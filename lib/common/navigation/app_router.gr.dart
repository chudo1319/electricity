// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:electricity/screens/auth/auth_screen.dart' as _i1;
import 'package:electricity/screens/main/main_screen.dart' as _i2;

/// generated route for
/// [_i1.AuthScreen]
class AuthRoute extends _i3.PageRouteInfo<void> {
  const AuthRoute({List<_i3.PageRouteInfo>? children})
    : super(AuthRoute.name, initialChildren: children);

  static const String name = 'AuthRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.AuthScreen();
    },
  );
}

/// generated route for
/// [_i2.MainScreen]
class MainRoute extends _i3.PageRouteInfo<void> {
  const MainRoute({List<_i3.PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.MainScreen();
    },
  );
}
