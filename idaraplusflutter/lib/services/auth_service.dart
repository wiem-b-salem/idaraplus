import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  // For Android emulator: use 10.0.2.2 to reach host machine
  // For iOS simulator: use localhost
  // For web: use localhost
  static const String baseUrl = 'http://10.0.2.2:4000';

  static Future<Map<String, dynamic>> login(String email, String password) async {
    final url = '$baseUrl/login';
    print('Connecting to: $url'); // Debug log
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> signup(
    String firstName,
    String lastName,
    String email,
    String password,
    String role,
  ) async {
    final url = '$baseUrl/signup';
    print('Connecting to: $url'); // Debug log
    final response = await http.post(
      Uri.parse('$baseUrl/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
        'role': role,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to signup: ${response.body}');
    }
  }
}