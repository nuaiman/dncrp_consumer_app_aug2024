import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/complain_type.dart';
import 'baseurl.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;

abstract class IComplainApi {
  Future<List<ComplainType>> fetchComplainTypes();
  uploadEvidence(File imageFile, String imageName);
}
// -----------------------------------------------------------------------------

class ComplainApi implements IComplainApi {
  @override
  Future<List<ComplainType>> fetchComplainTypes() async {
    const url = '$baseUrl/cmplntp/allcmplntp';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 202) {
        final jsonResponse = json.decode(response.body);

        // Check for the 'data' key in the JSON response
        if (jsonResponse['data'] != null) {
          final List<dynamic> data = jsonResponse['data'];
          return data.map((json) => ComplainType.fromJson(json)).toList();
        } else {
          throw Exception('Failed to load complain types');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching complain types: $e');
      return [];
    }
  }

  @override
  Future<String?> uploadEvidence(File imageFile, String imageName) async {
    final Uri url = Uri.parse(fileUploadUrl);
    try {
      final request = http.MultipartRequest('POST', url)
        ..fields['description'] = 'Profile picture upload'
        ..files.add(await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
          contentType:
              MediaType('image', path.extension(imageFile.path).substring(1)),
        ));
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      final decodedData = jsonDecode(responseBody);
      final hasError = decodedData['error'] as bool;

      if (!hasError) {
        return decodedData['data']['image'].toString();
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
// -----------------------------------------------------------------------------

final complainApiProvider = Provider<ComplainApi>((ref) {
  return ComplainApi();
});
