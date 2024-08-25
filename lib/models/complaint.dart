// class Complaint {
//   final String complainId;
//   final String trackingId;
//   final String complainTypeId;
//   final String complainType;
//   final String accusedOrganizationName;
//   final String accusedOrganizationAddress;
//   final String complainDescription;
//   final String victimNID;
//   final String victimName;
//   final String victimPhone;
//   final String victimPresentAddress;
//   final String districtId;
//   final String district;
//   final String divisionId;
//   final String division;
//   final List<String> evidences;
//   final String victimUserId;
//   final String complainerId;

//   Complaint({
//     required this.complainId,
//     required this.trackingId,
//     required this.complainTypeId, // Changed to String
//     required this.complainType,
//     required this.accusedOrganizationName,
//     required this.accusedOrganizationAddress,
//     required this.complainDescription,
//     required this.victimNID,
//     required this.victimName,
//     required this.victimPhone,
//     required this.victimPresentAddress,
//     required this.districtId,
//     required this.district,
//     required this.divisionId,
//     required this.division,
//     required this.evidences,
//     required this.victimUserId,
//     required this.complainerId, // Initialize field
//   });

//   // Method to convert JSON to Complaint object
//   factory Complaint.fromJson(Map<String, dynamic> json) {
//     return Complaint(
//       complainId: json['complainId'],
//       trackingId: json['trackingId'],
//       complainTypeId:
//           json['complainTypeId'].toString(), // Convert to String if needed
//       complainType: json['complainType'],
//       accusedOrganizationName: json['accusedOrganizationName'],
//       accusedOrganizationAddress: json['accusedOrganizationAddress'],
//       complainDescription: json['complainDescription'],
//       victimNID: json['victimNID'],
//       victimName: json['victimName'],
//       victimPhone: json['victimPhone'],
//       victimPresentAddress: json['victimPresentAddress'],
//       districtId: json['districtId'],
//       district: json['district'],
//       divisionId: json['divisionId'],
//       division: json['division'],
//       evidences: List<String>.from(json['evidences'] ?? []),
//       victimUserId: json['victimUserId'],
//       complainerId: json['complainerId'], // Map new field
//     );
//   }

//   // Method to convert Complaint object to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'complainId': complainId,
//       'trackingId': trackingId,
//       'complainTypeId': complainTypeId, // Remains as String
//       'complainType': complainType,
//       'accusedOrganizationName': accusedOrganizationName,
//       'accusedOrganizationAddress': accusedOrganizationAddress,
//       'complainDescription': complainDescription,
//       'victimNID': victimNID,
//       'victimName': victimName,
//       'victimPhone': victimPhone,
//       'victimPresentAddress': victimPresentAddress,
//       'districtId': districtId,
//       'district': district,
//       'divisionId': divisionId,
//       'division': division,
//       'evidences': evidences,
//       'victimUserId': victimUserId,
//       'complainerId': complainerId, // Add new field
//     };
//   }
// }

class Complain {
  final String complainTypeId;
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
  final String complainerId;

  // Nullable fields
  final String? complainId;
  final String? trackingId;
  final String? bnComplainType;
  final DateTime? complainSubmitDate;
  final DateTime? complainReceivedDate;
  final String? relationShipWithVictim;
  final bool? isWithdrawal;
  final bool? isWithdrawalRequest;
  final bool? isSubmit;
  final String? reasonOfWithdrawal;
  final String? postalCode;
  final double? fineAmount;
  final double? revenueAmount;
  final double? receivedAmount;
  final String? receivedDate;
  final double? dueAmount;
  final bool? isEditable;
  final bool? isEdited;
  final bool? assigned;
  final bool? isRewardClaimed;
  final bool? userClaimResponse;
  final bool? isFined;
  final double? rewardAmount;
  final bool? isPaidReward;
  final String? rewardPaymentDate;
  final String? duePaymentDate;
  final String? finedDate;
  final String? statementOfGovtOfficial;
  final String? hearingDate;
  final bool? isReadyToPay;
  final String? fatherNameOfVictim;
  final String? motherNameOfVictim;
  final String? victimDoB;
  final String? professionOfVictim;
  final String? victimEmail;
  final String? departmentId;
  final String? department;
  final String? parmanentAddressOfVictim;
  final String? currentAddressOfVictim;
  final String? organizationReceipt;
  final String? bnDivision;
  final String? bnDistrict;
  final String? bnUpazilla;
  final String? upazilla;
  final String? upazillaId;
  final String? zonalOffice;
  final String? zonalOfficeId;
  final String? assignedDate;
  final bool? processing;
  final bool? callForHearing;
  final bool? complete;
  final bool? rejected;
  final bool? complain;
  final bool? resolved;
  final bool? cancel;
  final bool? pending;
  final bool? verified;
  final bool? isBucket;
  final DateTime? updateDate;
  final int? month;
  final int? year;
  final String? creator;
  final DateTime? creationDate;
  final bool? status;
  final bool? active;
  final bool? delete;
  final DateTime? deleteDate;
  final String? deletedById;

