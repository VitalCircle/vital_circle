import 'package:flutter/material.dart';
import 'package:vital_circle/routes.dart';
import 'package:vital_circle/shared/shared.dart';
import 'package:vital_circle/themes/theme.dart';

import 'dashboard.vm.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<DashboardViewModel>(
      model: DashboardViewModel.of(context),
      onModelReady: (model) {
        model.onInit();
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: SharedAppBar(
            title: const Text('Vital Circle'),
          ),
          body: Builder(builder: (BuildContext context) {
            return _buildScreen(context, model);
          }),
          drawer: DrawerWidget(),
        );
      },
    );
  }

  Widget _buildScreen(BuildContext context, DashboardViewModel model) {
    if (!model.isReady) {
      return _buildLoading();
    }
    return _buildDashboard(context, model);
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildDashboard(BuildContext context, DashboardViewModel model) {
    return Container(
      child: Column(
        children: [
          _buildGreeting(),
          const SizedBox(height: Spacers.lg),
          model.hasCheckedInToday
              ? NavigationCard(
                  title: 'Thank you for checking in today!',
                  icon: Icons.check_circle,
                )
              : NavigationCard(
                  title: 'Check-in',
                  subtitle: 'Log your symptoms and temperature.',
                  icon: Icons.check_circle_outline,
                  routeName: RouteName.Checkin,
                ),
          const SizedBox(height: Spacers.md),
          NavigationCard(
            title: 'History',
            subtitle: 'Look at your previous symptoms and edit records.',
            icon: Icons.calendar_today,
            routeName: RouteName.CheckinHistory,
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      padding: const EdgeInsets.all(24),
    );
  }

  Widget _buildGreeting() {
    return Text(
      'Good day, Human',
      style: AppTypography.h2,
    );
  }
}
