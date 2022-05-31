import 'dart:convert';

class ApiModel {
  String prediction;
  String error;

  ApiModel({this.prediction});

  ApiModel.withError(String errorMessage) {
    error = errorMessage;
  }

  factory ApiModel.fromJson(Map<String, dynamic> json) => ApiModel(
        prediction: json["prediction"],
      );
  Map<String, dynamic> toJson() => {"prediction": prediction};
  // ApiModel.fromJson(Map<String, dynamic> json) {
  //   prediction = json['prediction'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['prediction'] = this.prediction;

  //   return data;
  // }
}
