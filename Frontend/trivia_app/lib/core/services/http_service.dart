// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:trivia_app/core/extensions/http_response_extension.dart';
// import 'package:trivia_app/globals.dart';

// const headers = {
//   HttpHeaders.acceptHeader: 'application/json',
//   HttpHeaders.contentTypeHeader: 'application/json'
// };

// class HttpService {
//   Future<dynamic> get(
//     String path, {
//     Map<String, dynamic>? queryParameters,
//   }) async {
//     final url = buildUri(path, queryParameters);

//     final response = await http.get(
//       url,
//       headers: headers,
//     );
//     response.ensureSuccessStatusCode();
//     return _decodeBody(response.body);
//   }

//   Future<dynamic> post(String path, Object requestBody) async {
//     final endpoint = Uri.parse(baseApiUrl + path);

//     final response = await http.post(
//       endpoint,
//       headers: headers,
//       body: jsonEncode(requestBody),
//     );
//     response.ensureSuccessStatusCode();
//     return _decodeBody(response.body);
//   }

//   Future<dynamic> put(String path, Object requestBody) async {
//     final endpoint = Uri.parse(baseApiUrl + path);

//     final response = await http.put(
//       endpoint,
//       headers: headers,
//       body: jsonEncode(requestBody),
//     );
//     response.ensureSuccessStatusCode();
//     return _decodeBody(response.body);
//   }

//   Future<dynamic> delete(String path) async {
//     final endpoint = Uri.parse(baseApiUrl + path);

//     final response = await http.delete(
//       endpoint,
//       headers: headers,
//     );
//     response.ensureSuccessStatusCode();
//     return _decodeBody(response.body);
//   }
// }

// dynamic _decodeBody(String body) {
//   if (body.isEmpty) {
//     return {};
//   }
//   return jsonDecode(body);
// }

// Uri buildUri(String endpoint, Map<String, dynamic>? queryParameters) {
//   final uri = Uri.parse('$baseApiUrl$endpoint');

//   if (queryParameters?.isNotEmpty ?? false) {
//     return uri.replace(queryParameters: queryParameters);
//   }

//   return uri;
// }
