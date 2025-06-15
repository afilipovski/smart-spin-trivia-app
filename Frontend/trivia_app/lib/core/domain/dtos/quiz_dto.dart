import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trivia_app/core/domain/models/category.dart';
import 'package:trivia_app/core/domain/models/limited_time_event.dart';

part 'quiz_dto.g.dart';

@JsonSerializable()
class QuizDto extends Equatable {
  final String id;
  final int xpPerQuestion;
  final Category? quizCategory;
  final LimitedTimeEvent? event;


  const QuizDto(this.xpPerQuestion, this.event, this.quizCategory, {required this.id,});

  factory QuizDto.fromJson(Map<String, dynamic> json) =>
      _$QuizDtoFromJson(json);

  Map<String, dynamic> toJson() => _$QuizDtoToJson(this);

  @override
  List<Object?> get props => [id];
}
