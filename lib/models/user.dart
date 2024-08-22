class User {
  final String id;
  final String? email;
  final String username;
  final String firstName;
  final String lastName;
  final String? register;
  final String profilePicture;
  final String invitationResponseDate;
  final String creator;
  final bool pendingInvitation;
  final List<dynamic> updateHistoryList;
  final String userType;
  final int userTypeCode;
  final bool hasProfile;
  final bool isInvitation;
  final bool otpLogin;
  final bool isComplete;
  final String activationDate;
  final DateTime updateDate;
  final DateTime creationDate;
  final bool status;
  final bool active;
  final bool delete;
  final String deleteDate;
  final String deletedById;
  final String? roleCode;
  final String? role;
  final bool updated;

  User({
    required this.id,
    this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    this.register,
    required this.profilePicture,
    required this.invitationResponseDate,
    required this.creator,
    required this.pendingInvitation,
    required this.updateHistoryList,
    required this.userType,
    required this.userTypeCode,
    required this.hasProfile,
    required this.isInvitation,
    required this.otpLogin,
    required this.isComplete,
    required this.activationDate,
    required this.updateDate,
    required this.creationDate,
    required this.status,
    required this.active,
    required this.delete,
    required this.deleteDate,
    required this.deletedById,
    this.roleCode,
    this.role,
    required this.updated,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      email: json['email'],
      username: json['username'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      register: json['register'],
      profilePicture: json['profilePicture'],
      invitationResponseDate: json['invitationResponseDate'],
      creator: json['creator'],
      pendingInvitation: json['pendingInvitation'],
      updateHistoryList: List<dynamic>.from(json['updateHistoryList']),
      userType: json['userType'],
      userTypeCode: json['userTypeCode'],
      hasProfile: json['hasProfile'],
      isInvitation: json['isInvitation'],
      otpLogin: json['otpLogin'],
      isComplete: json['isComplete'],
      activationDate: json['activationDate'],
      updateDate: DateTime.parse(json['updateDate']),
      creationDate: DateTime.parse(json['creationDate']),
      status: json['status'],
      active: json['active'],
      delete: json['delete'],
      deleteDate: json['deleteDate'],
      deletedById: json['deletedById'],
      roleCode: json['roleCode'],
      role: json['role'],
      updated: json['updated'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'register': register,
      'profilePicture': profilePicture,
      'invitationResponseDate': invitationResponseDate,
      'creator': creator,
      'pendingInvitation': pendingInvitation,
      'updateHistoryList': updateHistoryList,
      'userType': userType,
      'userTypeCode': userTypeCode,
      'hasProfile': hasProfile,
      'isInvitation': isInvitation,
      'otpLogin': otpLogin,
      'isComplete': isComplete,
      'activationDate': activationDate,
      'updateDate': updateDate.toIso8601String(),
      'creationDate': creationDate.toIso8601String(),
      'status': status,
      'active': active,
      'delete': delete,
      'deleteDate': deleteDate,
      'deletedById': deletedById,
      'roleCode': roleCode,
      'role': role,
      'updated': updated,
    };
  }

  @override
  String toString() {
    return 'User(id: $id, email: $email, username: $username, firstName: $firstName, lastName: $lastName, register: $register, profilePicture: $profilePicture, invitationResponseDate: $invitationResponseDate, creator: $creator, pendingInvitation: $pendingInvitation, updateHistoryList: $updateHistoryList, userType: $userType, userTypeCode: $userTypeCode, hasProfile: $hasProfile, isInvitation: $isInvitation, otpLogin: $otpLogin, isComplete: $isComplete, activationDate: $activationDate, updateDate: ${updateDate.toIso8601String()}, creationDate: ${creationDate.toIso8601String()}, status: $status, active: $active, delete: $delete, deleteDate: $deleteDate, deletedById: $deletedById, roleCode: $roleCode, role: $role, updated: $updated)';
  }
}


// // ignore_for_file: public_member_api_docs, sort_constructors_first
// class User {
//   final String id;
//   final String fullName;
//   final String profileUrl;
//   final String fatherName;
//   final String motherName;
//   final DateTime birthDate;
//   final String gender;
//   final String profession;
//   final String nidNumber;
//   final String passportNumber;
//   final String birthCertificateNumber;
//   final String fullAddress;
//   final String division;
//   final String district;
//   final String postalCode;
//   final List<String> complains;
//   final bool agreedToTermsAndConditions;
//   User({
//     required this.id,
//     required this.fullName,
//     required this.profileUrl,
//     required this.fatherName,
//     required this.motherName,
//     required this.birthDate,
//     required this.gender,
//     required this.profession,
//     required this.nidNumber,
//     required this.passportNumber,
//     required this.birthCertificateNumber,
//     required this.fullAddress,
//     required this.division,
//     required this.district,
//     required this.postalCode,
//     required this.complains,
//     required this.agreedToTermsAndConditions,
//   });

//   User copyWith({
//     String? id,
//     String? fullName,
//     String? profileUrl,
//     String? fatherName,
//     String? motherName,
//     DateTime? birthDate,
//     String? gender,
//     String? profession,
//     String? nidNumber,
//     String? passportNumber,
//     String? birthCertificateNumber,
//     String? fullAddress,
//     String? division,
//     String? district,
//     String? postalCode,
//     List<String>? complains,
//     bool? agreedToTermsAndConditions,
//   }) {
//     return User(
//       id: id ?? this.id,
//       fullName: fullName ?? this.fullName,
//       profileUrl: profileUrl ?? this.profileUrl,
//       fatherName: fatherName ?? this.fatherName,
//       motherName: motherName ?? this.motherName,
//       birthDate: birthDate ?? this.birthDate,
//       gender: gender ?? this.gender,
//       profession: profession ?? this.profession,
//       nidNumber: nidNumber ?? this.nidNumber,
//       passportNumber: passportNumber ?? this.passportNumber,
//       birthCertificateNumber:
//           birthCertificateNumber ?? this.birthCertificateNumber,
//       fullAddress: fullAddress ?? this.fullAddress,
//       division: division ?? this.division,
//       district: district ?? this.district,
//       postalCode: postalCode ?? this.postalCode,
//       complains: complains ?? this.complains,
//       agreedToTermsAndConditions:
//           agreedToTermsAndConditions ?? this.agreedToTermsAndConditions,
//     );
//   }
// }
