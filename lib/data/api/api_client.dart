import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/post.dart';

class ApiClient {
  ApiClient(this.url);

  final String url;

  Future<List<Post>> getData() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load post');
    }
  }
}
