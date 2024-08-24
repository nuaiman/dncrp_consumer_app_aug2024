import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/complaint.dart';
import '../models/complain_type.dart';
import 'baseurl.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;

abstract class IComplainApi {
  Future<List<ComplainType>> fetchComplainTypes();

  uploadEvidence(File imageFile, String imageName);

  Future<void> createComplaint(Complaint complaint);
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

  @override
  Future<void> createComplaint(Complaint complaint) async {
    const url = '$baseUrl/cmpln/crt';
    // Convert the Complaint object to JSON
    final Map<String, dynamic> payload = {
      'complainerId': complaint.complainerId,
      'complainTypeId': complaint.complainTypeId,
      'complainType': complaint.complainType,
      'accusedOrganizationName': complaint.accusedOrganizationName,
      'accusedOrganizationAddress': complaint.accusedOrganizationAddress,
      'complainDescription': complaint.complainDescription,
      'victimNID': complaint.victimNID,
      'victimName': complaint.victimName,
      'victimPhone': complaint.victimPhone,
      'victimPresentAddress': complaint.victimPresentAddress,
      'districtId': complaint.districtId,
      'district': complaint.district,
      'divisionId': complaint.divisionId,
      'division': complaint.division,
      'evidences': complaint.evidences,
      'victimUserId': complaint.victimUserId,
    };

    // Convert the payload to JSON string
    final String jsonPayload = json.encode(payload);

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonPayload,
      );

      print(response.body);

      // if (response.statusCode == 201) {
      //   print('Complaint submitted successfully!');
      // } else {
      //   print(
      //       'Failed to submit complaint. Status code: ${response.statusCode}');
      // }
    } catch (e) {
      print('Error: $e');
    }
  }
}
// -----------------------------------------------------------------------------

final complainApiProvider = Provider<ComplainApi>((ref) {
  return ComplainApi();
});
