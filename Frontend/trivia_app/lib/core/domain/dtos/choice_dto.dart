import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'choice_dto.g.dart';

@JsonSerializable()
class ChoiceDto extends Equatable {
  final String id;
  final String content;
  final bool isCorrect;

  const ChoiceDto({
    required this.id,
    required this.content,
    required this.isCorrect,
  });

  factory ChoiceDto.fromJson(Map<String, dynamic> json) =>
      _$ChoiceDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ChoiceDtoToJson(this);

  @override
  List<Object?> get props => [id];
}
