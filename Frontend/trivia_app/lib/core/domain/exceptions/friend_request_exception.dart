class FriendRequestException implements Exception {
  final String message;
  FriendRequestException(this.message);

  @override
  String toString() => message;
}
