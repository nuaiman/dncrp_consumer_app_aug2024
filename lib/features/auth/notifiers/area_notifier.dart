import 'package:dncrp_consumer_app/apis/area_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/area.dart';

class AreaNotifier extends StateNotifier<List<DivisionWithDistricts>> {
  final AreaApi _areaApi;
  AreaNotifier({required AreaApi areaApi})
      : _areaApi = areaApi,
        super([]);

  Future<void> getDivisionWithDistricts() async {
    final divisionsWithDistricts = await _areaApi.getDivisionWithDistricts();
    state = divisionsWithDistricts;
  }
}
// -----------------------------------------------------------------------------

final areaProvider =
    StateNotifierProvider<AreaNotifier, List<DivisionWithDistricts>>((ref) {
  final areaApi = ref.watch(areaApiProvider);
  return AreaNotifier(
    areaApi: areaApi,
  );
});
