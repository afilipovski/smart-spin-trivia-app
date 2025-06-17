import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'choice.g.dart';

@JsonSerializable()
class Choice extends Equatable {
  final String id;
  final String content;

  const Choice(
      {required this.id,
      required this.content,
  });

  factory Choice.fromJson(Map<String, dynamic> json) => _$ChoiceFromJson(json);

  Map<String, dynamic> toJson() => _$ChoiceToJson(this);

  @override
  List<Object?> get props => [id];
}
