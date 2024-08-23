import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'baseurl.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;

abstract class IComplainApi {
  uploadEvidence(File imageFile, String imageName);
}
// -----------------------------------------------------------------------------

class ComplainApi implements IComplainApi {
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
