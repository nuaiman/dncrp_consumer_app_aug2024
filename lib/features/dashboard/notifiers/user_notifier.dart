import 'package:dncrp_consumer_app/apis/user_api.dart';
import 'package:dncrp_consumer_app/core/notifiers/loader_notifier.dart';
import 'package:dncrp_consumer_app/core/utils/navigators.dart';
import 'package:dncrp_consumer_app/features/dashboard/screens/dasboard_screen.dart';
import 'package:dncrp_consumer_app/models/person.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserNotifier extends StateNotifier<Person?> {
  final LoaderNotifier _loader;
  final UserApi _userApi;
  UserNotifier({required LoaderNotifier loader, required UserApi userApi})
      : _loader = loader,
        _userApi = userApi,
        super(null);

  Future<void> getPerson(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 10), () {
      _loader.updateState(true);
    });

    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    final resposne =
        await _userApi.getPerson(accessToken: 'Bearer ${accessToken!}');
    if (resposne != null) {
      state = resposne;
      navigateAndRemoveUntil(context, const DashboardScreen());
    } else {
      return;
    }
    await Future.delayed(const Duration(milliseconds: 10), () {
      _loader.updateState(false);
    });
  }
}
// -----------------------------------------------------------------------------

final userProvider = StateNotifierProvider<UserNotifier, Person?>((ref) {
  final loader = ref.watch(loaderProvider.notifier);
  final userApi = ref.watch(userApiProvider);
  return UserNotifier(loader: loader, userApi: userApi);
});
