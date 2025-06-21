import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

@JsonSerializable()
class UserProfile extends Equatable {
  final String id;
  final String email;
  final String fullName;
  final DateTime birthDate;
  final List<UserProfile>? friends;
  final int streak;
  final DateTime? streakLastExtended;

  const UserProfile(
    this.friends, 
    this.streakLastExtended,
    {
    required this.id,
    required this.email,
    required this.fullName,
    required this.birthDate,
    required this.streak,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);

  @override
  List<Object?> get props => [id];
}
