import 'dart:convert';

import 'package:flutter_app/models/apiModel.dart';
import 'package:http/http.dart';

class ApiProvider {
  final String _url = "http://192.168.128.24:5000/predict/";
  Future<ApiModel> fetchPrediction(username) async {
    Response response = await get(Uri.parse(_url + username));

    if (response.statusCode == 200) {
      ApiModel prediction = ApiModel.fromJson(json.decode(response.body));

      return prediction;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}