  Complain({
    required this.complainTypeId,
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
    required this.complainerId,
    this.complainId,
    this.trackingId,
    this.bnComplainType,
    this.complainSubmitDate,
    this.complainReceivedDate,
    this.relationShipWithVictim,
    this.isWithdrawal,
    this.isWithdrawalRequest,
    this.isSubmit,
    this.reasonOfWithdrawal,
    this.postalCode,
    this.fineAmount,
    this.revenueAmount,
    this.receivedAmount,
    this.receivedDate,
    this.dueAmount,
    this.isEditable,
    this.isEdited,
    this.assigned,
    this.isRewardClaimed,
    this.userClaimResponse,
    this.isFined,
    this.rewardAmount,
    this.isPaidReward,
    this.rewardPaymentDate,
    this.duePaymentDate,
    this.finedDate,
    this.statementOfGovtOfficial,
    this.hearingDate,
    this.isReadyToPay,
    this.fatherNameOfVictim,
    this.motherNameOfVictim,
    this.victimDoB,
    this.professionOfVictim,
    this.victimEmail,
    this.departmentId,
    this.department,
    this.parmanentAddressOfVictim,
    this.currentAddressOfVictim,
    this.organizationReceipt,
    this.bnDivision,
    this.bnDistrict,
    this.bnUpazilla,
    this.upazilla,
    this.upazillaId,
    this.zonalOffice,
    this.zonalOfficeId,
    this.assignedDate,
    this.processing,
    this.callForHearing,
    this.complete,
    this.rejected,
    this.complain,
    this.resolved,
    this.cancel,
    this.pending,
    this.verified,
    this.isBucket,
    this.updateDate,
    this.month,
    this.year,
    this.creator,
    this.creationDate,
    this.status,
    this.active,
    this.delete,
    this.deleteDate,
    this.deletedById,
  });

