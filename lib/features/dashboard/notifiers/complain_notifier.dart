import 'dart:io';

import 'package:dncrp_consumer_app/apis/complain_api.dart';
import 'package:dncrp_consumer_app/core/notifiers/language_notifier.dart';
import 'package:dncrp_consumer_app/core/notifiers/loader_notifier.dart';
import 'package:dncrp_consumer_app/models/complaint.dart';
import 'package:dncrp_consumer_app/models/complain_type.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/area.dart';

class ComplainNotifier extends StateNotifier<List<Complaint>> {
  final LoaderNotifier _loader;
  final ComplainApi _complainApi;
  ComplainNotifier(
      {required LoaderNotifier loader, required ComplainApi complainApi})
      : _loader = loader,
        _complainApi = complainApi,
        super([]);

  Future<void> createComplain(
    BuildContext context,
    AppLanguage language, {
    required String userId,
    required String complainerId,
    required String name,
    required String phone,
    required String nid,
    required String address,
    required Division division,
    required District district,
    required ComplainType complainType,
    required String orgName,
    required String orgAddress,
    required Division orgDivision,
    required District orgDistrict,
    required String complainDescription,
    required List<File> evidences,
  }) async {
    final complaint = Complaint(
      complainerId: complainerId,
      complainId: '',
      trackingId: '',
      complainTypeId: complainType.id,
      complainType: complainType.name,
      accusedOrganizationName: orgName,
      accusedOrganizationAddress: orgAddress,
      complainDescription: complainDescription,
      victimNID: nid,
      victimName: name,
      victimPhone: phone,
      victimPresentAddress: address,
      districtId: district.id,
      district: district.name,
      divisionId: division.id,
      division: division.name,
      evidences: [],
      victimUserId: userId,
    );
    _loader.updateState(true);
    await _complainApi.createComplaint(complaint);
    _loader.updateState(false);
  }
}
// -----------------------------------------------------------------------------

final complainProvider =
    StateNotifierProvider<ComplainNotifier, List<Complaint>>((ref) {
  final loader = ref.watch(loaderProvider.notifier);
  final complainAPi = ref.watch(complainApiProvider);
  return ComplainNotifier(
    loader: loader,
    complainApi: complainAPi,
  );
});
