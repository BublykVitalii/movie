import 'package:equatable/equatable.dart';

class User extends Equatable {
  final Avatar avatar;
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

class Avatar {
  final Gravatar gravatar;

  Avatar({
    required this.gravatar,
  });
}

class Gravatar {
  final String hash;

  Gravatar({
    required this.hash,
  });
}
