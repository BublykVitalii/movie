import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String avatar;
  final String name;

  const User({
    required this.avatar,
    required this.name,
  });

  @override
  List<Object?> get props => [avatar, name];

  @override
  String toString() => 'User(avatar: $avatar, name: $name)';
}
