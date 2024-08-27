import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc_apis/Models/post_model.dart';
import 'package:http/http.dart' as http;

class PostRepository {
  List<PostModel> postList = [];
  Future<List<PostModel>> fetchPost() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/comments')).timeout(Duration(seconds: 10));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        // print(data);
        return data.map((e) {
          return PostModel.fromJson(e);
        }).toList();
      }
    } on SocketException {
      throw throw Exception('Socket Exception');
    } on TimeoutException {
      throw Exception('Request Timed Out');
    }
    throw Exception('Error while fetching Data');
  }
}
