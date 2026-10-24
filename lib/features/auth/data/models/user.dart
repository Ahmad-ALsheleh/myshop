import 'package:flutter/foundation.dart';

@immutable
class User {
  const User({
    required this.id,
    required this.name,
    required this.phone,
    required this.avatar,
  });

  final String id;
  final String name;

  /// International format without spaces: "+380991234567".
  final String phone;
  final String avatar;

  User copyWith({String? name, String? phone}) => User(
    id: id,
    name: name ?? this.name,
    phone: phone ?? this.phone,
    avatar: avatar,
  );
}
