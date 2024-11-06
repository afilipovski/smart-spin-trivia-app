import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:trivia_app/core/services/category_service.dart';
import 'package:trivia_app/features/category/bloc/category_event.dart';
import 'package:trivia_app/features/category/bloc/category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoriesState> {
  CategoryBloc(CategoryService? categoryService) : super(CategoriesInitial()) {
    _categoryService = categoryService ?? CategoryService();
    on<CategoryInitialLoad>(_onCategoryInitialLoad);
    on<CategorySelected>(_onCategorySelect);
  }

  late final CategoryService _categoryService;

  Future<void> _onCategoryInitialLoad(
    CategoryInitialLoad event,
    Emitter<CategoriesState> emit,
  ) async {
    try {
      emit(CategoriesLoadInProgress());
      final categories = await _categoryService.getCategories();
      if (categories.isEmpty) {
        emit(CategoiesLoadFailed());
      } else {
        emit(CategoryLoadSuccess(categories));
      }
    } on Exception {
      emit(CategoiesLoadFailed());
    } on Error {
      emit(CategoiesLoadFailed());
    }
  }

  void _onCategorySelect(
    CategorySelected event,
    Emitter<CategoriesState> emit,
  ) async {
    emit(CategoriesCardSelected(event.category, event.gradientColor));
  }
}
