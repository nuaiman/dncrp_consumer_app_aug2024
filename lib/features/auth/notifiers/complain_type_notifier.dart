import 'package:dncrp_consumer_app/apis/complain_api.dart';
import 'package:dncrp_consumer_app/models/complain_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComplainTypeNotifier extends StateNotifier<List<ComplainType>> {
  final ComplainApi _complainApi;
  ComplainTypeNotifier({required ComplainApi complainApi})
      : _complainApi = complainApi,
        super([]);

  Future<void> getComplainTypes() async {
    final complainTypes = await _complainApi.fetchComplainTypes();
    state = complainTypes;
  }
}
// -----------------------------------------------------------------------------

final complainTypeProvider =
    StateNotifierProvider<ComplainTypeNotifier, List<ComplainType>>((ref) {
  final complainApi = ref.watch(complainApiProvider);
  return ComplainTypeNotifier(
    complainApi: complainApi,
  );
});
