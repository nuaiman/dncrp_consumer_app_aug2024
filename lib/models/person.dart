import 'complainer.dart';
import 'user.dart';

class Person {
  final User user;
  final Complainer complainer;
  final String userId;

  Person({
    required this.user,
    required this.complainer,
    required this.userId,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      user: User.fromJson(json['data']['userInfo']),
      complainer: Complainer.fromJson(json['data']['complainerInfo']),
      userId: json['data']['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'userInfo': user.toJson(),
        'complainerInfo': complainer.toJson(),
        'userId': userId,
      },
      'message': 'Complainer Info Found',
      'error': false,
      'status': 200,
    };
  }
}
