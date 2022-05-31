import 'dart:convert';

import 'package:flutter_app/models/apiModel.dart';
import 'package:http/http.dart';

class ApiProvider {
  final String _url = "http://192.168.128.24:5000/predict/";
  Future<List<ApiModel>> fetchPrediction(username) async {
    Response res = await get(Uri.parse(_url + username));

    if (res.statusCode == 200) {
      //final body = "[" + jsonDecode(res.body) + "]";
      final body = jsonDecode(res.body);
      //print(body);

      List<ApiModel> posts = body
          .map(
            (dynamic item) => ApiModel.fromJson(item),
          )
          .toList();
      print(posts);
      return body;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}
