import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// A representation of the User entity
@JsonSerializable()
class User extends Equatable {
  @JsonKey(name: 'userId')
  final String id;
  final String email;
  final String token;

  User(this.id, this.email, this.token);

  static User fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object> get props => [id, email, token];

  @override
  String toString() {
    return '\nUser:\n>id: $id\n>email: $email\n>token: $token';
  }
}
