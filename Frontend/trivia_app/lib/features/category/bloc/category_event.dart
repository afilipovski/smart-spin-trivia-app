import 'package:equatable/equatable.dart';
import 'package:trivia_app/core/domain/models/category.dart';
import 'package:trivia_app/features/category/view/colored_card.dart';

sealed class CategoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CategorySelected extends CategoryEvent {
  CategorySelected(this.category, this.gradientColor);
  final Category category;
  final GradientColor gradientColor;

  @override
  List<Object?> get props => [category.id];
}

class CategoryInitialLoad extends CategoryEvent {
  CategoryInitialLoad();
}
