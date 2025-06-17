import 'package:trivia_app/core/domain/dtos/category_dto.dart';
import 'package:trivia_app/core/services/http_service.dart';
import 'package:trivia_app/core/services/service_locator.dart';
import 'package:trivia_app/models.dart';

class CategoryService {
  CategoryService();

  final HttpService _client = getIt<HttpService>();

  Future<List<Category>> getCategories() async {
    final List response = await _client.get("quiz-category/");
    return response
        .map((c) => CategoryDto.fromJson(c))
        .map((dto) => Category(id: dto.id, name: dto.name))
        .toList();
  }
}
