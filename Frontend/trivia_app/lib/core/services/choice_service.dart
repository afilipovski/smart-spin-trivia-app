// import 'package:trivia_app/core/domain/models/choice.dart';
// import 'package:trivia_app/core/services/http_service.dart';

// class ChoiceService {
//   ChoiceService([HttpService? client]) {
//     _client = client ?? HttpService();
//   }

//   late final HttpService _client;

//   Future<List<Choice>> getChoices() async {
//     final List response = await _client.get("choices");
//     return response.map((c) => Choice.fromJson(c)).toList();
//   }

//   Future<Choice> getChoice(String id) async {
//     final response = await _client.get("choices/$id");
//     return Choice.fromJson(response);
//   }

//   Future<void> postChoice(Object requestBody) async {
//     await _client.post("choices", requestBody);
//   }

//   Future<void> putChoice(Object requestBody) async {
//     await _client.put("choices", requestBody);
//   }

//   Future<void> deleteChoice(String id) async {
//     await _client.delete("choices/$id");
//   }
// }
