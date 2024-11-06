import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trivia_app/core/domain/models/question.dart';

part 'category.g.dart';

@JsonSerializable()
class Category extends Equatable {
  final String id;
  final String name;
  final List<Question>? questions;

  const Category({required this.id, required this.name, this.questions});

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  @override
  List<Object?> get props => [id];
}
