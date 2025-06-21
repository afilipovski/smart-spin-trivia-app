import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trivia_app/core/domain/models/user_profile.dart';

part 'user_friendship.g.dart';

@JsonSerializable()
class UserFriendship extends Equatable {
  final UserProfile? friendshipInitiator;
  final UserProfile? friendshipReceiver;

  final String? friendshipInitiatorId;
  final String? friendshipReceiverId;

  final bool friendshipAccepted;

  const UserFriendship({
    this.friendshipInitiator,
    this.friendshipReceiver,
    this.friendshipInitiatorId,
    this.friendshipReceiverId,
    required this.friendshipAccepted,
  });

  factory UserFriendship.fromJson(Map<String, dynamic> json) =>
      _$UserFriendshipFromJson(json);

  Map<String, dynamic> toJson() => _$UserFriendshipToJson(this);

  @override
  List<Object?> get props => [
        friendshipInitiator,
        friendshipReceiver,
        friendshipInitiatorId,
        friendshipReceiverId,
        friendshipAccepted,
      ];
}
