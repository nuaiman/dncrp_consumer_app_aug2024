// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String id;
  final String fullName;
  final String profileUrl;
  final String fatherName;
  final String motherName;
  final DateTime birthDate;
  final String gender;
  final String profession;
  final String nidNumber;
  final String passportNumber;
  final String birthCertificateNumber;
  final String fullAddress;
  final String division;
  final String district;
  final String postalCode;
  final List<String> complains;
  final bool agreedToTermsAndConditions;
  User({
    required this.id,
    required this.fullName,
    required this.profileUrl,
    required this.fatherName,
    required this.motherName,
    required this.birthDate,
    required this.gender,
    required this.profession,
    required this.nidNumber,
    required this.passportNumber,
    required this.birthCertificateNumber,
    required this.fullAddress,
    required this.division,
    required this.district,
    required this.postalCode,
    required this.complains,
    required this.agreedToTermsAndConditions,
  });

  User copyWith({
    String? id,
    String? fullName,
    String? profileUrl,
    String? fatherName,
    String? motherName,
    DateTime? birthDate,
    String? gender,
    String? profession,
    String? nidNumber,
    String? passportNumber,
    String? birthCertificateNumber,
    String? fullAddress,
    String? division,
    String? district,
    String? postalCode,
    List<String>? complains,
    bool? agreedToTermsAndConditions,
  }) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      profileUrl: profileUrl ?? this.profileUrl,
      fatherName: fatherName ?? this.fatherName,
      motherName: motherName ?? this.motherName,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      profession: profession ?? this.profession,
      nidNumber: nidNumber ?? this.nidNumber,
      passportNumber: passportNumber ?? this.passportNumber,
      birthCertificateNumber:
          birthCertificateNumber ?? this.birthCertificateNumber,
      fullAddress: fullAddress ?? this.fullAddress,
      division: division ?? this.division,
      district: district ?? this.district,
      postalCode: postalCode ?? this.postalCode,
      complains: complains ?? this.complains,
      agreedToTermsAndConditions:
          agreedToTermsAndConditions ?? this.agreedToTermsAndConditions,
    );
  }
}
