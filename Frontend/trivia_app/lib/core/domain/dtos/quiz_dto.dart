import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quiz_dto.g.dart';

@JsonSerializable()
class QuizDto extends Equatable {
  final String id;
  final String name;

  const QuizDto({required this.id, required this.name});

  factory QuizDto.fromJson(Map<String, dynamic> json) =>
      _$QuizDtoFromJson(json);

  Map<String, dynamic> toJson() => _$QuizDtoToJson(this);

  @override
  List<Object?> get props => [id];
}
