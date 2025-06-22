import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'streak_dto.g.dart';

@JsonSerializable()
class StreakDto extends Equatable {
  final int streak;
  final DateTime? streakLastExtended;
  final bool shouldReset;

  const StreakDto(this.streakLastExtended, {required this.streak, required this.shouldReset});

  factory StreakDto.fromJson(Map<String, dynamic> json) =>
      _$StreakDtoFromJson(json);

  Map<String, dynamic> toJson() => _$StreakDtoToJson(this);

  @override
  List<Object?> get props => [streak, streakLastExtended, shouldReset];
}
