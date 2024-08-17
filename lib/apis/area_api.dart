import 'dart:convert';

import 'package:dncrp_consumer_app/apis/baseurl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../models/area.dart';

abstract class IAreaApi {
  Future<List<DivisionWithDistricts>> getDivisionWithDistricts();
}
// -----------------------------------------------------------------------------

class AreaApi implements IAreaApi {
  @override
  Future<List<DivisionWithDistricts>> getDivisionWithDistricts() async {
    const String divisionUrl = '$baseUrl/dvsn/alldvsn/';
    const String districtUrl = '$baseUrl/dstrct/dstrctfdvsn/';

    try {
      // Fetch divisions
      final divisionResponse = await http.get(Uri.parse(divisionUrl));
      if (divisionResponse.statusCode != 202) {
        // print(
        //     'Failed to load divisions. Status code: ${divisionResponse.statusCode}');
        // print('Response body: ${divisionResponse.body}');
        throw Exception('Failed to load divisions');
      }
      final List<dynamic> divisionJson =
          json.decode(divisionResponse.body)['data'];
      final List<Division> divisions =
          divisionJson.map((json) => Division.fromJson(json)).toList();

      // Fetch districts for each division
      final List<DivisionWithDistricts> divisionWithDistrictsList = [];
      for (var division in divisions) {
        final districtResponse =
            await http.get(Uri.parse('$districtUrl${division.divisionId}'));
        if (districtResponse.statusCode != 202) {
          // print(
          //     'Failed to load districts for division ${division.name}. Status code: ${districtResponse.statusCode}');
          // print('Response body: ${districtResponse.body}');
          throw Exception(
              'Failed to load districts for division ${division.name}');
        }
        final List<dynamic> districtJson =
            json.decode(districtResponse.body)['data'];
        final List<District> districts =
            districtJson.map((json) => District.fromJson(json)).toList();

        divisionWithDistrictsList.add(DivisionWithDistricts(
          division: division,
          districts: districts,
        ));
      }

      return divisionWithDistrictsList;
    } catch (error) {
      // print('Error fetching divisions and districts: $error');
      throw Exception('Error fetching divisions and districts: $error');
    }
  }
}

// -----------------------------------------------------------------------------

final areaApiProvider = Provider<AreaApi>((ref) {
  return AreaApi();
});