  // Method to convert JSON to Complaint object
  factory Complain.fromJson(Map<String, dynamic> json) {
    return Complain(
      complainTypeId: json['complainTypeId'] as String,
      complainType: json['complainType'] as String,
      accusedOrganizationName: json['accusedOrganizationName'] as String,
      accusedOrganizationAddress: json['accusedOrganizationAddress'] as String,
      complainDescription: json['complainDescription'] as String,
      victimNID: json['victimNID'] as String,
      victimName: json['victimName'] as String,
      victimPhone: json['victimPhone'] as String,
      victimPresentAddress: json['victimPresentAddress'] as String,
      districtId: json['districtId'] as String,
      district: json['district'] as String,
      divisionId: json['divisionId'] as String,
      division: json['division'] as String,
      evidences: List<String>.from(json['evidences'] ?? []),
      victimUserId: json['victimUserId'] as String,
      complainerId: json['complainerId'] as String,
      complainId: json['complainId'] as String?,
      trackingId: json['trackingId'] as String?,
      bnComplainType: json['bn_complainType'] as String?,
      complainSubmitDate: json['complainSubmitDate'] != null
          ? DateTime.parse(json['complainSubmitDate'] as String)
          : null,
      complainReceivedDate: json['complainReceivedDate'] != null
          ? DateTime.parse(json['complainReceivedDate'] as String)
          : null,
      relationShipWithVictim: json['relationShipWithVictim'] as String?,
      isWithdrawal: json['isWithdrawal'] as bool?,
      isWithdrawalRequest: json['isWithdrawalRequest'] as bool?,
      isSubmit: json['isSubmit'] as bool?,
      reasonOfWithdrawal: json['reasonOfWithdrawal'] as String?,
      postalCode: json['postalCode'] as String?,
      fineAmount: (json['fineAmount'] as num?)?.toDouble(),
      revenueAmount: (json['revenueAmount'] as num?)?.toDouble(),
      receivedAmount: (json['receivedAmount'] as num?)?.toDouble(),
      receivedDate: json['receivedDate'] as String?,
      dueAmount: (json['dueAmount'] as num?)?.toDouble(),
      isEditable: json['isEditable'] as bool?,
      isEdited: json['isEdited'] as bool?,
      assigned: json['assigned'] as bool?,
      isRewardClaimed: json['isRewardClaimed'] as bool?,
      userClaimResponse: json['userClaimResponse'] as bool?,
      isFined: json['isFined'] as bool?,
      rewardAmount: (json['rewardAmount'] as num?)?.toDouble(),
      isPaidReward: json['isPaidReward'] as bool?,
      rewardPaymentDate: json['rewardPaymentDate'] as String?,
      duePaymentDate: json['duePaymentDate'] as String?,
      finedDate: json['finedDate'] as String?,
      statementOfGovtOfficial: json['statementOfGovtOfficial'] as String?,
      hearingDate: json['hearingDate'] as String?,
      isReadyToPay: json['isReadyToPay'] as bool?,
      fatherNameOfVictim: json['fatherNameOfVictim'] as String?,
      motherNameOfVictim: json['motherNameOfVictim'] as String?,
      victimDoB: json['victimDoB'] as String?,
      professionOfVictim: json['professionOfVictim'] as String?,
      victimEmail: json['victimEmail'] as String?,
      departmentId: json['departmentId'] as String?,
      department: json['department'] as String?,
      parmanentAddressOfVictim: json['parmanentAddressOfVictim'] as String?,
      currentAddressOfVictim: json['currentAddressOfVictim'] as String?,
      organizationReceipt: json['organizationReceipt'] as String?,
      bnDivision: json['bnDivision'] as String?,
      bnDistrict: json['bnDistrict'] as String?,
      bnUpazilla: json['bnUpazilla'] as String?,
      upazilla: json['upazilla'] as String?,
      upazillaId: json['upazillaId'] as String?,
      zonalOffice: json['zonalOffice'] as String?,
      zonalOfficeId: json['zonalOfficeId'] as String?,
      assignedDate: json['assignedDate'] as String?,
      processing: json['processing'] as bool?,
      callForHearing: json['callForHearing'] as bool?,
      complete: json['complete'] as bool?,
      rejected: json['rejected'] as bool?,
      complain: json['complain'] as bool?,
      resolved: json['resolved'] as bool?,
      cancel: json['cancel'] as bool?,
      pending: json['pending'] as bool?,
      verified: json['verified'] as bool?,
      isBucket: json['isBucket'] as bool?,
      updateDate: json['updateDate'] != null
          ? DateTime.parse(json['updateDate'] as String)
          : null,
      month: json['month'] as int?,
      year: json['year'] as int?,
      creator: json['creator'] as String?,
      creationDate: json['creationDate'] != null
          ? DateTime.parse(json['creationDate'] as String)
          : null,
      status: json['status'] as bool?,
      active: json['active'] as bool?,
      delete: json['delete'] as bool?,
      deleteDate: json['deleteDate'] != null
          ? DateTime.parse(json['deleteDate'] as String)
          : null,
      deletedById: json['deletedById'] as String?,
    );
  }

  // Method to convert Complaint object to JSON
  Map<String, dynamic> toJson() {
    return {
      'complainTypeId': complainTypeId,
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
      'complainerId': complainerId,
      'complainId': complainId,
      'trackingId': trackingId,
      'bn_complainType': bnComplainType,
      'complainSubmitDate': complainSubmitDate?.toIso8601String(),
      'complainReceivedDate': complainReceivedDate?.toIso8601String(),
      'relationShipWithVictim': relationShipWithVictim,
      'isWithdrawal': isWithdrawal,
      'isWithdrawalRequest': isWithdrawalRequest,
      'isSubmit': isSubmit,
      'reasonOfWithdrawal': reasonOfWithdrawal,
      'postalCode': postalCode,
      'fineAmount': fineAmount,
      'revenueAmount': revenueAmount,
      'receivedAmount': receivedAmount,
      'receivedDate': receivedDate,
      'dueAmount': dueAmount,
      'isEditable': isEditable,
      'isEdited': isEdited,
      'assigned': assigned,
      'isRewardClaimed': isRewardClaimed,
      'userClaimResponse': userClaimResponse,
      'isFined': isFined,
      'rewardAmount': rewardAmount,
      'isPaidReward': isPaidReward,
      'rewardPaymentDate': rewardPaymentDate,
      'duePaymentDate': duePaymentDate,
      'finedDate': finedDate,
      'statementOfGovtOfficial': statementOfGovtOfficial,
      'hearingDate': hearingDate,
      'isReadyToPay': isReadyToPay,
      'fatherNameOfVictim': fatherNameOfVictim,
      'motherNameOfVictim': motherNameOfVictim,
      'victimDoB': victimDoB,
      'professionOfVictim': professionOfVictim,
      'victimEmail': victimEmail,
      'departmentId': departmentId,
      'department': department,
      'parmanentAddressOfVictim': parmanentAddressOfVictim,
      'currentAddressOfVictim': currentAddressOfVictim,
      'organizationReceipt': organizationReceipt,
      'bnDivision': bnDivision,
      'bnDistrict': bnDistrict,
      'bnUpazilla': bnUpazilla,
      'upazilla': upazilla,
      'upazillaId': upazillaId,
      'zonalOffice': zonalOffice,
      'zonalOfficeId': zonalOfficeId,
      'assignedDate': assignedDate,
      'processing': processing,
      'callForHearing': callForHearing,
      'complete': complete,
      'rejected': rejected,
      'complain': complain,
      'resolved': resolved,
      'cancel': cancel,
      'pending': pending,
      'verified': verified,
      'isBucket': isBucket,
      'updateDate': updateDate?.toIso8601String(),
      'month': month,
      'year': year,
      'creator': creator,
      'creationDate': creationDate?.toIso8601String(),
      'status': status,
      'active': active,
      'delete': delete,
      'deleteDate': deleteDate?.toIso8601String(),
      'deletedById': deletedById,
    };
  }

