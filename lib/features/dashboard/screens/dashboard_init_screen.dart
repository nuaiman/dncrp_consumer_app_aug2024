import 'package:dncrp_consumer_app/features/auth/notifiers/area_notifier.dart';
import 'package:dncrp_consumer_app/features/auth/notifiers/complain_type_notifier.dart';
import 'package:dncrp_consumer_app/features/dashboard/notifiers/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardInit extends ConsumerStatefulWidget {
  const DashboardInit({super.key});

  @override
  ConsumerState<DashboardInit> createState() => _DashboardInitState();
}

class _DashboardInitState extends ConsumerState<DashboardInit> {
  @override
  void initState() {
    ref.read(complainTypeProvider.notifier).getComplainTypes();
    ref.read(areaProvider.notifier).getDivisionWithDistricts();
    ref.read(userProvider.notifier).getPerson(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
