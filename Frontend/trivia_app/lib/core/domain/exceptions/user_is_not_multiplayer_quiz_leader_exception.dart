class UserIsNotMultiplayerQuizLeaderException implements Exception {
  UserIsNotMultiplayerQuizLeaderException(this.statusCode, {this.message});

  final int statusCode;
  final String? message;

  @override
  String toString() {
    return message ?? '"User is not the leader $statusCode';
  }
}
