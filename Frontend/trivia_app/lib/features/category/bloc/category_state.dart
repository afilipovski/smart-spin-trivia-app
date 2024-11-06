import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:trivia_app/core/domain/models/category.dart';
import 'package:trivia_app/features/category/view/colored_card.dart';

enum CategoryStatus { initial, loading, success, failure }

extension WeatherStatusX on CategoryStatus {
  bool get isInitial => this == CategoryStatus.initial;
  bool get isLoading => this == CategoryStatus.loading;
  bool get isSuccess => this == CategoryStatus.success;
  bool get isFailure => this == CategoryStatus.failure;
}

@immutable
sealed class CategoriesState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class CategoriesInitial extends CategoriesState {}

final class CategoiesLoadFailed extends CategoriesState {}

final class CategoriesLoadInProgress extends CategoriesState {}

final class CategoryLoadSuccess extends CategoriesState {
  CategoryLoadSuccess(this.categories);

  final List<Category> categories;

  @override
  List<Object?> get props => [categories];
}

final class CategoriesCardSelected extends CategoriesState {
  CategoriesCardSelected(this.category, this.color);

  final Category category;
  final GradientColor color;

  @override
  List<Object?> get props => [category.id, color];
}