  @override
  String toString() {
    return 'Complaint('
        'complainId: $complainId, '
        'trackingId: $trackingId, '
        'complainerId: $complainerId, '
        'complainTypeId: $complainTypeId, '
        'complainType: $complainType, '
        'bnComplainType: $bnComplainType, '
        'accusedOrganizationName: $accusedOrganizationName, '
        'accusedOrganizationAddress: $accusedOrganizationAddress, '
        'complainDescription: $complainDescription, '
        'evidence: $evidences, '
        'complainSubmitDate: $complainSubmitDate, '
        'complainReceivedDate: $complainReceivedDate, '
        'victimNID: $victimNID, '
        'victimPhone: $victimPhone, '
        'victimPresentAddress: $victimPresentAddress, '
        'relationShipWithVictim: $relationShipWithVictim, '
        'isWithdrawal: $isWithdrawal, '
        'isWithdrawalRequest: $isWithdrawalRequest, '
        'isSubmit: $isSubmit, '
        'reasonOfWithdrawal: $reasonOfWithdrawal, '
        'postalCode: $postalCode, '
        'fineAmount: $fineAmount, '
        'revenueAmount: $revenueAmount, '
        'receivedAmount: $receivedAmount, '
        'receivedDate: $receivedDate, '
        'dueAmount: $dueAmount, '
        'isEditable: $isEditable, '
        'isEdited: $isEdited, '
        'assigned: $assigned, '
        'isRewardClaimed: $isRewardClaimed, '
        'userClaimResponse: $userClaimResponse, '
        'isFined: $isFined, '
        'rewardAmount: $rewardAmount, '
        'isPaidReward: $isPaidReward, '
        'rewardPaymentDate: $rewardPaymentDate, '
        'duePaymentDate: $duePaymentDate, '
        'finedDate: $finedDate, '
        'statementOfGovtOfficial: $statementOfGovtOfficial, '
        'hearingDate: $hearingDate, '
        'isReadyToPay: $isReadyToPay, '
        'fatherNameOfVictim: $fatherNameOfVictim, '
        'motherNameOfVictim: $motherNameOfVictim, '
        'victimDoB: $victimDoB, '
        'professionOfVictim: $professionOfVictim, '
        'victimEmail: $victimEmail, '
        'departmentId: $departmentId, '
        'department: $department, '
        'parmanentAddressOfVictim: $parmanentAddressOfVictim, '
        'currentAddressOfVictim: $currentAddressOfVictim, '
        'organizationReceipt: $organizationReceipt, '
        'bnDivision: $bnDivision, '
        'bnDistrict: $bnDistrict, '
        'bnUpazilla: $bnUpazilla, '
        'upazilla: $upazilla, '
        'upazillaId: $upazillaId, '
        'zonalOffice: $zonalOffice, '
        'zonalOfficeId: $zonalOfficeId, '
        'assignedDate: $assignedDate, '
        'processing: $processing, '
        'callForHearing: $callForHearing, '
        'complete: $complete, '
        'rejected: $rejected, '
        'complain: $complain, '
        'resolved: $resolved, '
        'cancel: $cancel, '
        'pending: $pending, '
        'verified: $verified, '
        'isBucket: $isBucket, '
        'updateDate: $updateDate, '
        'month: $month, '
        'year: $year, '
        'creator: $creator, '
        'creationDate: $creationDate, '
        'status: $status, '
        'active: $active, '
        'delete: $delete, '
        'deleteDate: $deleteDate, '
        'deletedById: $deletedById'
        ')';
  }
}
