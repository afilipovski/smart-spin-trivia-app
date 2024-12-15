import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'limited_time_event.g.dart';

@JsonSerializable()
class LimitedTimeEvent extends Equatable {
  final String id;
  final DateTime startTime;
  final DateTime endTime;

  const LimitedTimeEvent({
    required this.id,
    required this.startTime,
    required this.endTime,
  });

  factory LimitedTimeEvent.fromJson(Map<String, dynamic> json) =>
      _$LimitedTimeEventFromJson(json);

  Map<String, dynamic> toJson() => _$LimitedTimeEventToJson(this);

  @override
  List<Object?> get props => [id];
}
