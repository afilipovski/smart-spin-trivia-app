import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_dto.g.dart';

@JsonSerializable()
class CategoryDto extends Equatable {
  final String id;
  final String name;

  const CategoryDto({required this.id, required this.name});

  factory CategoryDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDtoToJson(this);

  @override
  List<Object?> get props => [id];
}
