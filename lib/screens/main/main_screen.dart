import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:electricity/common/navigation/app_router.gr.dart';
import 'package:electricity/common/styles/app_sizes.dart';
import 'package:electricity/common/widgets/buttons/primary_button.dart';
import 'package:electricity/screens/main/buttons/active_button.dart';
import 'package:electricity/screens/main/widgets/charger_grid.dart';
import 'package:electricity/screens/main/widgets/drawer_buttons.dart';
import 'package:electricity/screens/main/widgets/scroll_stations.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final TabController _tabController;
  Timer? _inactivityTimer;

  @override
  void initState() {
    super.initState();
    _resetInactivityTimer();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _inactivityTimer?.cancel();
    _tabController.dispose();
    super.dispose();
  }

  void _resetInactivityTimer() {
    _inactivityTimer?.cancel();
    _inactivityTimer = Timer(const Duration(minutes: 10), _handleInactivity);
  }

  void _handleInactivity() {
    if (mounted) {
      context.router.replace(const AuthRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) => _resetInactivityTimer(),
      child: GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dx > 20) {
            _scaffoldKey.currentState?.openDrawer();
          }
        },
        child: Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          drawer: DrawerButtons(),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                left: AppSizes.double6,
                right: AppSizes.double6,
                top: AppSizes.double12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      PrimaryButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        icon: 'assets/icons/left_arrow.svg',
                        onPressed: () {
                          context.router.back();
                        },
                      ),
                      Gap(AppSizes.double12),
                      PrimaryButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                      ),
                    ],
                  ),
                  Gap(AppSizes.double12),
                  ChargerGrid(),
                  Gap(AppSizes.double16),
                  TabActiveButtons(tabController: _tabController),
                  Gap(AppSizes.double12),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        SingleChildScrollView(
                          child: CurrentStations(textStatus: 'Не оплачено'),
                        ),
                        SingleChildScrollView(
                          child: CurrentStations(textStatus: 'Оплачено'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
