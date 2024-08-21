class Complainer {
  final String id;
  final String userId;
  final String name;
  final String fatherName;
  final String motherName;
  final String email;
  final String address;
  final String gender;
  final String identificationType;
  final String identificationNo;
  final String division;
  final String divisionId;
  final String district;
  final String districtId;
  final int postalCode;
  final String profession;
  final DateTime birthDate;
  final String updateDate;
  final int month;
  final int year;
  final String creator;
  final DateTime creationDate;
  final bool status;
  final bool active;
  final bool delete;
  final String deleteDate;
  final String deletedById;
  final String username;
  final String profilePicture;

  Complainer({
    required this.id,
    required this.userId,
    required this.name,
    required this.fatherName,
    required this.motherName,
    required this.email,
    required this.address,
    required this.gender,
    required this.identificationType,
    required this.identificationNo,
    required this.division,
    required this.divisionId,
    required this.district,
    required this.districtId,
    required this.postalCode,
    required this.profession,
    required this.birthDate,
    required this.updateDate,
    required this.month,
    required this.year,
    required this.creator,
    required this.creationDate,
    required this.status,
    required this.active,
    required this.delete,
    required this.deleteDate,
    required this.deletedById,
    required this.username,
    required this.profilePicture,
  });

  factory Complainer.fromJson(Map<String, dynamic> json) {
    return Complainer(
      id: json['_id'],
      userId: json['userId'],
      name: json['name'],
      fatherName: json['fatherName'],
      motherName: json['motherName'],
      email: json['email'],
      address: json['address'],
      gender: json['gender'],
      identificationType: json['identificationType'],
      identificationNo: json['identificationNo'],
      division: json['division'],
      divisionId: json['divisionId'],
      district: json['district'],
      districtId: json['districtId'],
      postalCode: json['postalCode'],
      profession: json['profession'],
      birthDate: DateTime.parse(json['birthDate']),
      updateDate: json['updateDate'],
      month: json['month'],
      year: json['year'],
      creator: json['creator'],
      creationDate: DateTime.parse(json['creationDate']),
      status: json['status'],
      active: json['active'],
      delete: json['delete'],
      deleteDate: json['deleteDate'],
      deletedById: json['deletedById'],
      username: json['username'],
      profilePicture: json['profilePicture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'name': name,
      'fatherName': fatherName,
      'motherName': motherName,
      'email': email,
      'address': address,
      'gender': gender,
      'identificationType': identificationType,
      'identificationNo': identificationNo,
      'division': division,
      'divisionId': divisionId,
      'district': district,
      'districtId': districtId,
      'postalCode': postalCode,
      'profession': profession,
      'birthDate': birthDate.toIso8601String(),
      'updateDate': updateDate,
      'month': month,
      'year': year,
      'creator': creator,
      'creationDate': creationDate.toIso8601String(),
      'status': status,
      'active': active,
      'delete': delete,
      'deleteDate': deleteDate,
      'deletedById': deletedById,
      'username': username,
      'profilePicture': profilePicture,
    };
  }
}
