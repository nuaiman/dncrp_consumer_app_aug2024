// ignore_for_file: public_member_api_docs, sort_constructors_first
class Division {
  final String id;
  final String name;
  final String bnName;
  final String divisionId;

  Division({
    required this.id,
    required this.name,
    required this.bnName,
    required this.divisionId,
  });

  factory Division.fromJson(Map<String, dynamic> json) {
    return Division(
      id: json['_id'],
      name: json['name'],
      bnName: json['bnName'],
      divisionId: json['divisionId'],
    );
  }

  @override
  String toString() {
    return 'Division(id: $id, name: $name, bnName: $bnName, divisionId: $divisionId)';
  }
}

class District {
  final String id;
  final String name;
  final String bnName;
  final String districtId;
  final String divisionId;

  District({
    required this.id,
    required this.name,
    required this.bnName,
    required this.districtId,
    required this.divisionId,
  });

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      id: json['_id'],
      name: json['name'],
      bnName: json['bnName'],
      districtId: json['districtId'],
      divisionId: json['divisionId'],
    );
  }

  @override
  String toString() {
    return 'District(id: $id, name: $name, bnName: $bnName, districtId: $districtId, divisionId: $divisionId)';
  }
}

class DivisionWithDistricts {
  final Division division;
  final List<District> districts;

  DivisionWithDistricts({
    required this.division,
    required this.districts,
  });

  @override
  String toString() =>
      'DivisionWithDistricts(division: $division, districts: $districts)';
}
