class Complaint {
  final String complainId;
  final String trackingId;
  final String complainTypeId; // Changed to String
  final String complainType;
  final String accusedOrganizationName;
  final String accusedOrganizationAddress;
  final String complainDescription;
  final String victimNID;
  final String victimName;
  final String victimPhone;
  final String victimPresentAddress;
  final String districtId;
  final String district;
  final String divisionId;
  final String division;
  final List<String> evidences;
  final String victimUserId;
  final String complainerId; // Added field

  Complaint({
    required this.complainId,
    required this.trackingId,
    required this.complainTypeId, // Changed to String
    required this.complainType,
    required this.accusedOrganizationName,
    required this.accusedOrganizationAddress,
    required this.complainDescription,
    required this.victimNID,
    required this.victimName,
    required this.victimPhone,
    required this.victimPresentAddress,
    required this.districtId,
    required this.district,
    required this.divisionId,
    required this.division,
    required this.evidences,
    required this.victimUserId,
    required this.complainerId, // Initialize field
  });

  // Method to convert JSON to Complaint object
  factory Complaint.fromJson(Map<String, dynamic> json) {
    return Complaint(
      complainId: json['complainId'],
      trackingId: json['trackingId'],
      complainTypeId:
          json['complainTypeId'].toString(), // Convert to String if needed
      complainType: json['complainType'],
      accusedOrganizationName: json['accusedOrganizationName'],
      accusedOrganizationAddress: json['accusedOrganizationAddress'],
      complainDescription: json['complainDescription'],
      victimNID: json['victimNID'],
      victimName: json['victimName'],
      victimPhone: json['victimPhone'],
      victimPresentAddress: json['victimPresentAddress'],
      districtId: json['districtId'],
      district: json['district'],
      divisionId: json['divisionId'],
      division: json['division'],
      evidences: List<String>.from(json['evidences'] ?? []),
      victimUserId: json['victimUserId'],
      complainerId: json['complainerId'], // Map new field
    );
  }

  // Method to convert Complaint object to JSON
  Map<String, dynamic> toJson() {
    return {
      'complainId': complainId,
      'trackingId': trackingId,
      'complainTypeId': complainTypeId, // Remains as String
      'complainType': complainType,
      'accusedOrganizationName': accusedOrganizationName,
      'accusedOrganizationAddress': accusedOrganizationAddress,
      'complainDescription': complainDescription,
      'victimNID': victimNID,
      'victimName': victimName,
      'victimPhone': victimPhone,
      'victimPresentAddress': victimPresentAddress,
      'districtId': districtId,
      'district': district,
      'divisionId': divisionId,
      'division': division,
      'evidences': evidences,
      'victimUserId': victimUserId,
      'complainerId': complainerId, // Add new field
    };
  }
}
