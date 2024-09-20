//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:untitled4/services/logins.dart';
// import '../model/models.dart';
//
// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   final username = TextEditingController();
//   final password = TextEditingController();
//   bool _isLoading = false; // Flag to indicate login in progress
//
//   Future<void> _loginUser() async {
//     setState(() {
//       _isLoading = true; // Set loading indicator to true
//     });
//     try {
//       final UserLogin user = await createAlbum(username.text, password.text);
//       print("Login successful! User: ${user.username}");
//     } catch (error) {
//
//       print("Login failed: $error");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Login failed! Please check your credentials."),
//         ),
//       );
//     } finally {
//       setState(() {
//         _isLoading = false; // Set loading indicator to false after login attempt
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Image.asset(
//             "assets/image/Admiral Long.jpg",
//             width: MediaQuery.of(context).size.width * 0.8,
//             height: MediaQuery.of(context).size.height * 0.3,
//             fit: BoxFit.cover,
//           ),
//           const SizedBox(height: 30),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 40.0),
//             child: TextField(
//               controller: username,
//               decoration: InputDecoration(
//                 labelText: 'Username',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 40.0),
//             child: TextField(
//               controller: password,
//               obscureText: true,
//               decoration: const InputDecoration(
//                 labelText: 'Password',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//           ),
//           const SizedBox(height: 50),
//           _isLoading ? CircularProgressIndicator() :
//           TextButton( // Show loading indicator or login button
//             onPressed: _isLoading ? null : _loginUser, // Disable button while loading
//             child: const Text('Login'),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/models.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  Future<UserLogin> loginUser({required String username, required String password}) async {
    final response = await http.post(
      Uri.parse('http://192.168.120.96:4443/api/v1/log'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return UserLogin.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to login. Error code: ${response.statusCode}');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/image/Admiral Long.jpg",
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.3,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: TextField(
              controller: username,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: TextField(
              controller: password,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
              onPressed: () async {
                try {
                  await loginUser(username: username.text, password: password.text);
                  // Handle successful login
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Success'),
                        content: Text('Login successful.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(context, "/dashboard");
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                  Navigator.pushNamed(context, "/dashboard");
                } on Exception catch (e) {
                  // Handle login error
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text('Login failed. Please try again.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            child: const Text('Login'),
          ),
          ElevatedButton(onPressed: (){}, child: Text('Register'))
        ],
      ),
    );
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }
}





