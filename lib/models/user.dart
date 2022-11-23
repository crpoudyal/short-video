import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  String? uid;
  String? name;
  String? email;
  String? profilePhoto;

  User(
      {required this.uid,
      required this.name,
      required this.email,
      required this.profilePhoto});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
