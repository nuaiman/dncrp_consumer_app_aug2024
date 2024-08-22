import 'dart:convert';
import 'package:dncrp_consumer_app/models/person.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'baseurl.dart';

abstract class IUserApi {
  Future<Person?> getPerson({required String accessToken});
}
// -----------------------------------------------------------------------------

class UserApi implements IUserApi {
  @override
  Future<Person?> getPerson({required String accessToken}) async {
    const String endpoint = '/ath/cmplnr/info';
    final Uri url = Uri.parse('$baseUrl$endpoint');
    try {
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': accessToken,
        },
      );
      if (response.statusCode == 202) {
        final decodedData = jsonDecode(response.body);
        Person person = Person.fromJson(decodedData);
        return person;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
// -----------------------------------------------------------------------------

final userApiProvider = Provider<UserApi>((ref) {
  return UserApi();
});
