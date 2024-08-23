class ComplainType {
  final String id;
  final String bnName;
  final String name;
  final String complainTypeId;

  ComplainType({
    required this.id,
    required this.bnName,
    required this.name,
    required this.complainTypeId,
  });

  factory ComplainType.fromJson(Map<String, dynamic> json) {
    return ComplainType(
      id: json['_id'] as String,
      bnName: json['bnName'] as String,
      name: json['name'] as String,
      complainTypeId: json['complainTypeId'].toString() as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'bnName': bnName,
      'name': name,
      'complainTypeId': complainTypeId,
    };
  }

  @override
  String toString() {
    return 'ComplainType(id: $id, bnName: $bnName, name: $name, complainTypeId: $complainTypeId)';
  }
}
