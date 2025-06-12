import 'dart:math';

import 'package:trivia_app/core/domain/dtos/category_dto.dart';
import 'package:trivia_app/core/services/http_service.dart';
import 'package:trivia_app/core/services/service_locator.dart';
import 'package:trivia_app/models.dart';

class CategoryService {
  CategoryService();
      // [HttpService? client]
      // ) {
    // _client = client ?? HttpService();
  

  final HttpService _client = getIt<HttpService>();

  Future<List<Category>> getCategories() async {
    final List response = await _client.get("quiz-category");
    return response
        .map((c) => CategoryDto.fromJson(c))
        .map((dto) => Category(id: dto.id, name: dto.name))
        .toList();
  }

  Future<Iterable<Question>> getRandomQuestionsForCategory(
    String categoryId, {
    Map<String, dynamic>? queryParameters,
  }) async {
    // var path = 'categories/$categoryId';
    // final List response =
    //     await _client.get(path, queryParameters: queryParameters);
    // response.shuffle(Random());
    // return response.map((q) => Question.fromJson(q));
    return Future.value();
  }

  Future<void> postCategory(Object requestBody) async {
    // await _client.post("categories", requestBody);
  }

  Future<void> putCategory(Object requestBody) async {
    // await _client.put("categories", requestBody);
  }

  Future<void> deleteCategory(String id) async {
    // await _client.delete("categories/$id");
  }
}
