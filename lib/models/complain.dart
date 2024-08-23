class Complain {
  final String complainId;
  final String trackingId;
  final String accusedOrganizationAddress;
  final String accusedOrganizationName;
  final String bnDistrict;
  final String bnDivision;
  final String bnComplainType;
  final String complainDescription;
  final DateTime complainReceivedDate;
  final DateTime complainSubmitDate;
  final String complainType;
  final int complainTypeId;
  final String complainerId;
  final String district;
  final String division;
  final String fatherNameOfVictim;
  final String motherNameOfVictim;
  final String professionOfVictim;
  final String relationShipWithVictim;
  final String victimNID;
  final String victimName;
  final String victimPhone;
  final String victimPresentAddress;

  Complain({
    required this.complainId,
    required this.trackingId,
    required this.accusedOrganizationAddress,
    required this.accusedOrganizationName,
    required this.bnDistrict,
    required this.bnDivision,
    required this.bnComplainType,
    required this.complainDescription,
    required this.complainReceivedDate,
    required this.complainSubmitDate,
    required this.complainType,
    required this.complainTypeId,
    required this.complainerId,
    required this.district,
    required this.division,
    required this.fatherNameOfVictim,
    required this.motherNameOfVictim,
    required this.professionOfVictim,
    required this.relationShipWithVictim,
    required this.victimNID,
    required this.victimName,
    required this.victimPhone,
    required this.victimPresentAddress,
  });

  factory Complain.fromJson(Map<String, dynamic> json) {
    return Complain(
      complainId: json['complainId'] as String,
      trackingId: json['trackingId'] as String,
      accusedOrganizationAddress: json['accusedOrganizationAddress'] as String,
      accusedOrganizationName: json['accusedOrganizationName'] as String,
      bnDistrict: json['bnDistrict'] as String,
      bnDivision: json['bnDivision'] as String,
      bnComplainType: json['bn_complainType'] as String,
      complainDescription: json['complainDescription'] as String,
      complainReceivedDate:
          DateTime.parse(json['complainReceivedDate'] as String),
      complainSubmitDate: DateTime.parse(json['complainSubmitDate'] as String),
      complainType: json['complainType'] as String,
      complainTypeId: json['complainTypeId'] as int,
      complainerId: json['complainerId'] as String,
      district: json['district'] as String,
      division: json['division'] as String,
      fatherNameOfVictim: json['fatherNameOfVictim'] as String,
      motherNameOfVictim: json['motherNameOfVictim'] as String,
      professionOfVictim: json['professionOfVictim'] as String,
      relationShipWithVictim: json['relationShipWithVictim'] as String,
      victimNID: json['victimNID'] as String,
      victimName: json['victimName'] as String,
      victimPhone: json['victimPhone'] as String,
      victimPresentAddress: json['victimPresentAddress'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'complainId': complainId,
      'trackingId': trackingId,
      'accusedOrganizationAddress': accusedOrganizationAddress,
      'accusedOrganizationName': accusedOrganizationName,
      'bnDistrict': bnDistrict,
      'bnDivision': bnDivision,
      'bn_complainType': bnComplainType,
      'complainDescription': complainDescription,
      'complainReceivedDate': complainReceivedDate.toIso8601String(),
      'complainSubmitDate': complainSubmitDate.toIso8601String(),
      'complainType': complainType,
      'complainTypeId': complainTypeId,
      'complainerId': complainerId,
      'district': district,
      'division': division,
      'fatherNameOfVictim': fatherNameOfVictim,
      'motherNameOfVictim': motherNameOfVictim,
      'professionOfVictim': professionOfVictim,
      'relationShipWithVictim': relationShipWithVictim,
      'victimNID': victimNID,
      'victimName': victimName,
      'victimPhone': victimPhone,
      'victimPresentAddress': victimPresentAddress,
    };
  }

  Complain copyWith({
    String? complainId,
    String? trackingId,
    String? accusedOrganizationAddress,
    String? accusedOrganizationName,
    String? bnDistrict,
    String? bnDivision,
    String? bnComplainType,
    String? complainDescription,
    DateTime? complainReceivedDate,
    DateTime? complainSubmitDate,
    String? complainType,
    int? complainTypeId,
    String? complainerId,
    String? district,
    String? division,
    String? fatherNameOfVictim,
    String? motherNameOfVictim,
    String? professionOfVictim,
    String? relationShipWithVictim,
    String? victimNID,
    String? victimName,
    String? victimPhone,
    String? victimPresentAddress,
  }) {
    return Complain(
      complainId: complainId ?? this.complainId,
      trackingId: trackingId ?? this.trackingId,
      accusedOrganizationAddress:
          accusedOrganizationAddress ?? this.accusedOrganizationAddress,
      accusedOrganizationName:
          accusedOrganizationName ?? this.accusedOrganizationName,
      bnDistrict: bnDistrict ?? this.bnDistrict,
      bnDivision: bnDivision ?? this.bnDivision,
      bnComplainType: bnComplainType ?? this.bnComplainType,
      complainDescription: complainDescription ?? this.complainDescription,
      complainReceivedDate: complainReceivedDate ?? this.complainReceivedDate,
      complainSubmitDate: complainSubmitDate ?? this.complainSubmitDate,
      complainType: complainType ?? this.complainType,
      complainTypeId: complainTypeId ?? this.complainTypeId,
      complainerId: complainerId ?? this.complainerId,
      district: district ?? this.district,
      division: division ?? this.division,
      fatherNameOfVictim: fatherNameOfVictim ?? this.fatherNameOfVictim,
      motherNameOfVictim: motherNameOfVictim ?? this.motherNameOfVictim,
      professionOfVictim: professionOfVictim ?? this.professionOfVictim,
      relationShipWithVictim:
          relationShipWithVictim ?? this.relationShipWithVictim,
      victimNID: victimNID ?? this.victimNID,
      victimName: victimName ?? this.victimName,
      victimPhone: victimPhone ?? this.victimPhone,
      victimPresentAddress: victimPresentAddress ?? this.victimPresentAddress,
    );
  }

  @override
  String toString() {
    return 'Complain('
        'complainId: $complainId, '
        'trackingId: $trackingId, '
        'accusedOrganizationAddress: $accusedOrganizationAddress, '
        'accusedOrganizationName: $accusedOrganizationName, '
        'bnDistrict: $bnDistrict, '
        'bnDivision: $bnDivision, '
        'bnComplainType: $bnComplainType, '
        'complainDescription: $complainDescription, '
        'complainReceivedDate: $complainReceivedDate, '
        'complainSubmitDate: $complainSubmitDate, '
        'complainType: $complainType, '
        'complainTypeId: $complainTypeId, '
        'complainerId: $complainerId, '
        'district: $district, '
        'division: $division, '
        'fatherNameOfVictim: $fatherNameOfVictim, '
        'motherNameOfVictim: $motherNameOfVictim, '
        'professionOfVictim: $professionOfVictim, '
        'relationShipWithVictim: $relationShipWithVictim, '
        'victimNID: $victimNID, '
        'victimName: $victimName, '
        'victimPhone: $victimPhone, '
        'victimPresentAddress: $victimPresentAddress'
        ')';
  }
}
