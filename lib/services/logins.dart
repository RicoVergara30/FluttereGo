// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../model/models.dart';
//
// Future<UserLogin> createAlbum(String username, password) async {
//   final response = await http.post(
//     Uri.parse('http://127.0.0.1:9019/api/v1/log'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       'username': username,
//       'pssword': password,
//     }),
//   );
//
//   if (response.statusCode == 200) {
//     print('success');
//     return UserLogin.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
//   } else {
//     print('Failed');
//     // If the server did not return a 201 CREATED response,
//     // then throw an exception.
//     throw Exception('Failed to create album.');
//   }
// }


