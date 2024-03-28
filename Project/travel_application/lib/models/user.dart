import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';
@JsonSerializable()
class User{
  final String firstName;
  final String lastName;
  final int age;
  final String description;
  final String login;
  final String password;

  User({
  required this.firstName, 
  required this.lastName, 
  required this.age, 
  required this.description, 
  required this.login,
  required this.password});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json); 
  Map<String, dynamic> toJson() => _$UserToJson(this); 
}