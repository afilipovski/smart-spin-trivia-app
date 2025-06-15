import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_quiz_session_dto.g.dart';

@JsonSerializable()
class CreateQuizSessionDto extends Equatable {
  final String quizId;

  const CreateQuizSessionDto({required this.quizId,});

  factory CreateQuizSessionDto.fromJson(Map<String, dynamic> json) =>
      _$CreateQuizSessionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateQuizSessionDtoToJson(this);

  @override
  List<Object?> get props => [quizId];
}
